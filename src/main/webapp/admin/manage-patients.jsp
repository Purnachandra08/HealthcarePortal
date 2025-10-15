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
    <title>Manage Patients | Admin Panel</title>
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
    <h1>Admin Panel - Manage Patients</h1>
    <div>
        <a href="admin-dashboard.jsp">Dashboard</a>
        <a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>
    </div>
</header>

<main>
    <h2>All Registered Patients</h2>

    <table>
        <tr>
            <th>ID</th>
            <th>Name</th>
            <th>Email</th>
            <th>Phone</th>
            <th>Date of Birth</th>
            <th>Gender</th>
            <th>Actions</th>
        </tr>

        <%
            try (Connection con = DBUtil.getConnection()) {
                String sql = "SELECT id, name, email, phone, dob, gender FROM users";
                PreparedStatement ps = con.prepareStatement(sql);
                ResultSet rs = ps.executeQuery();

                boolean hasData = false;
                while (rs.next()) {
                    hasData = true;
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("name") %></td>
            <td><%= rs.getString("email") %></td>
            <td><%= rs.getString("phone") != null ? rs.getString("phone") : "-" %></td>
            <td><%= rs.getDate("dob") != null ? rs.getDate("dob") : "-" %></td>
            <td><%= rs.getString("gender") != null ? rs.getString("gender") : "-" %></td>
            <td class="actions">
                <a href="ViewPatientServlet?id=<%= rs.getInt("id") %>">View</a>
                <a href="DeletePatientServlet?id=<%= rs.getInt("id") %>" 
                   onclick="return confirm('Are you sure you want to delete this patient?');">Delete</a>
            </td>
        </tr>
        <%
                }

                if (!hasData) {
        %>
        <tr>
            <td colspan="7" style="text-align:center; color:#aaa;">No patients found.</td>
        </tr>
        <%
                }
            } catch (Exception e) {
                e.printStackTrace();
        %>
        <tr>
            <td colspan="7" style="color:red; text-align:center;">Error loading patient data!</td>
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
