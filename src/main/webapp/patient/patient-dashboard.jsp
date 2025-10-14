<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Patient Dashboard - Healthcare Portal</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dark-theme.css"/>
  <style>
    :root {
      --accent: #00bcd4;
      --bg-color: #0d1117;
      --card-color: #161b22;
      --text: #f0f0f0;
      --muted: #9ca3af;
      --gradient: radial-gradient(circle at 20% 20%, rgba(0,188,212,0.15), transparent 70%);
    }
    body.light {
      --accent: #007bff;
      --bg-color: #f9fafc;
      --card-color: #fff;
      --text: #111;
      --muted: #555;
      --gradient: radial-gradient(circle at 80% 40%, rgba(0,123,255,0.1), transparent 70%);
    }
    *{margin:0;padding:0;box-sizing:border-box;font-family:"Segoe UI",sans-serif;}
    body{background:var(--bg-color);color:var(--text);transition:0.4s;}
    a{text-decoration:none;color:var(--accent);}
    
    /* Navbar */
    .navbar{
      position:fixed;
      top:0; left:0; right:0;
      padding:15px 50px;
      background:rgba(15,15,15,0.9);
      backdrop-filter:blur(12px);
      display:flex;
      justify-content:space-between;
      align-items:center;
      z-index:999;
      box-shadow:0 2px 10px rgba(0,0,0,0.3);
    }
    .navbar h2{color:var(--accent);}
    .navbar a{color:var(--text);margin-left:20px;font-weight:500;transition:0.3s;}
    .navbar a:hover{color:var(--accent);}
    .theme-toggle{
      border:1px solid var(--accent);
      padding:6px 15px;
      border-radius:20px;
      background:transparent;
      color:var(--accent);
      cursor:pointer;
      transition:0.3s;
    }
    .theme-toggle:hover{background:var(--accent);color:#0d1117;}

    /* Dashboard container */
    .dashboard-container{
      padding:140px 50px 50px;
      display:grid;
      grid-template-columns:repeat(auto-fit,minmax(260px,1fr));
      gap:30px;
    }

    /* Cards */
    .card{
      background:var(--card-color);
      padding:35px 25px;
      border-radius:16px;
      box-shadow:0 10px 20px rgba(0,0,0,0.3);
      transition:all 0.4s ease;
      text-align:center;
      position:relative;
      overflow:hidden;
    }
    .card::before{
      content:"";
      position:absolute;
      top:-50%;
      left:-50%;
      width:200%;
      height:200%;
      background:var(--gradient);
      opacity:0.3;
      transform:rotate(25deg);
      pointer-events:none;
    }
    .card:hover{
      transform:translateY(-10px);
      box-shadow:0 15px 30px rgba(0,188,212,0.4);
    }
    .card h3{color:var(--accent);margin-bottom:12px;font-size:1.3rem;}
    .card p{color:var(--muted);margin-bottom:18px;font-size:0.95rem;}

    /* Button style inside card */
    .card .btn{
      display:inline-block;
      padding:10px 22px;
      border-radius:10px;
      font-weight:600;
      background:var(--accent);
      color:#081018;
      text-decoration:none;
      transition:all 0.3s ease;
      box-shadow:0 4px 12px rgba(0,188,212,0.3);
    }
    .card .btn:hover{
      transform:translateY(-3px);
      box-shadow:0 6px 20px rgba(0,188,212,0.5);
    }

    /* Footer */
    footer{
      background:rgba(15,15,15,0.9);
      backdrop-filter:blur(8px);
      color:var(--muted);
      text-align:center;
      padding:25px 10px;
      font-size:.95rem;
      border-top:1px solid rgba(255,255,255,0.1);
      margin-top:auto;
    }
  </style>
</head>
<body>
  <!-- Navbar -->
  <div class="navbar">
    <h2>Healthcare Portal</h2>
    <div>
      <button id="themeToggle" class="theme-toggle">🌙 Dark Mode</button>
      <a href="${pageContext.request.contextPath}/logout.jsp">Logout</a>
    </div>
  </div>

  <!-- Dashboard -->
  <main>
    <div class="dashboard-container">
      <div class="card">
        <h3>Book Appointment</h3>
        <p>Schedule a visit with your preferred doctor.</p>
        <a href="book-slot.jsp" class="btn">Book Now</a>
      </div>
      <div class="card">
        <h3>Medical History</h3>
        <p>View your previous consultations and reports.</p>
        <a href="history.jsp" class="btn">View History</a>
      </div>
      <div class="card">
        <h3>Profile Settings</h3>
        <p>Update your personal details and preferences.</p>
        <a href="profile.jsp" class="btn">Edit Profile</a>
      </div>
    </div>
  </main>

  <footer>
    &copy; 2025 Healthcare Portal. All Rights Reserved. | Designed with ❤️ by <a href="#">YourTeam</a>
  </footer>

  <script>
    const toggleBtn = document.getElementById('themeToggle');
    const currentTheme = localStorage.getItem('theme');
    if(currentTheme==='light'){
      document.body.classList.add('light');
      toggleBtn.textContent='🌞 Light Mode';
    }
    toggleBtn.addEventListener('click',()=>{
      document.body.classList.toggle('light');
      const isLight=document.body.classList.contains('light');
      toggleBtn.textContent=isLight?'🌞 Light Mode':'🌙 Dark Mode';
      localStorage.setItem('theme',isLight?'light':'dark');
    });
  </script>
</body>
</html>
