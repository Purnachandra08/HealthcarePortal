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
    <title>Doctor Profile</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dark-theme.css"/>
    <style>
        body { font-family:"Poppins",sans-serif; background: radial-gradient(circle at top left,#0d1117,#161b22); color:#e6e6e6; display:flex; flex-direction:column; min-height:100vh; margin:0; }
        header { background: rgba(30,30,45,0.7); backdrop-filter:blur(10px); color:#00d4ff; padding:15px 30px; display:flex; justify-content:space-between; align-items:center; font-size:22px; font-weight:600; border-bottom:1px solid rgba(0,212,255,0.3); }
        header a { background:#00d4ff; color:#0d1117; padding:8px 18px; margin-left:10px; border-radius:20px; font-weight:500; text-decoration:none; }
        header a:hover { background:#0096c7; }
        .container { max-width:600px; margin:50px auto; background: rgba(40,40,65,0.8); padding:30px; border-radius:20px; box-shadow:0 5px 15px rgba(0,0,0,0.4); backdrop-filter:blur(10px); flex-grow:1; }
        h2 { color:#00d4ff; text-align:center; margin-bottom:20px; }
        label { display:block; margin-top:15px; font-weight:500; }
        input { width:100%; padding:10px; margin-top:5px; border-radius:8px; border:1px solid #00d4ff; background: rgba(20,20,35,0.7); color:#e6e6e6; }
        button { margin-top:20px; padding:12px 20px; border-radius:8px; border:none; background:#00d4ff; color:#0d1117; font-weight:600; cursor:pointer; width:100%; transition: all 0.3s ease; }
        button:hover { background:#0096c7; }
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
    <h2>Doctor Profile</h2>
    <form action="<%= request.getContextPath() %>/doctor/UpdateProfileServlet" method="post">
        <label for="name">Name</label>
        <input type="text" name="name" id="name" value="<%= session.getAttribute("userName") %>" required>

        <label for="email">Email</label>
        <input type="email" name="email" id="email" value="<%= session.getAttribute("userEmail") %>" required>

        <label for="phone">Phone</label>
        <input type="text" name="phone" id="phone" value="<%= session.getAttribute("userPhone") %>" required>

        <label for="specialization">Specialization</label>
        <input type="text" name="specialization" id="specialization" value="<%= session.getAttribute("userSpecialization") %>" required>

        <button type="submit">Update Profile</button>
    </form>
</div>

<footer>
    &copy; 2025 Healthcare Portal | All rights reserved.
</footer>

</body>
</html>
