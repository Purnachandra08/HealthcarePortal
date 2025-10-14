<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Medical History - Healthcare Portal</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dark-theme.css"/>
  <style>
    /* Reuse theme from index.jsp */
    :root { --accent: #00bcd4; --bg-color: #0d1117; --card-color: #161b22; --text: #f0f0f0; --muted: #9ca3af; }
    body.light{--accent:#007bff;--bg-color:#f9fafc;--card-color:#fff;--text:#111;--muted:#555;}
    *{margin:0;padding:0;box-sizing:border-box;font-family:"Segoe UI",sans-serif;}
    body{background:var(--bg-color);color:var(--text);transition:0.4s;}
    .navbar{position:fixed;top:0;left:0;right:0;padding:15px 50px;background:rgba(15,15,15,0.85);backdrop-filter:blur(10px);display:flex;justify-content:space-between;align-items:center;z-index:999;}
    .navbar h2{color:var(--accent);}
    .navbar a{color:var(--text);margin-left:20px;font-weight:500;}
    .theme-toggle{border:1px solid var(--accent);padding:6px 15px;border-radius:20px;background:transparent;color:var(--accent);cursor:pointer;}
    footer{background:rgba(15,15,15,0.9);backdrop-filter:blur(8px);color:var(--muted);text-align:center;padding:25px 10px;font-size:.95rem;border-top:1px solid rgba(255,255,255,0.1);margin-top:auto;}
    .history-container{padding:130px 50px 50px;}
    table{width:100%;border-collapse:collapse;background:var(--card-color);border-radius:14px;overflow:hidden;box-shadow:0 0 15px rgba(0,0,0,0.3);}
    th,td{padding:15px;text-align:left;border-bottom:1px solid rgba(255,255,255,0.1);}
    th{background:var(--accent);color:#fff;}
    tr:hover{background:rgba(0,188,212,0.1);}
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
    <div class="history-container">
      <h2>Medical History</h2>
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
          <!-- Example Data -->
          <tr><td>2025-09-20</td><td>Dr. Smith</td><td>Cardiology</td><td>Hypertension</td><td>Amlodipine</td></tr>
          <tr><td>2025-08-15</td><td>Dr. Jane</td><td>Dermatology</td><td>Acne</td><td>Topical Cream</td></tr>
        </tbody>
      </table>
    </div>
  </main>

  <footer>
    &copy; 2025 Healthcare Portal. All Rights Reserved. | Designed with ❤️ by <a href="#">YourTeam</a>
  </footer>

  <script>
    const toggleBtn=document.getElementById('themeToggle');
    const currentTheme=localStorage.getItem('theme');
    if(currentTheme==='light'){document.body.classList.add('light');toggleBtn.textContent='🌞 Light Mode';}
    toggleBtn.addEventListener('click',()=>{document.body.classList.toggle('light');const isLight=document.body.classList.contains('light');toggleBtn.textContent=isLight?'🌞 Light Mode':'🌙 Dark Mode';localStorage.setItem('theme',isLight?'light':'dark');});
  </script>
</body>
</html>
