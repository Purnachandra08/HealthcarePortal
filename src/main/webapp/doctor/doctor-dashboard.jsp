<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*" %>

<%
    if(session == null || !"doctor".equals(session.getAttribute("role"))){
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<html>
<head>
    <title>Doctor Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dark-theme.css"/>
    <style>
        body { font-family: 'Segoe UI', sans-serif; background-color: #1f1f2e; color: #fff; margin: 0; }
        header { padding: 20px; text-align: center; background: #28293d; }
        header h1 { margin: 0; color: #00d4ff; }
        nav { display: flex; justify-content: center; gap: 20px; margin: 20px 0; }
        nav a { color: #00d4ff; text-decoration: none; padding: 10px 20px; border-radius: 5px; transition: background 0.3s; }
        nav a:hover { background: #00d4ff; color: #1f1f2e; }
        .cards { display: flex; justify-content: center; flex-wrap: wrap; gap: 20px; margin: 30px; }
        .card { background: #28293d; padding: 30px; border-radius: 15px; box-shadow: 0 5px 20px rgba(0,0,0,0.5); width: 250px; text-align: center; transition: transform 0.3s; }
        .card:hover { transform: translateY(-10px); box-shadow: 0 10px 30px rgba(0,0,0,0.7); }
        .card h2 { margin-bottom: 15px; color: #00d4ff; }
        footer { text-align: center; margin: 40px 0 20px 0; font-size: 14px; color: #888; }
    </style>
</head>
<body>
<header>
    <h1>Welcome Dr. <%= session.getAttribute("userName") %></h1>
</header>

<nav>
    <a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>
    <a href="view-appointments.jsp">View Appointments</a>
</nav>

<div class="cards">
    <div class="card">
        <h2>Total Appointments</h2>
        <p>Click below to see all bookings.</p>
        <a href="view-appointments.jsp" style="color:#00d4ff; text-decoration:underline;">View</a>
    </div>

    <div class="card">
        <h2>Profile</h2>
        <p>Update your personal information and contact details.</p>
        <a href="#" style="color:#00d4ff; text-decoration:underline;">Edit</a>
    </div>

    <div class="card">
        <h2>Reports</h2>
        <p>View patient reports and history.</p>
        <a href="#" style="color:#00d4ff; text-decoration:underline;">View</a>
    </div>
</div>

<footer>
    &copy; 2025 Healthcare Portal. All rights reserved.
</footer>
</body>
</html>
