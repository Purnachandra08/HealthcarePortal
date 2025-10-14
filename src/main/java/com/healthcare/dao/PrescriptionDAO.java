package com.healthcare.dao;

import com.healthcare.config.DBUtil;
import com.healthcare.model.Prescription;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class PrescriptionDAO {

    public List<Prescription> getByUser(int userId) {
        String sql = "SELECT * FROM prescriptions WHERE user_id = ? ORDER BY generated_at DESC";
        List<Prescription> list = new ArrayList<>();
        try (Connection c = DBUtil.getConnection();
             PreparedStatement ps = c.prepareStatement(sql)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Prescription p = new Prescription();
                    p.setId(rs.getInt("id"));
                    p.setVisitId(rs.getInt("visit_id"));
                    p.setDoctorId(rs.getInt("doctor_id"));
                    p.setUserId(rs.getInt("user_id"));
                    p.setMedicines(rs.getString("medicines"));
                    p.setInstructions(rs.getString("instructions"));
                    p.setGeneratedAt(rs.getTimestamp("generated_at"));
                    p.setPdfPath(rs.getString("pdf_path"));
                    p.setQrCodeText(rs.getString("qr_code_text"));
                    list.add(p);
                }
            }
        } catch (SQLException ex) { ex.printStackTrace(); }
        return list;
    }
}
