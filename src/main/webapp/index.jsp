<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!doctype html>
<html lang="en">
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Healthcare Portal - Home</title>
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dark-theme.css"/>

  <style>
    /* ---------- Theme Variables ---------- */
    :root {
      --accent: #00bcd4;
      --bg-color: #0d1117;
      --card-color: #161b22;
      --text: #f0f0f0;
      --muted: #9ca3af;
      --gradient: radial-gradient(circle at 20% 20%, rgba(0,188,212,0.25), transparent 60%);
    }

    body.light {
      --accent: #007bff;
      --bg-color: #f9fafc;
      --card-color: #ffffff;
      --text: #111;
      --muted: #555;
      --gradient: radial-gradient(circle at 80% 40%, rgba(0,123,255,0.12), transparent 60%);
    }

    /* ---------- Global Layout ---------- */
    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
      font-family: "Segoe UI", sans-serif;
    }

    html, body {
      height: 100%;
    }

    body {
      display: flex;
      flex-direction: column;
      min-height: 100vh;
      background: var(--bg-color);
      color: var(--text);
      transition: all 0.4s ease;
      overflow-x: hidden;
    }

    a {
      text-decoration: none;
      color: var(--accent);
      transition: color 0.3s ease;
    }

    /* ---------- Navbar ---------- */
    .navbar {
      position: fixed;
      top: 0; left: 0; right: 0;
      padding: 15px 50px;
      background: rgba(15,15,15,0.85);
      backdrop-filter: blur(10px);
      display: flex; justify-content: space-between; align-items: center;
      z-index: 999;
      transition: background 0.4s;
    }

    .navbar.scrolled { background: rgba(10,10,10,0.95); }

    .navbar h2 { color: var(--accent); font-weight: 700; }

    .navbar a { color: var(--text); margin-left: 20px; font-weight: 500; }
    .navbar a:hover { color: var(--accent); }

    .theme-toggle {
      border: 1px solid var(--accent);
      padding: 6px 15px;
      border-radius: 20px;
      background: transparent;
      color: var(--accent);
      cursor: pointer;
      transition: all 0.3s;
    }
    .theme-toggle:hover { background: var(--accent); color: #fff; }

    /* ---------- Hero Section ---------- */
    main {
      flex: 1;
    }

    .hero {
      padding: 150px 50px 100px;
      display: flex;
      flex-wrap: wrap;
      justify-content: space-between;
      align-items: center;
      background: var(--gradient);
      position: relative;
      overflow: hidden;
    }

    .hero::before {
      content: "";
      position: absolute;
      width: 400px;
      height: 400px;
      background: radial-gradient(circle, rgba(0,188,212,0.15), transparent 70%);
      top: -80px;
      right: -80px;
      filter: blur(80px);
      z-index: 0;
    }

    .hero-content {
      flex: 1;
      z-index: 1;
      min-width: 300px;
      animation: fadeInLeft 1.2s ease;
    }

    .hero-content h1 {
      font-size: 3rem;
      color: var(--accent);
      line-height: 1.2;
      margin-bottom: 15px;
    }

    .hero-content p {
      color: var(--muted);
      font-size: 1.15rem;
      line-height: 1.6;
      margin-bottom: 30px;
      max-width: 550px;
    }

    .hero-buttons {
      display: flex;
      gap: 20px;
    }

    .btn {
      background: var(--accent);
      color: #fff;
      padding: 12px 30px;
      border-radius: 8px;
      font-weight: 600;
      border: none;
      transition: 0.4s;
      box-shadow: 0 4px 15px rgba(0,188,212,0.3);
    }

    .btn:hover {
      transform: translateY(-4px);
      box-shadow: 0 8px 25px rgba(0,188,212,0.4);
    }

    .btn.ghost {
      background: transparent;
      color: var(--accent);
      border: 1px solid var(--accent);
    }

    .btn.ghost:hover {
      background: var(--accent);
      color: #fff;
    }

    .hero-image {
      flex: 1;
      display: flex;
      justify-content: center;
      align-items: center;
      position: relative;
      z-index: 1;
      animation: fadeInRight 1.4s ease;
    }

    .hero-image img {
      width: 100%;
      max-width: 480px;
      filter: drop-shadow(0 0 25px rgba(0,188,212,0.4));
      transition: transform 0.6s ease;
    }

    .hero-image img:hover {
      transform: scale(1.05);
    }

    /* ---------- Features Section ---------- */
    .features {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
      gap: 30px;
      padding: 60px 50px 80px;
      background: var(--bg-color);
      position: relative;
      z-index: 2;
    }

    .feature-card {
      background: var(--card-color);
      padding: 30px;
      border-radius: 14px;
      text-align: center;
      transition: 0.4s;
      box-shadow: 0 0 10px rgba(0,0,0,0.4);
    }

    .feature-card:hover {
      transform: translateY(-8px);
      box-shadow: 0 0 25px rgba(0,188,212,0.3);
    }

    .feature-card h3 {
      color: var(--accent);
      font-size: 1.3rem;
      margin-bottom: 10px;
    }

    .feature-card p {
      color: var(--muted);
      font-size: 1rem;
      line-height: 1.6;
    }

    /* ---------- Footer ---------- */
    footer {
      background: rgba(15,15,15,0.9);
      backdrop-filter: blur(8px);
      color: var(--muted);
      text-align: center;
      padding: 25px 10px;
      font-size: 0.95rem;
      border-top: 1px solid rgba(255,255,255,0.1);
      margin-top: auto;
    }

    footer a {
      color: var(--accent);
      margin-left: 6px;
    }

    /* ---------- Animations ---------- */
    @keyframes fadeInLeft {
      from { opacity: 0; transform: translateX(-30px); }
      to { opacity: 1; transform: translateX(0); }
    }
    @keyframes fadeInRight {
      from { opacity: 0; transform: translateX(30px); }
      to { opacity: 1; transform: translateX(0); }
    }
  </style>
</head>

<body>
  <!-- ===== Navbar ===== -->
  <div class="navbar">
    <h2>Healthcare Portal</h2>
    <div>
      <button id="themeToggle" class="theme-toggle">🌙 Dark Mode</button>
      <a href="${pageContext.request.contextPath}/login.jsp">Login</a>
      <a href="${pageContext.request.contextPath}/register.jsp" class="btn">Register</a>
    </div>
  </div>

  <main>
    <!-- ===== Hero Section ===== -->
    <section class="hero">
      <div class="hero-content">
        <h1>Better Health Starts Here 🩺</h1>
        <p>Discover trusted doctors, manage your health records, and book appointments with ease. A smarter way to take care of your well-being.</p>
        <div class="hero-buttons">
          <a href="login.jsp" class="btn">Get Started</a>
          <a href="${pageContext.request.contextPath}/register.jsp" class="btn ghost">Join Now</a>
        </div>
      </div>

      <div class="hero-image">
        <img src="${pageContext.request.contextPath}/images/doctor-illustration.png" alt="Healthcare Illustration">
      </div>
    </section>

    <!-- ===== Features ===== -->
    <section class="features">
      <div class="feature-card">
        <h3>Verified Doctors</h3>
        <p>Connect with certified healthcare professionals across multiple specialties.</p>
      </div>
      <div class="feature-card">
        <h3>Smart Bookings</h3>
        <p>Book, reschedule, and manage appointments effortlessly anytime.</p>
      </div>
      <div class="feature-card">
        <h3>Digital Health Records</h3>
        <p>Access all your medical history securely in one unified dashboard.</p>
      </div>
      <div class="feature-card">
        <h3>Doctor & Admin Panels</h3>
        <p>Dedicated tools for doctors and administrators for efficient operations.</p>
      </div>
    </section>
  </main>

  <!-- ===== Footer ===== -->
  <footer>
    &copy; 2025 Healthcare Portal. All Rights Reserved. | Designed with ❤️ by 
    <a href="#">Sipun</a>
  </footer>

  <!-- ===== JavaScript ===== -->
  <script>
    const toggleBtn = document.getElementById('themeToggle');
    const currentTheme = localStorage.getItem('theme');
    if (currentTheme === 'light') {
      document.body.classList.add('light');
      toggleBtn.textContent = '🌞 Light Mode';
    }
    toggleBtn.addEventListener('click', () => {
      document.body.classList.toggle('light');
      const isLight = document.body.classList.contains('light');
      toggleBtn.textContent = isLight ? '🌞 Light Mode' : '🌙 Dark Mode';
      localStorage.setItem('theme', isLight ? 'light' : 'dark');
    });

    window.addEventListener('scroll', () => {
      document.querySelector('.navbar').classList.toggle('scrolled', window.scrollY > 30);
    });
  </script>
</body>
</html>
