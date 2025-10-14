<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Register - Healthcare Portal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dark-theme.css"/>
    <style>
        body {
            background: #0d1117;
            color: #f0f0f0;
            font-family: "Segoe UI", sans-serif;
        }
        .register-container {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .register-form {
            background: #161b22;
            padding: 40px;
            border-radius: 14px;
            box-shadow: 0 0 25px rgba(0,0,0,0.5);
            width: 100%;
            max-width: 400px;
        }
        .register-form h2 {
            color: #00bcd4;
            margin-bottom: 25px;
            text-align: center;
            font-size: 28px;
        }
        .register-form input,
        .register-form select {
            width: 100%;
            padding: 12px;
            margin-bottom: 20px;
            border-radius: 8px;
            border: 1px solid rgba(255,255,255,0.2);
            background: #0d1117;
            color: #f0f0f0;
            font-size: 14px;
        }
        .register-form select option {
            color: #000;
        }
        .register-form button {
            width: 100%;
            padding: 12px;
            background: #00bcd4;
            color: #0d1117;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 16px;
            cursor: pointer;
            transition: background 0.3s ease;
        }
        .register-form button:hover {
            background: #0097a7;
        }
        .error-msg {
            color: #e74c3c;
            margin-bottom: 15px;
            text-align: center;
        }
        .login-link {
            text-align: center;
            margin-top: 10px;
        }
        .login-link a {
            color: #00bcd4;
            text-decoration: none;
        }
        .login-link a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
<div class="register-container">
    <form class="register-form" action="${pageContext.request.contextPath}/RegisterServlet" method="post">
        <h2>Register</h2>
        <c:if test="${not empty error}">
            <div class="error-msg">${error}</div>
        </c:if>

        <input type="text" name="name" placeholder="Full Name" required/>
        <input type="email" name="email" placeholder="Email" required/>
        <input type="password" name="password" placeholder="Password" required/>

        <select name="role" required>
            <option value="">Select Role</option>
            <option value="user">Patient</option>
            <option value="doctor">Doctor</option>
            <option value="admin">Admin</option>
        </select>

        <button type="submit">Register</button>

        <div class="login-link">
            <p>Already have an account? <a href="${pageContext.request.contextPath}/login.jsp">Login</a></p>
        </div>
    </form>
</div>
</body>
</html>
