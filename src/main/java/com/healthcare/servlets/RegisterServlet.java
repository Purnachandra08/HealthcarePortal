package com.healthcare.servlets;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import com.healthcare.config.DBUtil;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/RegisterServlet") // Servlet mapping
public class RegisterServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String role = req.getParameter("role"); // "user", "doctor", "admin"

        if (name == null || email == null || password == null || role == null) {
            req.setAttribute("error", "All fields are required!");
            req.getRequestDispatcher("register.jsp").forward(req, res);
            return;
        }

        String hashedPassword = BCrypt.hashpw(password, BCrypt.gensalt());

        String query = "";
        switch (role) {
            case "user":
                query = "INSERT INTO users (name, email, password_hash) VALUES (?, ?, ?)";
                break;
            case "doctor":
                query = "INSERT INTO doctors (name, email, password_hash) VALUES (?, ?, ?)";
                break;
            case "admin":
                query = "INSERT INTO admins (username, password_hash) VALUES (?, ?)";
                break;
            default:
                req.setAttribute("error", "Invalid role!");
                req.getRequestDispatcher("register.jsp").forward(req, res);
                return;
        }

        try (Connection con = DBUtil.getConnection()) {
            PreparedStatement ps = con.prepareStatement(query);
            ps.setString(1, name);
            ps.setString(2, email);
            if (!role.equals("admin")) {
                ps.setString(3, hashedPassword);
            }
            ps.executeUpdate();

            // After registration, redirect to login page
            res.sendRedirect(req.getContextPath() + "/login.jsp");

        } catch (SQLException e) {
            e.printStackTrace();
            req.setAttribute("error", "Database error! Maybe email/username already exists.");
            req.getRequestDispatcher("register.jsp").forward(req, res);
        }
    }
}
