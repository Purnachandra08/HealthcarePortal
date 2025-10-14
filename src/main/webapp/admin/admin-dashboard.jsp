<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*" %>

<%
    if(session == null || !"admin".equals(session.getAttribute("role"))){
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<html>
<head>
    <title>Admin Dashboard</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dark-theme.css"/>
</head>
<body>
<h1>Welcome Admin <%= session.getAttribute("userName") %></h1>
<p><a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a></p>

<div>
    <h2>Manage Doctors</h2>
    <a href="manage-doctors.jsp">View & Manage Doctors</a>
</div>
</body>
</html>
