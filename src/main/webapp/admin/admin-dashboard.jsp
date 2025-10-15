<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*" %>

<%
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dark-theme.css"/>
    <style>
        body {
            font-family: "Poppins", sans-serif;
            background: linear-gradient(135deg, #0d1117, #161b22);
            color: #e6e6e6;
            margin: 0;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }
        header {
            background: rgba(40, 40, 65, 0.95);
            color: #00d4ff;
            padding: 15px 30px;
            display: flex;
            justify-content: space-between;
            align-items: center;
            border-bottom: 1px solid rgba(0, 212, 255, 0.3);
        }
        header h1 { font-size: 20px; }
        header a {
            color: #0d1117;
            background: #00d4ff;
            padding: 8px 16px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
            margin-left: 10px;
            transition: 0.3s ease;
        }
        header a:hover { background: #0096c7; }

        main {
            flex: 1;
            padding: 40px;
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
            gap: 25px;
        }

        .card {
            background: rgba(30, 30, 45, 0.85);
            border-radius: 12px;
            padding: 25px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.4);
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 212, 255, 0.4);
        }

        .card h3 {
            color: #00d4ff;
            margin-bottom: 10px;
        }

        .card a {
            display: inline-block;
            margin-top: 10px;
            background: #00d4ff;
            color: #0d1117;
            padding: 8px 16px;
            border-radius: 6px;
            text-decoration: none;
            font-weight: 500;
        }

        .card a:hover {
            background: #0096c7;
        }

        footer {
            text-align: center;
            padding: 15px;
            background: rgba(20, 20, 35, 0.9);
            color: #999;
            font-size: 14px;
            border-top: 1px solid rgba(255, 255, 255, 0.05);
        }
    </style>
</head>
<body>

<header>
    <h1>Welcome, Admin <%= session.getAttribute("userName") %></h1>
    <div>
        <a href="admin-dashboard.jsp">Dashboard</a>
        <a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>
    </div>
</header>

<main>
    <div class="card">
        <h3>Manage Doctors</h3>
        <p>View, add, or remove doctors in the system.</p>
        <a href="manage-doctors.jsp">Open</a>
    </div>

    <div class="card">
        <h3>Manage Patients</h3>
        <p>Access and manage patient records.</p>
        <a href="manage-patients.jsp">Open</a>
    </div>

    <div class="card">
        <h3>View Appointments</h3>
        <p>Check all scheduled doctor-patient appointments.</p>
        <a href="view-appointments.jsp">Open</a>
    </div>

    <div class="card">
        <h3>Profile Settings</h3>
        <p>Update admin details or change password.</p>
        <a href="profile-settings.jsp">Open</a>
    </div>
</main>

<footer>
    &copy; 2025 Healthcare Portal | Admin Control Panel
</footer>

</body>
</html>
