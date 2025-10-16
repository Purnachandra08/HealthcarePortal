package com.healthcare.servlets;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.WebServlet;
import java.io.*;
import java.sql.*;
import java.time.LocalDate;
import java.time.LocalTime;
import java.time.format.DateTimeFormatter;

import com.healthcare.config.DBUtil;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/GetSlotsServlet")
public class GetSlotsServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        JSONArray slotsArray = new JSONArray();

        int doctorId = 0;
        try {
            doctorId = Integer.parseInt(request.getParameter("doctorId"));
        } catch (NumberFormatException e) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            response.getWriter().write("{\"error\":\"Invalid doctorId\"}");
            return;
        }

        DateTimeFormatter dateFormatter = DateTimeFormatter.ofPattern("dd-MMM-yyyy");
        DateTimeFormatter timeFormatter = DateTimeFormatter.ofPattern("hh:mm a");

        String sql = "SELECT s.id, s.slot_date, s.start_time, s.end_time, s.max_capacity, " +
                     "(SELECT COUNT(*) FROM bookings b WHERE b.slot_id = s.id AND b.status='BOOKED') AS booked_count " +
                     "FROM slots s " +
                     "WHERE s.doctor_id = ? AND s.slot_date >= CURDATE() " +
                     "ORDER BY s.slot_date, s.start_time";

        try (Connection con = DBUtil.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, doctorId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                int maxCapacity = rs.getInt("max_capacity");
                int bookedCount = rs.getInt("booked_count");

                if (bookedCount >= maxCapacity) continue; // Skip full slots

                JSONObject slot = new JSONObject();
                LocalDate slotDate = rs.getDate("slot_date").toLocalDate();
                LocalTime startTime = rs.getTime("start_time").toLocalTime();
                LocalTime endTime = rs.getTime("end_time").toLocalTime();
                int available = maxCapacity - bookedCount;

                slot.put("id", rs.getInt("id"));
                slot.put("label", slotDate.format(dateFormatter) + " " +
                        startTime.format(timeFormatter) + " - " +
                        endTime.format(timeFormatter) + " | Available: " + available);

                slotsArray.put(slot);
            }

        } catch (Exception e) {
            e.printStackTrace();
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"Server error\"}");
            return;
        }

        response.getWriter().write(slotsArray.toString());
    }
}
