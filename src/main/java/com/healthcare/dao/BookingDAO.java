package com.healthcare.dao;

import com.healthcare.config.DBUtil;
import com.healthcare.model.Booking;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAO {

    // create booking, check slot capacity before insertion
    public boolean createBooking(Booking b) throws SQLException {
        // 1. Get slot capacity
        String slotSql = "SELECT max_capacity FROM slots WHERE id = ?";
        String countSql = "SELECT COUNT(*) FROM bookings WHERE slot_id = ? AND status = 'BOOKED'";
        String insertSql = "INSERT INTO bookings (user_id, doctor_id, slot_id, booking_time, status, notes) VALUES (?,?,?,?,?,?)";

        try (Connection c = DBUtil.getConnection()) {
            c.setAutoCommit(false);
            try (PreparedStatement psSlot = c.prepareStatement(slotSql)) {
                psSlot.setInt(1, b.getSlotId());
                try (ResultSet rs = psSlot.executeQuery()) {
                    if (!rs.next()) { c.rollback(); return false; }
                    int maxCapacity = rs.getInt("max_capacity");
                    try (PreparedStatement psCount = c.prepareStatement(countSql)) {
                        psCount.setInt(1, b.getSlotId());
                        try (ResultSet rs2 = psCount.executeQuery()) {
                            int count = 0;
                            if (rs2.next()) count = rs2.getInt(1);
                            if (count >= maxCapacity) { c.rollback(); return false; }
                            try (PreparedStatement psIns = c.prepareStatement(insertSql)) {
                                psIns.setInt(1, b.getUserId());
                                psIns.setInt(2, b.getDoctorId());
                                psIns.setInt(3, b.getSlotId());
                                psIns.setTimestamp(4, new Timestamp(System.currentTimeMillis()));
                                psIns.setString(5, "BOOKED");
                                psIns.setString(6, b.getNotes());
                                int r = psIns.executeUpdate();
                                c.commit();
                                return r == 1;
                            }
                        }
                    }
                }
            } catch (SQLException ex) {
                c.rollback();
                throw ex;
            } finally {
                c.setAutoCommit(true);
            }
        }
    }

    public List<Booking> getBookingsByUser(int userId) {
        String sql = "SELECT b.*, s.slot_date, s.start_time, s.end_time, d.name as doctor_name FROM bookings b " +
                     "JOIN slots s ON b.slot_id = s.id " +
                     "JOIN doctors d ON b.doctor_id = d.id " +
                     "WHERE b.user_id = ? ORDER BY s.slot_date DESC, s.start_time";
        List<Booking> list = new ArrayList<>();
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Booking b = new Booking();
                    b.setId(rs.getInt("id"));
                    b.setUserId(rs.getInt("user_id"));
                    b.setDoctorId(rs.getInt("doctor_id"));
                    b.setSlotId(rs.getInt("slot_id"));
                    b.setBookingTime(rs.getTimestamp("booking_time"));
                    b.setStatus(rs.getString("status"));
                    b.setNotes(rs.getString("notes"));
                    list.add(b);
                }
            }
        } catch (SQLException ex) { ex.printStackTrace(); }
        return list;
    }

    public boolean cancelBooking(int bookingId, int userId) {
        String sql = "UPDATE bookings SET status = 'CANCELLED' WHERE id = ? AND user_id = ? AND status = 'BOOKED'";
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, bookingId);
            ps.setInt(2, userId);
            int r = ps.executeUpdate();
            return r == 1;
        } catch (SQLException ex) { ex.printStackTrace(); }
        return false;
    }
}
