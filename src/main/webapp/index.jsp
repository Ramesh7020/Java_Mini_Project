<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Hotel Management System</title>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Lato:wght@300;400;700&display=swap');
  * { margin: 0; padding: 0; box-sizing: border-box; }
  :root { --orange: #FF5B32; --cream: #FFF2CF; --dark: #1a1a1a; --shadow: rgba(255,91,50,0.18); }
  body { background: var(--cream); font-family: 'Lato', sans-serif; min-height: 100vh; }
  header {
    background: var(--orange); color: var(--cream); text-align: center;
    padding: 36px 20px 28px; box-shadow: 0 4px 18px var(--shadow);
  }
  header h1 { font-family: 'Playfair Display', serif; font-size: 2.6rem; letter-spacing: 1px; }
  header p { font-size: 1rem; opacity: 0.88; margin-top: 6px; font-weight: 300; letter-spacing: 2px; text-transform: uppercase; }
  .nav-grid {
    display: grid; grid-template-columns: repeat(auto-fit, minmax(220px, 1fr));
    gap: 24px; max-width: 960px; margin: 50px auto; padding: 0 24px;
  }
  .card {
    background: #fff; border-radius: 14px; padding: 32px 24px; text-align: center;
    box-shadow: 0 4px 20px rgba(0,0,0,0.07); border-top: 4px solid var(--orange);
    transition: transform 0.2s, box-shadow 0.2s; cursor: pointer; text-decoration: none; color: inherit;
    display: block;
  }
  .card:hover { transform: translateY(-5px); box-shadow: 0 10px 32px var(--shadow); }
  .card .icon { font-size: 2.4rem; margin-bottom: 12px; }
  .card h3 { font-family: 'Playfair Display', serif; font-size: 1.15rem; color: var(--dark); margin-bottom: 8px; }
  .card p { font-size: 0.88rem; color: #888; font-weight: 300; }
  footer { text-align: center; padding: 28px; color: #aaa; font-size: 0.82rem; margin-top: 30px; }
</style>
</head>
<body>
<header>
  <h1>🏨 Hotel Management System</h1>
  <p>Reservations &bull; Rooms &bull; Reports</p>
</header>

<div class="nav-grid">
  <a class="card" href="reservationadd.jsp">
    <div class="icon">➕</div>
    <h3>Add Reservation</h3>
    <p>Book a new room for a customer</p>
  </a>
  <a class="card" href="reservationupdate.jsp">
    <div class="icon">✏️</div>
    <h3>Update Reservation</h3>
    <p>Modify existing booking details</p>
  </a>
  <a class="card" href="reservationdelete.jsp">
    <div class="icon">❌</div>
    <h3>Cancel Reservation</h3>
    <p>Remove a reservation by ID</p>
  </a>
  <a class="card" href="DisplayReservationsServlet">
    <div class="icon">📋</div>
    <h3>View All Reservations</h3>
    <p>See current occupancy list</p>
  </a>
  <a class="card" href="ReportCriteriaServlet">
    <div class="icon">📊</div>
    <h3>Reports</h3>
    <p>Revenue, date range & room stats</p>
  </a>
</div>

<footer>&copy; 2024 Hotel Management System &mdash; Mini Project</footer>
</body>
</html>