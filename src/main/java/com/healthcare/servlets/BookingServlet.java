package com.healthcare.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.healthcare.config.DBUtil;

public class BookingServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || !"user".equals(session.getAttribute("role"))) {
            res.sendRedirect("login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        int doctorId = Integer.parseInt(req.getParameter("doctor_id"));
        int slotId = Integer.parseInt(req.getParameter("slot_id"));
        String notes = req.getParameter("notes");

        String query = "INSERT INTO bookings (user_id, doctor_id, slot_id, notes) VALUES (?, ?, ?, ?)";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {

            ps.setInt(1, userId);
            ps.setInt(2, doctorId);
            ps.setInt(3, slotId);
            ps.setString(4, notes);

            int result = ps.executeUpdate();
            if (result > 0) {
                res.sendRedirect("dashboard.jsp?msg=Booking successful!");
            } else {
                res.sendRedirect("dashboard.jsp?error=Booking failed!");
            }

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("dashboard.jsp?error=Server error!");
        }
    }
}
