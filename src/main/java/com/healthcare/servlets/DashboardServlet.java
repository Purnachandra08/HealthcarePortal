package com.healthcare.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.util.*;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import com.healthcare.config.DBUtil;

public class DashboardServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || !"user".equals(session.getAttribute("role"))) {
            res.sendRedirect("../login.jsp"); // adjust path if needed
            return;
        }

        int userId = (int) session.getAttribute("userId");

        try (Connection con = DBUtil.getConnection()) {

            // Fetch active doctors
            List<Map<String, String>> doctors = new ArrayList<>();
            try (Statement st = con.createStatement();
                 ResultSet rs = st.executeQuery("SELECT id, name, specialization, bio FROM doctors WHERE is_active=1")) {
                while (rs.next()) {
                    Map<String, String> d = new HashMap<>();
                    d.put("id", String.valueOf(rs.getInt("id")));
                    d.put("name", rs.getString("name"));
                    d.put("specialization", rs.getString("specialization"));
                    d.put("bio", rs.getString("bio"));
                    doctors.add(d);
                }
            }
            req.setAttribute("doctors", doctors);

            // Fetch user bookings
            List<Map<String, String>> bookings = new ArrayList<>();
            String bookingQuery = "SELECT b.id, d.name AS doctor, b.status, b.booking_time " +
                    "FROM bookings b JOIN doctors d ON b.doctor_id=d.id " +
                    "WHERE b.user_id=? ORDER BY b.booking_time DESC";
            try (PreparedStatement ps = con.prepareStatement(bookingQuery)) {
                ps.setInt(1, userId);
                try (ResultSet rs2 = ps.executeQuery()) {
                    while (rs2.next()) {
                        Map<String, String> b = new HashMap<>();
                        b.put("id", String.valueOf(rs2.getInt("id")));
                        b.put("doctor", rs2.getString("doctor"));
                        b.put("status", rs2.getString("status"));
                        b.put("booking_time", rs2.getString("booking_time"));
                        bookings.add(b);
                    }
                }
            }
            req.setAttribute("bookings", bookings);

            // Forward to user dashboard JSP
            req.getRequestDispatcher("user/dashboard.jsp").forward(req, res);

        } catch (Exception e) {
            e.printStackTrace();
            res.sendRedirect("../login.jsp?error=Session expired!");
        }
    }
}
