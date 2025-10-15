<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*" %>
<%
    if(session == null || !"admin".equals(session.getAttribute("role"))){
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Admin Profile Settings</title>
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
            display: flex;
            justify-content: center;
        }

        .profile-container {
            background: #161b22;
            padding: 30px;
            border-radius: 15px;
            width: 400px;
            box-shadow: 0 5px 15px rgba(0,0,0,0.5);
        }

        h2 {
            color: #00d4ff;
            text-align: center;
            margin-bottom: 25px;
        }

        label {
            display: block;
            margin-top: 15px;
            font-weight: 500;
        }

        input {
            width: 100%;
            padding: 10px;
            margin-top: 5px;
            border-radius: 8px;
            border: 1px solid #00d4ff;
            background: rgba(20,20,35,0.7);
            color: #e6e6e6;
        }

        button {
            margin-top: 20px;
            padding: 12px 20px;
            border-radius: 8px;
            border: none;
            background: #00d4ff;
            color: #0d1117;
            font-weight: 600;
            cursor: pointer;
            width: 100%;
            transition: all 0.3s ease;
        }

        button:hover {
            background: #0096c7;
        }

        .back-link {
            display: block;
            margin-top: 20px;
            text-align: center;
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
    <h1>Admin Profile</h1>
    <div>
        <a href="admin-dashboard.jsp">Dashboard</a>
        <a href="<%= request.getContextPath() %>/LogoutServlet">Logout</a>
    </div>
</header>

<main>
    <div class="profile-container">
        <h2>Profile Settings</h2>
        <form action="<%= request.getContextPath() %>/UpdateAdminProfileServlet" method="post">
            <label for="name">Name</label>
            <input type="text" id="name" name="name" value="<%= session.getAttribute("userName") %>" required/>

            <label for="email">Email</label>
            <input type="email" id="email" name="email" value="" placeholder="Enter email" required/>

            <label for="password">New Password</label>
            <input type="password" id="password" name="password" placeholder="Leave blank to keep current"/>

            <button type="submit">Update Profile</button>
        </form>
        <a class="back-link" href="admin-dashboard.jsp">← Back to Dashboard</a>
    </div>
</main>

<footer>
    &copy; 2025 Healthcare Portal | Admin Profile Settings
</footer>

</body>
</html>
