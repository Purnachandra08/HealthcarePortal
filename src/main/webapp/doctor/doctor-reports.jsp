<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*, java.util.*" %>

<%
    if (session == null || !"doctor".equals(session.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    List<Map<String,String>> reports = new ArrayList<>();
    Map<String,String> r1 = new HashMap<>(); r1.put("patientName","John Doe"); r1.put("diagnosis","Flu"); r1.put("date","2025-10-15"); reports.add(r1);
    Map<String,String> r2 = new HashMap<>(); r2.put("patientName","Jane Smith"); r2.put("diagnosis","Diabetes"); r2.put("date","2025-10-14"); reports.add(r2);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Patient Reports</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dark-theme.css"/>
    <style>
        body { font-family:"Poppins",sans-serif; background:#0d1117; color:#e6e6e6; display:flex; flex-direction:column; min-height:100vh; margin:0; }
        header { background: rgba(30,30,45,0.7); backdrop-filter:blur(10px); color:#00d4ff; padding:15px 30px; display:flex; justify-content:space-between; align-items:center; font-size:22px; font-weight:600; border-bottom:1px solid rgba(0,212,255,0.3); }
        header a { background:#00d4ff; color:#0d1117; padding:8px 18px; margin-left:10px; border-radius:20px; font-weight:500; text-decoration:none; }
        header a:hover { background:#0096c7; }
        .container { max-width:900px; margin:50px auto; padding:20px; flex-grow:1; }
        h2 { color:#00d4ff; text-align:center; margin-bottom:20px; }
        table { width:100%; border-collapse:collapse; background: rgba(40,40,65,0.8); border-radius:10px; overflow:hidden; }
        th, td { padding:12px 15px; text-align:left; border-bottom:1px solid rgba(255,255,255,0.1); }
        th { background: rgba(0,212,255,0.2); color:#00d4ff; }
        tr:hover { background: rgba(0,212,255,0.1); }
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

<div class="container">
    <h2>Patient Reports</h2>
    <table>
        <tr>
            <th>Patient Name</th>
            <th>Diagnosis</th>
            <th>Date</th>
        </tr>
        <% for(Map<String,String> report : reports){ %>
        <tr>
            <td><%= report.get("patientName") %></td>
            <td><%= report.get("diagnosis") %></td>
            <td><%= report.get("date") %></td>
        </tr>
        <% } %>
    </table>
</div>

<footer>
    &copy; 2025 Healthcare Portal | All rights reserved.
</footer>

</body>
</html>
