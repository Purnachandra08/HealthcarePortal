package com.healthcare.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.healthcare.config.DBUtil;

@WebServlet("/patient/BookingServlet")
public class BookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || !"user".equals(session.getAttribute("role"))) {
            res.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int userId, doctorId, slotId;
        try {
            userId = (int) session.getAttribute("userId");
            doctorId = Integer.parseInt(req.getParameter("doctor_id"));
            slotId = Integer.parseInt(req.getParameter("slot_id"));
        } catch (NumberFormatException e) {
            session.setAttribute("error", "Invalid input!");
            res.sendRedirect(req.getContextPath() + "/patient/book-slot.jsp");
            return;
        }

        String notes = req.getParameter("notes");

        try (Connection con = DBUtil.getConnection()) {

            // Check slot availability dynamically from bookings table
            String checkQuery = "SELECT max_capacity, " +
                    "(SELECT COUNT(*) FROM bookings WHERE slot_id=? AND status='BOOKED') AS booked_count " +
                    "FROM slots WHERE id = ?";
            try (PreparedStatement ps = con.prepareStatement(checkQuery)) {
                ps.setInt(1, slotId);
                ps.setInt(2, slotId);
                ResultSet rs = ps.executeQuery();

                if (!rs.next()) {
                    session.setAttribute("error", "Invalid slot selected!");
                    res.sendRedirect(req.getContextPath() + "/patient/book-slot.jsp");
                    return;
                }

                int maxCapacity = rs.getInt("max_capacity");
                int bookedCount = rs.getInt("booked_count");

                if (bookedCount >= maxCapacity) {
                    session.setAttribute("error", "This slot is already full!");
                    res.sendRedirect(req.getContextPath() + "/patient/book-slot.jsp");
                    return;
                }
            }

            // Insert booking
            String insertQuery = "INSERT INTO bookings (user_id, doctor_id, slot_id, notes) VALUES (?, ?, ?, ?)";
            try (PreparedStatement ps = con.prepareStatement(insertQuery)) {
                ps.setInt(1, userId);
                ps.setInt(2, doctorId);
                ps.setInt(3, slotId);
                ps.setString(4, notes);

                int result = ps.executeUpdate();

                if (result > 0) {
                    session.setAttribute("msg", "Booking successful!");
                    res.sendRedirect(req.getContextPath() + "/patient/book-slot.jsp");
                } else {
                    session.setAttribute("error", "Booking failed!");
                    res.sendRedirect(req.getContextPath() + "/patient/book-slot.jsp");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            session.setAttribute("error", "Server error!");
            res.sendRedirect(req.getContextPath() + "/patient/book-slot.jsp");
        }
    }
}
