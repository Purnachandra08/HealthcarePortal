package com.healthcare.dao;

import com.healthcare.config.DBUtil;
import com.healthcare.model.Doctor;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class DoctorDAO {

    public List<Doctor> listActiveDoctors() {
        String sql = "SELECT id, name, email, specialization, phone, bio, created_at, is_active FROM doctors WHERE is_active = TRUE ORDER BY name";
        List<Doctor> list = new ArrayList<>();
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                Doctor d = new Doctor();
                d.setId(rs.getInt("id"));
                d.setName(rs.getString("name"));
                d.setEmail(rs.getString("email"));
                d.setSpecialization(rs.getString("specialization"));
                d.setPhone(rs.getString("phone"));
                d.setBio(rs.getString("bio"));
                d.setCreatedAt(rs.getTimestamp("created_at"));
                d.setActive(rs.getBoolean("is_active"));
                list.add(d);
            }
        } catch (SQLException ex) { ex.printStackTrace(); }
        return list;
    }

    public Doctor findById(int id) {
        String sql = "SELECT * FROM doctors WHERE id = ?";
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, id);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    Doctor d = new Doctor();
                    d.setId(rs.getInt("id"));
                    d.setName(rs.getString("name"));
                    d.setEmail(rs.getString("email"));
                    d.setSpecialization(rs.getString("specialization"));
                    d.setPhone(rs.getString("phone"));
                    d.setBio(rs.getString("bio"));
                    d.setCreatedAt(rs.getTimestamp("created_at"));
                    d.setActive(rs.getBoolean("is_active"));
                    return d;
                }
            }
        } catch (SQLException ex) { ex.printStackTrace(); }
        return null;
    }
}
