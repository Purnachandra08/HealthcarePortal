package com.healthcare.dao;

import com.healthcare.config.DBUtil;
import com.healthcare.model.Slot;

import java.sql.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class SlotDAO {

    // get slots for a doctor for a given date
    public List<Slot> getSlotsByDoctorAndDate(int doctorId, Date date) {
        String sql = "SELECT * FROM slots WHERE doctor_id = ? AND slot_date = ? ORDER BY start_time";
        List<Slot> list = new ArrayList<>();
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, doctorId);
            ps.setDate(2, new java.sql.Date(date.getTime()));
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Slot s = new Slot();
                    s.setId(rs.getInt("id"));
                    s.setDoctorId(rs.getInt("doctor_id"));
                    s.setSlotDate(rs.getDate("slot_date"));
                    s.setStartTime(rs.getTime("start_time"));
                    s.setEndTime(rs.getTime("end_time"));
                    s.setMaxCapacity(rs.getInt("max_capacity"));
                    s.setCreatedAt(rs.getTimestamp("created_at"));
                    list.add(s);
                }
            }
        } catch (SQLException ex) { ex.printStackTrace(); }
        return list;
    }

    public Slot findById(int slotId) {
        String sql = "SELECT * FROM slots WHERE id = ?";
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, slotId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Slot s = new Slot();
                    s.setId(rs.getInt("id"));
                    s.setDoctorId(rs.getInt("doctor_id"));
                    s.setSlotDate(rs.getDate("slot_date"));
                    s.setStartTime(rs.getTime("start_time"));
                    s.setEndTime(rs.getTime("end_time"));
                    s.setMaxCapacity(rs.getInt("max_capacity"));
                    s.setCreatedAt(rs.getTimestamp("created_at"));
                    return s;
                }
            }
        } catch (SQLException ex) { ex.printStackTrace(); }
        return null;
    }

    // count booked slots for slot_id with status BOOKED
    public int countBookingsForSlot(int slotId) {
        String sql = "SELECT COUNT(*) FROM bookings WHERE slot_id = ? AND status = 'BOOKED'";
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, slotId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) return rs.getInt(1);
            }
        } catch (SQLException ex) { ex.printStackTrace(); }
        return 0;
    }
}
