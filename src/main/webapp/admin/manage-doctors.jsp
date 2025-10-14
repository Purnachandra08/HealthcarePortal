<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*,java.sql.*,java.util.*" %>
<%@ page import="com.healthcare.config.DBUtil" %>

<%
    if(session == null || !"admin".equals(session.getAttribute("role"))){
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<html>
<head>
    <title>Manage Doctors</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dark-theme.css"/>
</head>
<body>
<h1>All Doctors</h1>
<table border="1">
    <tr>
        <th>ID</th>
        <th>Name</th>
        <th>Email</th>
        <th>Specialization</th>
        <th>Status</th>
        <th>Actions</th>
    </tr>

<%
    try(Connection con = DBUtil.getConnection()){
        String sql = "SELECT id, name, email, specialization, is_active FROM doctors";
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while(rs.next()){
%>
<tr>
    <td><%= rs.getInt("id") %></td>
    <td><%= rs.getString("name") %></td>
    <td><%= rs.getString("email") %></td>
    <td><%= rs.getString("specialization") %></td>
    <td><%= rs.getInt("is_active") == 1 ? "Active" : "Inactive" %></td>
    <td>
        <a href="ToggleDoctorStatusServlet?id=<%= rs.getInt("id") %>">Toggle Status</a> |
        <a href="EditDoctorServlet?id=<%= rs.getInt("id") %>">Edit</a>
    </td>
</tr>
<%
        }
    } catch(Exception e){ e.printStackTrace(); }
%>
</table>

<p><a href="admin-dashboard.jsp">Back to Dashboard</a></p>
</body>
</html>
