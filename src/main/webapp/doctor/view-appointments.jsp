<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*,java.sql.*,java.util.*" %>
<%@ page import="com.healthcare.config.DBUtil" %>

<%
    if(session == null || !"doctor".equals(session.getAttribute("role"))){
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    int doctorId = (int) session.getAttribute("userId");
%>

<html>
<head>
    <title>View Appointments</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dark-theme.css"/>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #1f1f2e; color: #fff; margin: 0; }
        header { padding: 20px; text-align: center; background: #28293d; }
        header h1 { margin: 0; color: #00d4ff; }
        table { width: 90%; margin: 30px auto; border-collapse: collapse; background: #28293d; border-radius: 10px; overflow: hidden; }
        th, td { padding: 15px; text-align: left; border-bottom: 1px solid #444; }
        th { background-color: #1f1f2e; color: #00d4ff; }
        tr:hover { background-color: #3a3a5c; }
        a.button { display: inline-block; padding: 10px 20px; margin: 20px; background: #00d4ff; color: #1f1f2e; text-decoration: none; border-radius: 5px; transition: 0.3s; }
        a.button:hover { background: #0096c7; }
        footer { text-align: center; margin: 40px 0 20px 0; font-size: 14px; color: #888; }
    </style>
</head>
<body>
<header>
    <h1>Appointments for Dr. <%= session.getAttribute("userName") %></h1>
</header>

<table>
    <tr>
        <th>Patient Name</th>
        <th>Date</th>
        <th>Slot</th>
        <th>Status</th>
        <th>Notes</th>
    </tr>
<%
    try(Connection con = DBUtil.getConnection()){
        String sql = "SELECT b.id, u.name AS patient, b.booking_time, " +
                     "s.slot_date, s.start_time, s.end_time, b.status, b.notes " +
                     "FROM bookings b " +
                     "JOIN users u ON b.user_id = u.id " +
                     "JOIN slots s ON b.slot_id = s.id " +
                     "WHERE b.doctor_id=? ORDER BY b.booking_time DESC";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, doctorId);
        ResultSet rs = ps.executeQuery();

        while(rs.next()){
            String slot = rs.getDate("slot_date") + " " +
                          rs.getTime("start_time") + " - " + rs.getTime("end_time");
%>
<tr>
    <td><%= rs.getString("patient") %></td>
    <td><%= rs.getDate("slot_date") %></td>
    <td><%= slot %></td>
    <td><%= rs.getString("status") %></td>
    <td><%= rs.getString("notes") != null ? rs.getString("notes") : "-" %></td>
</tr>
<%
        }
    } catch(Exception e){
        e.printStackTrace();
%>
<tr>
    <td colspan="5" style="text-align:center;">Error loading appointments.</td>
</tr>
<%
    }
%>
</table>

<div style="text-align:center;">
    <a href="doctor-dashboard.jsp" class="button">Back to Dashboard</a>
</div>

<footer>
    &copy; 2025 Healthcare Portal. All rights reserved.
</footer>
</body>
</html>
