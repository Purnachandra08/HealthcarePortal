<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.*,jakarta.servlet.*,java.sql.*" %>
<%@ page import="com.healthcare.config.DBUtil" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
    // Guard: only allow logged-in patients
    if (session == null || !"user".equals(session.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    int userId = (int) session.getAttribute("userId");

    // Load current values
    String name = "";
    String email = "";
    String phone = "";
    String gender = "";
    java.sql.Date dob = null;

    try (Connection con = DBUtil.getConnection()) {
        PreparedStatement ps = con.prepareStatement(
            "SELECT name, email, phone, gender, dob FROM users WHERE id = ?"
        );
        ps.setInt(1, userId);
        ResultSet rs = ps.executeQuery();
        if (rs.next()) {
            name = rs.getString("name");
            email = rs.getString("email");
            phone = rs.getString("phone");
            gender = rs.getString("gender");
            dob = rs.getDate("dob");
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    boolean updated = "1".equals(request.getParameter("success"));
%>

<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <title>Profile Settings - Healthcare Portal</title>
  <meta name="viewport" content="width=device-width,initial-scale=1">
  <link rel="stylesheet" href="<%=request.getContextPath()%>/css/dark-theme.css"/>
  <style>
    :root { --accent:#00bcd4; --bg:#0d1117; --card:#161b22; --muted:#9ca3af; --text:#f0f0f0; }
    body{margin:0;font-family:"Segoe UI",sans-serif;background:var(--bg);color:var(--text);}
    .wrap{min-height:100vh;display:flex;align-items:center;justify-content:center;padding:60px 20px;}
    .card{width:100%;max-width:720px;background:var(--card);border-radius:14px;padding:28px;box-shadow:0 8px 30px rgba(0,0,0,0.6);}
    .card h2{margin:0 0 12px 0;color:var(--accent);font-size:1.6rem;}
    .grid{display:grid;grid-template-columns:1fr 1fr;gap:14px;margin-top:18px;}
    label{display:block;font-size:13px;color:var(--muted);margin-bottom:6px;}
    input[type="text"], input[type="email"], input[type="date"], select{width:100%;padding:10px 12px;border-radius:8px;background:#0c1116;color:var(--text);border:1px solid rgba(255,255,255,0.04);}
    .full{grid-column:1 / -1;}
    .actions{display:flex;gap:12px;margin-top:20px;align-items:center;justify-content:flex-end;}
    .btn{padding:10px 18px;border-radius:10px;font-weight:600;cursor:pointer;border:none;}
    .btn-primary{background:var(--accent);color:#081018;}
    .btn-ghost{background:transparent;color:var(--text);border:1px solid rgba(255,255,255,0.06);}
    .small{font-size:13px;color:var(--muted);margin-right:auto;}
    .toast{position:fixed;right:20px;top:20px;background:#0b3b3f;color:#d4fff9;padding:12px 16px;border-radius:8px;box-shadow:0 6px 20px rgba(0,0,0,0.5);display:flex;gap:10px;align-items:center;transform:translateY(-10px);opacity:0;transition:all 300ms ease;}
    .toast.show{opacity:1;transform:translateY(0);}
  </style>
</head>
<body>
<div class="wrap">
  <div class="card">
    <h2>Profile Settings</h2>
    <p style="color:var(--muted); margin-top:6px;">Update your personal information — email is used for login and cannot be changed here.</p>

    <form id="profileForm" action="<%=request.getContextPath()%>/UpdateProfileServlet" method="post" novalidate>
      <div class="grid">
        <div>
          <label for="name">Full name</label>
          <input id="name" name="name" type="text" value="<c:out value='${name}'/>" required>
        </div>

        <div>
          <label for="email">Email (readonly)</label>
          <input id="email" name="email" type="email" value="<c:out value='${email}'/>" readonly>
        </div>

        <div>
          <label for="phone">Phone</label>
          <input id="phone" name="phone" type="text" value="<c:out value='${phone}'/>">
        </div>

        <div>
          <label for="dob">Date of birth</label>
          <input id="dob" name="dob" type="date" value="<%= dob != null ? dob.toString() : "" %>">
        </div>

        <div class="full">
          <label for="gender">Gender</label>
          <select id="gender" name="gender">
            <option value="">Select gender</option>
            <option value="M" <%= "M".equals(gender)?"selected":"" %>>Male</option>
            <option value="F" <%= "F".equals(gender)?"selected":"" %>>Female</option>
            <option value="O" <%= "O".equals(gender)?"selected":"" %>>Other</option>
          </select>
        </div>
      </div>

      <div class="actions">
        <div class="small">Logged in as <strong><%=session.getAttribute("userName")%></strong></div>
        <button type="button" class="btn btn-ghost" onclick="window.location.href='<%=request.getContextPath()%>/patient/patient-dashboard.jsp'">Cancel</button>
        <button type="submit" class="btn btn-primary">Save changes</button>
      </div>
    </form>
  </div>
</div>

<!-- Toast notification -->
<div id="toast" class="toast <%= updated ? "show" : "" %>">
  <svg width="18" height="18" viewBox="0 0 24 24" fill="none">
    <path d="M9 12l2 2 4-4" stroke="#bff7ff" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
  </svg>
  <div>Profile updated successfully</div>
</div>

<script>
  (function(){
    const toast = document.getElementById('toast');
    if(toast.classList.contains('show')){
      setTimeout(()=>{ toast.classList.remove('show'); history.replaceState({}, '', location.pathname); }, 3000);
    }

    document.getElementById('profileForm').addEventListener('submit', function(e){
      const name = document.getElementById('name').value.trim();
      if(name.length < 2){
        e.preventDefault();
        alert('Please enter a valid name (at least 2 characters).');
        return false;
      }
    });
  })();
</script>
</body>
</html>
