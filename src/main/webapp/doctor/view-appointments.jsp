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
        body { font-family:'Segoe UI',sans-serif; background-color:#1f1f2e; color:#fff; margin:0; display:flex; flex-direction:column; min-height:100vh; }
        header { background: rgba(30,30,45,0.7); backdrop-filter:blur(10px); color:#00d4ff; padding:15px 30px; display:flex; justify-content:space-between; align-items:center; font-size:22px; font-weight:600; border-bottom:1px solid rgba(0,212,255,0.3); }
        header a { background:#00d4ff; color:#0d1117; padding:8px 18px; margin-left:10px; border-radius:20px; font-weight:500; text-decoration:none; }
        header a:hover { background:#0096c7; }
        table { width:90%; margin:30px auto; border-collapse:collapse; background:#28293d; border-radius:10px; overflow:hidden; }
        th, td { padding:15px; text-align:left; border-bottom:1px solid #444; }
        th { background-color:#1f1f2e; color:#00d4ff; }
        tr:hover { background-color:#3a3a5c; }
        a.button { display:inline-block; padding:10px 20px; margin:20px; background:#00d4ff; color:#1f1f2e; text-decoration:none; border-radius:5px; transition:0.3s; }
        a.button:hover { background:#0096c7; }
        footer { text-align:center; padding:15px 0; background: rgba(20,20,35,0.9); color:#888; font-size:14px; border-top:1px solid rgba(255,255,255,0.05); margin-top:auto; }
    </style>
</head>
<body>

<header>
    <span>Welcome Dr. <%= session.getAttribute("userName") %></span>
    <div>
        <a href="doctor-dashboard.jsp">Dashboard</a>
        <a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>
    </div>
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
        String sql = "SELECT b.id, u.name AS patient, b.booking_time, s.slot_date, s.start_time, s.end_time, b.status, b.notes " +
                     "FROM bookings b JOIN users u ON b.user_id = u.id JOIN slots s ON b.slot_id = s.id " +
                     "WHERE b.doctor_id=? ORDER BY b.booking_time DESC";

        PreparedStatement ps = con.prepareStatement(sql);
        ps.setInt(1, doctorId);
        ResultSet rs = ps.executeQuery();

        while(rs.next()){
            String slot = rs.getDate("slot_date") + " " + rs.getTime("start_time") + " - " + rs.getTime("end_time");
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
    &copy; 2025 Healthcare Portal | All rights reserved.
</footer>

</body>
</html>
