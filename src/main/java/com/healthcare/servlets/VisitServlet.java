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

public class VisitServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || session.getAttribute("userId") == null) {
            res.sendRedirect("login.jsp");
            return;
        }

        int bookingId = Integer.parseInt(req.getParameter("bookingId"));
        String status = req.getParameter("status"); // e.g., "Completed" or "Cancelled"

        String query = "UPDATE bookings SET status = ? WHERE id = ?";

        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, status);
            ps.setInt(2, bookingId);
            ps.executeUpdate();

            res.sendRedirect("doctor/dashboard.jsp");
        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("error", "Failed to update visit!");
            req.getRequestDispatcher("doctor/dashboard.jsp").forward(req, res);
        }
    }
}
