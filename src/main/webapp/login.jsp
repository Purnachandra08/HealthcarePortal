<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - Healthcare Portal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dark-theme.css"/>
    <style>
        body{background:#0d1117;color:#f0f0f0;font-family:"Segoe UI",sans-serif;}
        .login-container{display:flex;justify-content:center;align-items:center;height:100vh;}
        .login-form{background:#161b22;padding:40px;border-radius:14px;box-shadow:0 0 20px rgba(0,0,0,0.4);width:100%;max-width:400px;}
        .login-form h2{color:#00bcd4;margin-bottom:20px;text-align:center;}
        .login-form input, .login-form select{width:100%;padding:12px;margin-bottom:20px;border-radius:8px;border:1px solid rgba(255,255,255,0.2);background:#0d1117;color:#f0f0f0;}
        .login-form button{width:100%;padding:12px;background:#00bcd4;color:#fff;border:none;border-radius:8px;font-weight:600;cursor:pointer;}
        .error-msg{color:red;margin-bottom:15px;text-align:center;}
    </style>
</head>
<body>
<div class="login-container">
    <form class="login-form" action="AuthServlet" method="post">
        <h2>Login</h2>
        <c:if test="${not empty error}">
            <div class="error-msg">${error}</div>
        </c:if>
        <input type="email" name="email" placeholder="Email" required/>
        <input type="password" name="password" placeholder="Password" required/>
        <select name="role" required>
            <option value="">Select Role</option>
            <option value="user">Patient</option>
            <option value="doctor">Doctor</option>
            <option value="admin">Admin</option>
        </select>
        <button type="submit">Login</button>
        <p style="text-align:center;margin-top:10px;"><a href="register.jsp">Register Here</a></p>
    </form>
</div>
</body>
</html>
