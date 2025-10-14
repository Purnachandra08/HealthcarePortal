<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Book Appointment - Healthcare Portal</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dark-theme.css"/>
  <style>
    :root { --accent: #00bcd4; --bg-color: #0d1117; --card-color: #161b22; --text: #f0f0f0; --muted: #9ca3af; }
    body.light{--accent:#007bff;--bg-color:#f9fafc;--card-color:#fff;--text:#111;--muted:#555;}
    *{margin:0;padding:0;box-sizing:border-box;font-family:"Segoe UI",sans-serif;}
    body{background:var(--bg-color);color:var(--text);transition:0.4s;}
    .navbar{position:fixed;top:0;left:0;right:0;padding:15px 50px;background:rgba(15,15,15,0.85);backdrop-filter:blur(10px);display:flex;justify-content:space-between;align-items:center;z-index:999;}
    .navbar h2{color:var(--accent);}
    .navbar a{color:var(--text);margin-left:20px;font-weight:500;}
    .theme-toggle{border:1px solid var(--accent);padding:6px 15px;border-radius:20px;background:transparent;color:var(--accent);cursor:pointer;}
    footer{background:rgba(15,15,15,0.9);backdrop-filter:blur(8px);color:var(--muted);text-align:center;padding:25px 10px;font-size:.95rem;border-top:1px solid rgba(255,255,255,0.1);margin-top:auto;}
    .booking-container{padding:130px 50px 50px;display:flex;justify-content:center;}
    .booking-form{background:var(--card-color);padding:40px;border-radius:14px;box-shadow:0 0 20px rgba(0,0,0,0.4);width:100%;max-width:500px;}
    .booking-form h2{color:var(--accent);margin-bottom:20px;text-align:center;}
    .booking-form label{display:block;margin-bottom:8px;color:var(--muted);}
    .booking-form input, .booking-form select{width:100%;padding:12px;margin-bottom:20px;border-radius:8px;border:1px solid rgba(255,255,255,0.2);background:var(--bg-color);color:var(--text);}
    .booking-form button{width:100%;padding:12px;background:var(--accent);color:#fff;border:none;border-radius:8px;font-weight:600;cursor:pointer;transition:0.3s;}
    .booking-form button:hover{transform:translateY(-2px);box-shadow:0 6px 20px rgba(0,188,212,0.4);}
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
    <div class="booking-container">
      <form class="booking-form" action="BookAppointmentServlet" method="post">
        <h2>Book Appointment</h2>
        <label for="doctor">Select Doctor</label>
        <select name="doctor" id="doctor">
          <option value="Dr. Smith">Dr. Smith - Cardiology</option>
          <option value="Dr. Jane">Dr. Jane - Dermatology</option>
        </select>

        <label for="date">Select Date</label>
        <input type="date" id="date" name="date" required>

        <label for="time">Select Time Slot</label>
        <input type="time" id="time" name="time" required>

        <button type="submit">Book Now</button>
      </form>
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
