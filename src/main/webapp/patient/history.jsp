<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.healthcare.config.DBUtil, jakarta.servlet.http.HttpSession" %>
<%
    if(session == null || session.getAttribute("userId") == null){
        response.sendRedirect("login.jsp");
        return;
    }
    int userId = (int) session.getAttribute("userId");
%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Medical History - Healthcare Portal</title>
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/dark-theme.css"/>
<style>
:root { --accent: #00bcd4; --bg-color: #0d1117; --card-color: #161b22; --text: #f0f0f0; --muted: #9ca3af; }
body.light { --accent:#007bff; --bg-color:#f9fafc; --card-color:#fff; --text:#111; --muted:#555; }
*{margin:0;padding:0;box-sizing:border-box;font-family:"Segoe UI",sans-serif;}
body{background:var(--bg-color);color:var(--text);transition:0.4s;min-height:100vh;display:flex;flex-direction:column;}
.navbar{position:fixed;top:0;left:0;right:0;padding:15px 50px;background:rgba(15,15,15,0.85);backdrop-filter:blur(10px);display:flex;justify-content:space-between;align-items:center;z-index:999;border-bottom:1px solid rgba(255,255,255,0.1);}
.navbar h2{color:var(--accent);}
.navbar a{color:var(--text);margin-left:20px;font-weight:500;text-decoration:none;}
.theme-toggle{border:1px solid var(--accent);padding:6px 15px;border-radius:20px;background:transparent;color:var(--accent);cursor:pointer;}
.theme-toggle:hover{background:var(--accent);color:#fff;}
main{padding:120px 50px 50px;flex:1;}
table{width:100%;border-collapse:collapse;background:var(--card-color);border-radius:12px;overflow:hidden;box-shadow:0 0 15px rgba(0,0,0,0.3);}
th, td{padding:12px;text-align:left;border-bottom:1px solid rgba(255,255,255,0.1);}
th{background:var(--accent);color:#fff;}
tr:hover{background:rgba(0,188,212,0.1);}
.no-history{text-align:center;color:#f44336;padding:20px;}
footer{background:rgba(15,15,15,0.9);backdrop-filter:blur(8px);color:var(--muted);text-align:center;padding:20px;font-size:.95rem;border-top:1px solid rgba(255,255,255,0.1);margin-top:auto;}
footer a{color:var(--accent);text-decoration:none;}
footer a:hover{text-decoration:underline;}
</style>
</head>
<body>

<div class="navbar">
    <h2>Healthcare Portal</h2>
    <div>
        <button id="themeToggle" class="theme-toggle">🌙 Dark Mode</button>
        <a href="patient-dashboard.jsp">Dashboard</a>
        <a href="${pageContext.request.contextPath}/logout.jsp">Logout</a>
    </div>
</div>

<main>
    <h2>Your Medical History</h2>
    <table>
        <thead>
            <tr>
                <th>Date</th>
                <th>Doctor</th>
                <th>Specialization</th>
                <th>Diagnosis</th>
                <th>Prescription</th>
            </tr>
        </thead>
        <tbody>
        <%
            boolean hasData = false;
            try(Connection con = DBUtil.getConnection()){
                String sql = "SELECT v.visit_date, d.name AS doctor_name, d.specialization, v.diagnosis, " +
                             "COALESCE(p.medicines, '-') AS medicines " +
                             "FROM visits v " +
                             "JOIN bookings b ON v.booking_id = b.id " +
                             "JOIN doctors d ON b.doctor_id = d.id " +
                             "LEFT JOIN prescriptions p ON v.id = p.visit_id " +
                             "WHERE b.user_id = ? " +
                             "ORDER BY v.visit_date DESC";
                PreparedStatement ps = con.prepareStatement(sql);
                ps.setInt(1, userId);
                ResultSet rs = ps.executeQuery();
                while(rs.next()){
                    hasData = true;
        %>
            <tr>
                <td><%= rs.getTimestamp("visit_date") %></td>
                <td><%= rs.getString("doctor_name") %></td>
                <td><%= rs.getString("specialization") %></td>
                <td><%= rs.getString("diagnosis") != null ? rs.getString("diagnosis") : "-" %></td>
                <td><%= rs.getString("medicines") %></td>
            </tr>
        <%
                }
                if(!hasData){
        %>
            <tr><td colspan="5" class="no-history">No medical history found.</td></tr>
        <%
                }
            } catch(Exception e){ 
                e.printStackTrace();
        %>
            <tr><td colspan="5" class="no-history">Error fetching history!</td></tr>
        <%
            }
        %>
        </tbody>
    </table>
</main>

<footer>
    &copy; 2025 Healthcare Portal. All Rights Reserved. | Designed with ❤️ by <a href="#">YourTeam</a>
</footer>

<script>
const toggleBtn = document.getElementById('themeToggle');
const currentTheme = localStorage.getItem('theme');
if(currentTheme === 'light'){document.body.classList.add('light'); toggleBtn.textContent='🌞 Light Mode';}
toggleBtn.addEventListener('click', () => {
    document.body.classList.toggle('light');
    const isLight = document.body.classList.contains('light');
    toggleBtn.textContent = isLight ? '🌞 Light Mode' : '🌙 Dark Mode';
    localStorage.setItem('theme', isLight?'light':'dark');
});
</script>
</body>
</html>
