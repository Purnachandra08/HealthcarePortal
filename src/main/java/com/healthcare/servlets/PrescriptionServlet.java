package com.healthcare.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.healthcare.config.DBUtil;

public class PrescriptionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("role") == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        int doctorId = (int) session.getAttribute("userId");
        int bookingId = Integer.parseInt(req.getParameter("bookingId"));
        String prescription = req.getParameter("prescription");

        String query = "INSERT INTO prescriptions (booking_id, doctor_id, prescription_text) VALUES (?, ?, ?)";

        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, bookingId);
            ps.setInt(2, doctorId);
            ps.setString(3, prescription);
            ps.executeUpdate();

            res.sendRedirect("doctor/dashboard.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("error", "Failed to add prescription!");
            req.getRequestDispatcher("doctor/dashboard.jsp").forward(req, res);
        }
    }
}
