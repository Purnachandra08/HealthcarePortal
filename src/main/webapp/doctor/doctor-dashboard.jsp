<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*" %>

<%
    if (session == null || !"doctor".equals(session.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Doctor Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dark-theme.css"/>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: "Poppins", sans-serif;
            background: radial-gradient(circle at top left, #0d1117, #161b22);
            color: #e6e6e6;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Header with Home and Logout buttons */
        header {
            background: rgba(30, 30, 45, 0.7);
            backdrop-filter: blur(10px);
            color: #00d4ff;
            padding: 15px 30px; /* reduced padding for smaller header */
            display: flex;
            justify-content: space-between;
            align-items: center;
            font-size: 22px; /* smaller font */
            font-weight: 600;
            letter-spacing: 0.3px;
            border-bottom: 1px solid rgba(0, 212, 255, 0.3);
        }

        .header-buttons a {
            background: #00d4ff;
            color: #0d1117;
            padding: 8px 18px;
            margin-left: 10px;
            border-radius: 20px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s ease;
        }

        .header-buttons a:hover {
            background: #00a8cc;
            box-shadow: 0 0 10px #00d4ff, 0 0 20px #00a8cc;
        }

        /* Cards */
        .cards {
            display: flex;
            justify-content: center;
            flex-wrap: wrap;
            gap: 35px;
            padding: 50px 20px;
            flex-grow: 1;
        }

        .card {
            background: rgba(40, 40, 65, 0.8);
            border-radius: 20px;
            padding: 35px;
            width: 300px;
            text-align: center;
            box-shadow: 0 5px 15px rgba(0, 0, 0, 0.4);
            backdrop-filter: blur(15px);
            border: 1px solid rgba(255, 255, 255, 0.08);
            transition: all 0.4s ease;
        }

        .card:hover {
            transform: translateY(-10px) scale(1.03);
            box-shadow: 0 10px 30px rgba(0, 212, 255, 0.3);
            border: 1px solid rgba(0, 212, 255, 0.4);
        }

        .card h2 { color: #00d4ff; font-size: 22px; margin-bottom: 10px; }
        .card p { font-size: 15px; color: #bbb; margin-bottom: 18px; line-height: 1.5; }
        .card a { display: inline-block; background: transparent; color: #00d4ff; text-decoration: none; border: 1px solid #00d4ff; padding: 10px 18px; border-radius: 8px; transition: all 0.3s ease; font-weight: 500; }
        .card a:hover { background: #00d4ff; color: #0d1117; box-shadow: 0 0 15px #00d4ff; }

        /* Footer */
        footer { text-align: center; padding: 15px 0; background: rgba(20, 20, 35, 0.9); color: #888; font-size: 14px; margin-top: auto; border-top: 1px solid rgba(255, 255, 255, 0.05); }

        /* Responsive */
        @media (max-width: 768px) {
            header { flex-direction: column; font-size: 20px; padding: 15px; gap: 10px; }
            .cards { gap: 25px; padding: 40px 10px; }
            .card { width: 90%; }
        }
    </style>
</head>

<body>

    <header>
        <span>Welcome Dr. <%= session.getAttribute("userName") %></span>
        <div class="header-buttons">
            <a href="<%= request.getContextPath() %>/doctor/doctor-dashboard.jsp">Home</a>
            <a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>
        </div>
    </header>

    <div class="cards">
        <div class="card">
            <h2>Total Appointments</h2>
            <p>Click below to see all your scheduled bookings and patient details.</p>
            <a href="<%= request.getContextPath() %>/doctor/view-appointments.jsp">View Appointments</a>
        </div>

        <div class="card">
            <h2>Profile</h2>
            <p>Update your personal information and contact details with one click.</p>
            <a href="<%= request.getContextPath() %>/doctor/doctor-profile.jsp">Edit Profile</a>
        </div>

        <div class="card">
            <h2>Reports</h2>
            <p>Access patient medical records and diagnosis reports anytime.</p>
            <a href="<%= request.getContextPath() %>/doctor/doctor-reports.jsp">View Reports</a>
        </div>
    </div>

    <footer>
        &copy; 2025 Healthcare Portal | All rights reserved.
    </footer>

</body>
</html>
