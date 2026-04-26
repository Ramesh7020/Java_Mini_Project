<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Reservation, java.util.List" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>All Reservations</title>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Lato:wght@300;400;700&display=swap');
  * { margin:0; padding:0; box-sizing:border-box; }
  :root { --orange:#FF5B32; --cream:#FFF2CF; }
  body { background:var(--cream); font-family:'Lato',sans-serif; }
  header { background:var(--orange); color:var(--cream); padding:22px 30px; display:flex; align-items:center; gap:16px; }
  header a { color:var(--cream); text-decoration:none; font-size:1.3rem; }
  header h2 { font-family:'Playfair Display',serif; font-size:1.5rem; }
  .container { max-width:960px; margin:36px auto; padding:0 20px; }
  .table-wrap { background:#fff; border-radius:14px; box-shadow:0 4px 20px rgba(0,0,0,0.07); overflow:hidden; }
  table { width:100%; border-collapse:collapse; }
  thead { background:var(--orange); color:var(--cream); }
  thead th { padding:14px 16px; text-align:left; font-size:0.85rem; text-transform:uppercase; letter-spacing:0.8px; font-weight:700; }
  tbody tr { border-bottom:1px solid #f0e8d0; transition:background 0.15s; }
  tbody tr:hover { background:var(--cream); }
  tbody td { padding:13px 16px; font-size:0.93rem; color:#333; }
  .badge { display:inline-block; padding:3px 10px; border-radius:20px; font-size:0.8rem; font-weight:700; background:#FFF2CF; color:var(--orange); border:1px solid var(--orange); }
  .empty { text-align:center; padding:40px; color:#aaa; }
  .count { margin-bottom:14px; color:#666; font-size:0.9rem; }
  .msg { padding:12px 16px; border-radius:8px; margin-bottom:16px; font-size:0.93rem; }
  .error { background:#ffebee; color:#c62828; border-left:4px solid #e53935; }
</style>
</head>
<body>
<header>
  <a href="index.jsp">&#8592;</a>
  <h2>All Reservations</h2>
</header>
<div class="container">
  <% String msg = (String) request.getAttribute("message");
     if (msg != null) { %><div class="msg error"><%= msg %></div><% } %>

  <%
    List<Reservation> list = (List<Reservation>) request.getAttribute("reservations");
    if (list != null && !list.isEmpty()) {
  %>
  <p class="count">Showing <strong><%= list.size() %></strong> reservation(s)</p>
  <div class="table-wrap">
    <table>
      <thead>
        <tr>
          <th>ID</th><th>Customer</th><th>Room</th><th>Check-In</th><th>Check-Out</th><th>Amount (₹)</th>
        </tr>
      </thead>
      <tbody>
        <% for (Reservation r : list) { %>
        <tr>
          <td><span class="badge">#<%= r.getReservationID() %></span></td>
          <td><%= r.getCustomerName() %></td>
          <td><%= r.getRoomNumber() %></td>
          <td><%= r.getCheckIn() %></td>
          <td><%= r.getCheckOut() %></td>
          <td>₹<%= r.getTotalAmount() %></td>
        </tr>
        <% } %>
      </tbody>
    </table>
  </div>
  <% } else { %>
  <div class="table-wrap"><div class="empty">No reservations found.</div></div>
  <% } %>
</div>
</body>
</html>