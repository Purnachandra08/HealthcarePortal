package com.healthcare.servlets;

import com.healthcare.config.DBUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

@WebServlet("/UpdateProfileServlet")
public class UpdateProfileServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp)
            throws ServletException, IOException {

        HttpSession session = req.getSession(false);
        if (session == null || !"user".equals(session.getAttribute("role"))) {
            resp.sendRedirect(req.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (int) session.getAttribute("userId");
        String name = req.getParameter("name");
        String phone = req.getParameter("phone");
        String gender = req.getParameter("gender");
        String dob = req.getParameter("dob"); // YYYY-MM-DD or empty

        // Server-side validation
        if (name == null || name.trim().length() < 2) {
            req.setAttribute("error", "Name is required (min 2 chars).");
            req.getRequestDispatcher("/patient/profile.jsp").forward(req, resp);
            return;
        }

        try (Connection con = DBUtil.getConnection()) {
            String sql = "UPDATE users SET name=?, phone=?, gender=?, dob=? WHERE id=?";
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, name.trim());
            ps.setString(2, (phone != null && phone.trim().length() > 0) ? phone.trim() : null);
            ps.setString(3, (gender != null && gender.length() > 0) ? gender : null);

            if (dob != null && dob.trim().length() > 0) {
                ps.setDate(4, java.sql.Date.valueOf(dob));
            } else {
                ps.setNull(4, java.sql.Types.DATE);
            }

            ps.setInt(5, userId);
            int updated = ps.executeUpdate();

            if (updated > 0) {
                // Update session name so UI reflects change immediately
                session.setAttribute("userName", name.trim());
                // Redirect with success flag to show toast
                resp.sendRedirect(req.getContextPath() + "/patient/profile.jsp?success=1");
            } else {
                req.setAttribute("error", "No changes made.");
                req.getRequestDispatcher("/patient/profile.jsp").forward(req, resp);
            }

        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("error", "Database error: " + e.getMessage());
            req.getRequestDispatcher("/patient/profile.jsp").forward(req, resp);
        }
    }
}
