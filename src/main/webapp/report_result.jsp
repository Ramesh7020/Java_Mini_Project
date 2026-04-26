<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Reservation, java.util.List, java.math.BigDecimal" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Report Result</title>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Lato:wght@300;400;700&display=swap');
  * { margin:0; padding:0; box-sizing:border-box; }
  :root { --orange:#FF5B32; --cream:#FFF2CF; }
  body { background:var(--cream); font-family:'Lato',sans-serif; }
  header { background:var(--orange); color:var(--cream); padding:22px 30px; display:flex; align-items:center; gap:16px; }
  header a { color:var(--cream); text-decoration:none; font-size:1.3rem; }
  header h2 { font-family:'Playfair Display',serif; font-size:1.5rem; }
  .container { max-width:860px; margin:36px auto; padding:0 20px; }
  .result-card { background:#fff; border-radius:14px; padding:28px; box-shadow:0 4px 20px rgba(0,0,0,0.07); margin-bottom:20px; border-top:4px solid var(--orange); }
  .result-card h3 { font-family:'Playfair Display',serif; color:var(--orange); margin-bottom:18px; }
  table { width:100%; border-collapse:collapse; }
  thead { background:var(--orange); color:var(--cream); }
  thead th { padding:12px 14px; text-align:left; font-size:0.83rem; text-transform:uppercase; letter-spacing:0.7px; }
  tbody tr:nth-child(even) { background:var(--cream); }
  tbody td { padding:12px 14px; font-size:0.92rem; color:#333; border-bottom:1px solid #f0e8d0; }
  .revenue-box { text-align:center; padding:30px; }
  .revenue-box .amount { font-family:'Playfair Display',serif; font-size:2.6rem; color:var(--orange); }
  .revenue-box .label { color:#888; font-size:0.9rem; margin-top:6px; }
  .empty { color:#aaa; text-align:center; padding:24px; }
  .back-btn { display:inline-block; margin-bottom:20px; color:var(--orange); text-decoration:none; font-weight:700; font-size:0.9rem; }
  .msg { padding:12px 16px; border-radius:8px; margin-bottom:16px; }
  .error { background:#ffebee; color:#c62828; border-left:4px solid #e53935; }
</style>
</head>
<body>
<header>
  <a href="ReportCriteriaServlet">&#8592;</a>
  <h2>Report Result</h2>
</header>
<div class="container">
  <% String errMsg = (String) request.getAttribute("message");
     if (errMsg != null) { %><div class="msg error"><%= errMsg %></div><% } %>

  <% String reportType = (String) request.getAttribute("reportType"); %>

  <!-- DATE RANGE REPORT -->
  <% if ("dateRange".equals(reportType)) {
       List<Reservation> res = (List<Reservation>) request.getAttribute("dateRangeResults"); %>
  <div class="result-card">
    <h3>📅 Reservations: <%= request.getAttribute("fromDate") %> to <%= request.getAttribute("toDate") %></h3>
    <% if (res != null && !res.isEmpty()) { %>
    <table>
      <thead><tr><th>ID</th><th>Customer</th><th>Room</th><th>Check-In</th><th>Check-Out</th><th>Amount (₹)</th></tr></thead>
      <tbody>
        <% for (Reservation r : res) { %>
        <tr>
          <td>#<%= r.getReservationID() %></td>
          <td><%= r.getCustomerName() %></td>
          <td><%= r.getRoomNumber() %></td>
          <td><%= r.getCheckIn() %></td>
          <td><%= r.getCheckOut() %></td>
          <td>₹<%= r.getTotalAmount() %></td>
        </tr>
        <% } %>
      </tbody>
    </table>
    <% } else { %><div class="empty">No reservations found in this range.</div><% } %>
  </div>
  <% } %>

  <!-- MOST BOOKED ROOMS -->
  <% if ("mostBooked".equals(reportType)) {
       List<String[]> rooms = (List<String[]>) request.getAttribute("mostBookedResults"); %>
  <div class="result-card">
    <h3>🏆 Most Frequently Booked Rooms</h3>
    <% if (rooms != null && !rooms.isEmpty()) { %>
    <table>
      <thead><tr><th>Room Number</th><th>Booking Count</th></tr></thead>
      <tbody>
        <% for (String[] row : rooms) { %>
        <tr><td><%= row[0] %></td><td><strong><%= row[1] %></strong></td></tr>
        <% } %>
      </tbody>
    </table>
    <% } else { %><div class="empty">No data found.</div><% } %>
  </div>
  <% } %>

  <!-- REVENUE REPORT -->
  <% if ("revenue".equals(reportType)) {
       BigDecimal rev = (BigDecimal) request.getAttribute("revenue"); %>
  <div class="result-card">
    <h3>💰 Revenue: <%= request.getAttribute("fromDate") %> to <%= request.getAttribute("toDate") %></h3>
    <div class="revenue-box">
      <div class="amount">₹<%= rev != null ? rev : "0.00" %></div>
      <div class="label">Total Revenue Generated</div>
    </div>
  </div>
  <% } %>

</div>
</body>
</html>