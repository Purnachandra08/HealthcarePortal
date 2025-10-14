package com.healthcare.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.healthcare.config.DBUtil;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/AuthServlet") // Servlet mapping
public class AuthServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role"); // "user", "doctor", "admin"

        try (Connection con = DBUtil.getConnection()) {

            String query = "";
            switch (role) {
                case "user": query = "SELECT * FROM users WHERE email = ?"; break;
                case "doctor": query = "SELECT * FROM doctors WHERE email = ?"; break;
                case "admin": query = "SELECT * FROM admins WHERE username = ?"; break;
                default:
                    req.setAttribute("error", "Invalid role!");
                    req.getRequestDispatcher("login.jsp").forward(req, res);
                    return;
            }

            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, email);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                String hashed = rs.getString("password_hash");
                if (BCrypt.checkpw(password, hashed)) {
                    HttpSession session = req.getSession();
                    session.setAttribute("role", role);
                    session.setAttribute("userId", rs.getInt("id"));
                    session.setAttribute("userName", rs.getString("name"));

                    // Redirect to correct dashboard based on role
                    switch (role) {
                        case "user":
                            res.sendRedirect(req.getContextPath() + "/patient/patient-dashboard.jsp");
                            break;
                        case "doctor":
                            res.sendRedirect(req.getContextPath() + "/doctor/doctor-dashboard.jsp");
                            break;
                        case "admin":
                            res.sendRedirect(req.getContextPath() + "/admin/admin-dashboard.jsp");
                            break;
                    }
                    return;
                }
            }

            req.setAttribute("error", "Invalid credentials!");
            req.getRequestDispatcher("login.jsp").forward(req, res);

        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("error", "Database error!");
            req.getRequestDispatcher("login.jsp").forward(req, res);
        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "Server error!");
            req.getRequestDispatcher("login.jsp").forward(req, res);
        }
    }
}
