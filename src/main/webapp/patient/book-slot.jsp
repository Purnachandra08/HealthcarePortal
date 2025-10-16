<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, com.healthcare.config.DBUtil" %>

<%
    if(session == null || !"user".equals(session.getAttribute("role"))){
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Book Appointment - Healthcare Portal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/dark-theme.css"/>
    <style>
        :root {
            --accent: #00bcd4;
            --bg-color: #0d1117;
            --card-color: #161b22;
            --text: #f0f0f0;
            --muted: #9ca3af;
        }
        body.light { 
            --accent:#007bff;
            --bg-color:#f9fafc;
            --card-color:#fff;
            --text:#111;
            --muted:#555;
        }

        * {margin:0; padding:0; box-sizing:border-box; font-family:"Segoe UI",sans-serif;}
        body { 
            background: var(--bg-color);
            color: var(--text);
            transition: 0.4s;
            min-height: 100vh;
            display: flex;
            flex-direction: column;
        }

        /* Navbar */
        .navbar {
            position: fixed;
            top:0; left:0; right:0;
            padding: 15px 50px;
            background: rgba(15,15,15,0.85);
            backdrop-filter: blur(10px);
            display: flex;
            justify-content: space-between;
            align-items: center;
            z-index: 999;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }
        .navbar h2 { color: var(--accent); }
        .navbar a { color: var(--text); margin-left: 20px; text-decoration: none; font-weight: 500; }
        .navbar a:hover { color: var(--accent); }
        .theme-toggle {
            border:1px solid var(--accent);
            padding:6px 15px;
            border-radius:20px;
            background:transparent;
            color:var(--accent);
            cursor:pointer;
            transition:0.3s;
        }
        .theme-toggle:hover { background:var(--accent); color:#fff; }

        /* Main content */
        main { flex:1; display:flex; justify-content:center; align-items:flex-start; padding: 120px 20px 50px; }
        .booking-container { width:100%; max-width:550px; }
        .booking-form {
            background: var(--card-color);
            padding: 40px;
            border-radius:14px;
            box-shadow:0 0 20px rgba(0,0,0,0.4);
        }
        .booking-form h2 { color: var(--accent); text-align:center; margin-bottom:25px; }
        .booking-form label { display:block; margin-bottom:8px; color: var(--muted); font-weight:500; }
        .booking-form input, 
        .booking-form select, 
        .booking-form textarea {
            width:100%;
            padding:12px;
            margin-bottom:20px;
            border-radius:8px;
            border:1px solid rgba(255,255,255,0.2);
            background: var(--bg-color);
            color: var(--text);
        }
        .booking-form button {
            width:100%;
            padding:12px;
            background: var(--accent);
            color:#fff;
            border:none;
            border-radius:8px;
            font-weight:600;
            cursor:pointer;
            transition:0.3s;
        }
        .booking-form button:hover {
            transform: translateY(-2px);
            box-shadow: 0 6px 20px rgba(0,188,212,0.4);
        }

        /* Messages */
        .success { color:#4caf50; margin-bottom:15px; text-align:center; }
        .error { color:#f44336; margin-bottom:15px; text-align:center; }

        /* Footer */
        footer {
            background: rgba(15,15,15,0.9);
            backdrop-filter: blur(8px);
            color: var(--muted);
            text-align:center;
            padding:20px 10px;
            font-size:.95rem;
            border-top:1px solid rgba(255,255,255,0.1);
        }
        footer a { color:var(--accent); text-decoration:none; }
        footer a:hover { text-decoration:underline; }

    </style>
</head>
<body>

<!-- Navbar -->
<div class="navbar">
    <h2>Healthcare Portal</h2>
    <div>
        <button id="themeToggle" class="theme-toggle">🌙 Dark Mode</button>
        <a href="patient-dashboard.jsp">Dashboard</a>
        <a href="${pageContext.request.contextPath}/LogoutServlet">Logout</a>
    </div>
</div>

<!-- Main content -->
<main>
    <div class="booking-container">
        <form class="booking-form" action="${pageContext.request.contextPath}/patient/BookingServlet" method="post">
            <h2>Book Appointment</h2>

            <!-- Messages -->
            <% if(session.getAttribute("msg") != null){ %>
                <div class="success" id="successMsg"><%= session.getAttribute("msg") %></div>
                <% session.removeAttribute("msg"); %>
                <script>
                    setTimeout(() => {
                        window.location.href = '<%= request.getContextPath() %>/patient/patient-dashboard.jsp';
                    }, 2000);
                </script>
            <% } %>

            <% if(session.getAttribute("error") != null){ %>
                <div class="error"><%= session.getAttribute("error") %></div>
                <% session.removeAttribute("error"); %>
            <% } %>

            <label for="doctor_id">Select Doctor</label>
            <select name="doctor_id" id="doctor_id" required>
                <%
                    try(Connection con = DBUtil.getConnection()) {
                        String sql = "SELECT id, name, specialization FROM doctors WHERE is_active = TRUE";
                        PreparedStatement ps = con.prepareStatement(sql);
                        ResultSet rs = ps.executeQuery();
                        while(rs.next()){
                %>
                    <option value="<%= rs.getInt("id") %>"><%= rs.getString("name") %> - <%= rs.getString("specialization") %></option>
                <%
                        }
                    } catch(Exception e){ e.printStackTrace(); }
                %>
            </select>

            <label for="slot_id">Select Available Slot</label>
            <select name="slot_id" id="slot_id" required>
                <option value="">-- Select a doctor first --</option>
            </select>

            <label for="notes">Additional Notes (optional)</label>
            <textarea id="notes" name="notes" rows="3" placeholder="Mention symptoms or preferences..."></textarea>

            <button type="submit">Book Now</button>
        </form>
    </div>
</main>

<!-- Footer -->
<footer>
    &copy; 2025 Healthcare Portal. All Rights Reserved. | Designed with ❤️ by <a href="#">YourTeam</a>
</footer>

<!-- Scripts -->
<script>
    // Theme toggle
    const toggleBtn = document.getElementById('themeToggle');
    const currentTheme = localStorage.getItem('theme');
    if(currentTheme === 'light'){ 
        document.body.classList.add('light'); 
        toggleBtn.textContent = '🌞 Light Mode'; 
    }
    toggleBtn.addEventListener('click', () => {
        document.body.classList.toggle('light');
        toggleBtn.textContent = document.body.classList.contains('light') ? '🌞 Light Mode' : '🌙 Dark Mode';
        localStorage.setItem('theme', document.body.classList.contains('light') ? 'light' : 'dark');
    });

    // Dynamic slot loading
    const doctorSelect = document.getElementById('doctor_id');
    const slotSelect = document.getElementById('slot_id');

    doctorSelect.addEventListener('change', () => {
        const doctorId = doctorSelect.value;
        slotSelect.innerHTML = '<option>Loading slots...</option>';

        fetch('<%= request.getContextPath() %>/GetSlotsServlet?doctorId=' + doctorId)
            .then(res => res.json())
            .then(data => {
                slotSelect.innerHTML = '';
                if(data.length === 0){
                    slotSelect.innerHTML = '<option value="">No available slots</option>';
                } else {
                    data.forEach(slot => {
                        const option = document.createElement('option');
                        option.value = slot.id;
                        option.textContent = slot.label;
                        slotSelect.appendChild(option);
                    });
                }
            })
            .catch(err => {
                console.error(err);
                slotSelect.innerHTML = '<option value="">Error loading slots</option>';
            });
    });

    // Load slots for default doctor on page load
    doctorSelect.dispatchEvent(new Event('change'));
</script>

</body>
</html>
