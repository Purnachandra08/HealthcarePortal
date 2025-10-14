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

public class SlotServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        int doctorId = (int) session.getAttribute("userId");
        String slot = req.getParameter("slot");
        String date = req.getParameter("date");

        String query = "INSERT INTO slots (doctor_id, date, slot_time) VALUES (?, ?, ?)";

        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setInt(1, doctorId);
            ps.setString(2, date);
            ps.setString(3, slot);
            ps.executeUpdate();

            res.sendRedirect("doctor/dashboard.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("error", "Failed to add slot!");
            req.getRequestDispatcher("doctor/dashboard.jsp").forward(req, res);
        }
    }
}
