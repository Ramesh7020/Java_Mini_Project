<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="com.model.Reservation" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Update Reservation</title>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Lato:wght@300;400;700&display=swap');
  * { margin:0; padding:0; box-sizing:border-box; }
  :root { --orange:#FF5B32; --cream:#FFF2CF; }
  body { background:var(--cream); font-family:'Lato',sans-serif; }
  header { background:var(--orange); color:var(--cream); padding:22px 30px; display:flex; align-items:center; gap:16px; }
  header a { color:var(--cream); text-decoration:none; font-size:1.3rem; }
  header h2 { font-family:'Playfair Display',serif; font-size:1.5rem; }
  .container { max-width:540px; margin:40px auto; background:#fff; border-radius:14px; padding:36px; box-shadow:0 4px 24px rgba(0,0,0,0.08); border-top:4px solid var(--orange); }
  .search-bar { display:flex; gap:10px; margin-bottom:28px; }
  .search-bar input { flex:1; padding:11px 14px; border:1.5px solid #ddd; border-radius:8px; font-size:0.97rem; background:var(--cream); }
  .search-bar input:focus { outline:none; border-color:var(--orange); }
  .search-bar button { padding:11px 20px; background:var(--orange); color:#fff; border:none; border-radius:8px; cursor:pointer; font-family:'Lato',sans-serif; font-weight:700; }
  .form-group { margin-bottom:18px; }
  label { display:block; margin-bottom:6px; font-size:0.85rem; font-weight:700; color:#444; text-transform:uppercase; letter-spacing:0.8px; }
  input[type=text], input[type=date], input[type=number] { width:100%; padding:11px 14px; border:1.5px solid #ddd; border-radius:8px; font-size:0.97rem; background:var(--cream); font-family:'Lato',sans-serif; }
  input:focus { outline:none; border-color:var(--orange); background:#fff; }
  input[readonly] { background:#f5f5f5; color:#888; }
  .btn { width:100%; padding:13px; background:var(--orange); color:#fff; border:none; border-radius:8px; font-size:1rem; font-family:'Playfair Display',serif; cursor:pointer; margin-top:4px; }
  .btn:hover { opacity:0.88; }
  .msg { padding:12px 16px; border-radius:8px; margin-bottom:20px; font-size:0.93rem; }
  .success { background:#e8f5e9; color:#2e7d32; border-left:4px solid #43a047; }
  .error { background:#ffebee; color:#c62828; border-left:4px solid #e53935; }
  .err-text { color:#e53935; font-size:0.8rem; display:none; }
</style>
</head>
<body>
<header>
  <a href="index.jsp">&#8592;</a>
  <h2>Update Reservation</h2>
</header>
<div class="container">
  <% String msg = (String) request.getAttribute("message");
     String msgType = (String) request.getAttribute("msgType");
     if (msg != null) { %>
    <div class="msg <%= msgType %>"><%= msg %></div>
  <% } %>

  <!-- Search -->
  <form action="UpdateReservationServlet" method="get">
    <div class="search-bar">
      <input type="number" name="id" placeholder="Enter Reservation ID to search" required min="1">
      <button type="submit">Search</button>
    </div>
  </form>

  <%
    Reservation r = (Reservation) request.getAttribute("reservation");
    if (r != null) {
  %>
  <form action="UpdateReservationServlet" method="post" onsubmit="return validateUpdate()">
    <div class="form-group">
      <label>Reservation ID</label>
      <input type="number" name="reservationID" value="<%= r.getReservationID() %>" readonly>
    </div>
    <div class="form-group">
      <label>Customer Name</label>
      <input type="text" name="customerName" id="custName" value="<%= r.getCustomerName() %>" required maxlength="100">
      <span class="err-text" id="errName">Name must be at least 2 characters.</span>
    </div>
    <div class="form-group">
      <label>Room Number</label>
      <input type="text" name="roomNumber" id="roomNo" value="<%= r.getRoomNumber() %>" required maxlength="10">
      <span class="err-text" id="errRoom">Room number is required.</span>
    </div>
    <div class="form-group">
      <label>Check-In Date</label>
      <input type="date" name="checkIn" id="checkIn" value="<%= r.getCheckIn() %>" required>
    </div>
    <div class="form-group">
      <label>Check-Out Date</label>
      <input type="date" name="checkOut" id="checkOut" value="<%= r.getCheckOut() %>" required>
      <span class="err-text" id="errCheckOut">Check-out must be after check-in.</span>
    </div>
    <div class="form-group">
      <label>Total Amount (₹)</label>
      <input type="number" name="totalAmount" id="amount" value="<%= r.getTotalAmount() %>" step="0.01" min="0" required>
      <span class="err-text" id="errAmount">Enter a valid amount.</span>
    </div>
    <button type="submit" class="btn">Update Reservation</button>
  </form>
  <% } %>
</div>

<script>
function validateUpdate() {
  let valid = true;
  document.querySelectorAll('.err-text').forEach(e => e.style.display = 'none');
  const name = document.getElementById('custName').value.trim();
  if (name.length < 2) { document.getElementById('errName').style.display = 'block'; valid = false; }
  const room = document.getElementById('roomNo').value.trim();
  if (!room) { document.getElementById('errRoom').style.display = 'block'; valid = false; }
  const ci = document.getElementById('checkIn').value;
  const co = document.getElementById('checkOut').value;
  if (co <= ci) { document.getElementById('errCheckOut').style.display = 'block'; valid = false; }
  const amt = document.getElementById('amount').value;
  if (parseFloat(amt) < 0) { document.getElementById('errAmount').style.display = 'block'; valid = false; }
  return valid;
}
</script>
</body>
</html>