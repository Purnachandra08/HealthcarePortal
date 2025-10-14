package com.healthcare.dao;

import com.healthcare.config.DBUtil;
import com.healthcare.model.User;
import com.healthcare.utils.PasswordUtil;

import java.sql.*;

public class UserDAO {

    public boolean createUser(User u) {
        String sql = "INSERT INTO users (name, email, password_hash, phone, dob, gender) VALUES (?,?,?,?,?,?)";
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            ps.setString(1, u.getName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPasswordHash());
            ps.setString(4, u.getPhone());
            if (u.getDob() != null) ps.setDate(5, new java.sql.Date(u.getDob().getTime()));
            else ps.setNull(5, Types.DATE);
            ps.setString(6, u.getGender());
            int r = ps.executeUpdate();
            return r == 1;
        } catch (SQLException ex) {
            ex.printStackTrace();
            return false;
        }
    }

    public User findByEmail(String email) {
        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("id"));
                    u.setName(rs.getString("name"));
                    u.setEmail(rs.getString("email"));
                    u.setPasswordHash(rs.getString("password_hash"));
                    u.setPhone(rs.getString("phone"));
                    Date dob = rs.getDate("dob");
                    if (dob != null) u.setDob(new java.util.Date(dob.getTime()));
                    u.setGender(rs.getString("gender"));
                    u.setCreatedAt(rs.getTimestamp("created_at"));
                    return u;
                }
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return null;
    }

    public User findById(int id) {
        String sql = "SELECT * FROM users WHERE id = ?";
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User u = new User();
                    u.setId(rs.getInt("id"));
                    u.setName(rs.getString("name"));
                    u.setEmail(rs.getString("email"));
                    u.setPasswordHash(rs.getString("password_hash"));
                    u.setPhone(rs.getString("phone"));
                    Date dob = rs.getDate("dob");
                    if (dob != null) u.setDob(new java.util.Date(dob.getTime()));
                    u.setGender(rs.getString("gender"));
                    u.setCreatedAt(rs.getTimestamp("created_at"));
                    return u;
                }
            }
        } catch (SQLException ex) { ex.printStackTrace(); }
        return null;
    }

    // verify credentials (email + password plain)
    public User authenticate(String email, String plainPassword) {
        User u = findByEmail(email);
        if (u == null) return null;
        if (PasswordUtil.verify(plainPassword, u.getPasswordHash())) return u;
        return null;
    }
}
