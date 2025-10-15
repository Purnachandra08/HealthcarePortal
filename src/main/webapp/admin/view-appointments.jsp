<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*,java.sql.*" %>
<%@ page import="com.healthcare.config.DBUtil" %>

<%
    if (session == null || !"admin".equals(session.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>View Appointments | Admin Panel</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dark-theme.css"/>
    <style>
        body {
            font-family: "Poppins", sans-serif;
            background: #0d1117;
            color: #e6e6e6;
            margin: 0;
            padding: 0;
            display: flex;
            flex-direction: column;
            min-height: 100vh;
        }

        header {
            background: #28293d;
            padding: 20px;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        header h1 {
            color: #00d4ff;
            font-size: 22px;
        }

        header a {
            color: #0d1117;
            background: #00d4ff;
            padding: 8px 16px;
            border-radius: 5px;
            text-decoration: none;
            margin-left: 10px;
        }

        header a:hover {
            background: #0096c7;
        }

        main {
            flex: 1;
            padding: 30px;
        }

        h2 {
            color: #00d4ff;
            margin-bottom: 20px;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            background: #161b22;
            border-radius: 10px;
            overflow: hidden;
        }

        th, td {
            padding: 12px 15px;
            text-align: left;
        }

        th {
            background: #00d4ff;
            color: #0d1117;
            font-weight: bold;
        }

        tr:nth-child(even) {
            background-color: #1e232a;
        }

        tr:hover {
            background-color: #222b36;
        }

        .actions a {
            color: #00d4ff;
            text-decoration: none;
            margin-right: 10px;
            font-weight: 500;
        }

        .actions a:hover {
            color: #0096c7;
        }

        .back-link {
            display: inline-block;
            margin-top: 20px;
            color: #00d4ff;
            text-decoration: none;
        }

        .back-link:hover {
            color: #0096c7;
        }

        footer {
            background: #28293d;
            color: #a1a1a1;
            text-align: center;
            padding: 15px 0;
            margin-top: auto;
            font-size: 14px;
        }
    </style>
</head>
<body>

<header>
    <h1>Admin Panel - View Appointments</h1>
    <div>
        <a href="admin-dashboard.jsp">Dashboard</a>
        <a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>
    </div>
</header>

<main>
    <h2>All Appointments</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Patient Name</th>
            <th>Doctor Name</th>
            <th>Date</th>
            <th>Time</th>
            <th>Status</th>
            <th>Actions</th>
        </tr>

        <%
            try (Connection con = DBUtil.getConnection()) {
                String sql = "SELECT a.id, u.name AS patient_name, d.name AS doctor_name, " +
                             "a.appointment_date, a.appointment_time, a.status " +
                             "FROM appointments a " +
                             "JOIN users u ON a.user_id = u.id " +
                             "JOIN doctors d ON a.doctor_id = d.id " +
                             "ORDER BY a.appointment_date DESC, a.appointment_time DESC";
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();

                boolean hasData = false;
                while (rs.next()) {
                    hasData = true;
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("patient_name") %></td>
            <td><%= rs.getString("doctor_name") %></td>
            <td><%= rs.getDate("appointment_date") %></td>
            <td><%= rs.getString("appointment_time") %></td>
            <td><%= rs.getString("status") != null ? rs.getString("status") : "Pending" %></td>
            <td class="actions">
                <a href="ViewAppointmentDetailsServlet?id=<%= rs.getInt("id") %>">View</a>
                <a href="DeleteAppointmentServlet?id=<%= rs.getInt("id") %>" 
                   onclick="return confirm('Are you sure you want to delete this appointment?');">Delete</a>
            </td>
        </tr>
        <%
                }

                if (!hasData) {
        %>
        <tr>
            <td colspan="7" style="text-align:center; color:#aaa;">No appointments found.</td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
        <tr>
            <td colspan="7" style="color:red; text-align:center;">Error loading appointments!</td>
        </tr>
        <%
            }
        %>
    </table>

    <a class="back-link" href="admin-dashboard.jsp">← Back to Dashboard</a>
</main>

<footer>
    &copy; 2025 Healthcare Portal | Designed for seamless hospital management
</footer>

</body>
</html>
