<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Cancel Reservation</title>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Lato:wght@300;400;700&display=swap');
  * { margin:0; padding:0; box-sizing:border-box; }
  :root { --orange:#FF5B32; --cream:#FFF2CF; }
  body { background:var(--cream); font-family:'Lato',sans-serif; }
  header { background:var(--orange); color:var(--cream); padding:22px 30px; display:flex; align-items:center; gap:16px; }
  header a { color:var(--cream); text-decoration:none; font-size:1.3rem; }
  header h2 { font-family:'Playfair Display',serif; font-size:1.5rem; }
  .container { max-width:440px; margin:60px auto; background:#fff; border-radius:14px; padding:40px 36px; box-shadow:0 4px 24px rgba(0,0,0,0.08); border-top:4px solid var(--orange); text-align:center; }
  .icon { font-size:3rem; margin-bottom:12px; }
  h3 { font-family:'Playfair Display',serif; color:#333; margin-bottom:24px; }
  .form-group { margin-bottom:20px; text-align:left; }
  label { display:block; margin-bottom:6px; font-size:0.85rem; font-weight:700; color:#444; text-transform:uppercase; letter-spacing:0.8px; }
  input { width:100%; padding:11px 14px; border:1.5px solid #ddd; border-radius:8px; font-size:0.97rem; background:var(--cream); font-family:'Lato',sans-serif; }
  input:focus { outline:none; border-color:var(--orange); background:#fff; }
  .btn { width:100%; padding:13px; background:#e53935; color:#fff; border:none; border-radius:8px; font-size:1rem; font-family:'Playfair Display',serif; cursor:pointer; }
  .btn:hover { background:#c62828; }
  .msg { padding:12px 16px; border-radius:8px; margin-bottom:20px; font-size:0.93rem; text-align:left; }
  .success { background:#e8f5e9; color:#2e7d32; border-left:4px solid #43a047; }
  .error { background:#ffebee; color:#c62828; border-left:4px solid #e53935; }
  .err-text { color:#e53935; font-size:0.8rem; display:none; text-align:left; }
</style>
</head>
<body>
<header>
  <a href="index.jsp">&#8592;</a>
  <h2>Cancel Reservation</h2>
</header>
<div class="container">
  <div class="icon">🗑️</div>
  <h3>Cancel a Reservation</h3>

  <% String msg = (String) request.getAttribute("message");
     String msgType = (String) request.getAttribute("msgType");
     if (msg != null) { %>
    <div class="msg <%= msgType %>"><%= msg %></div>
  <% } %>

  <form action="DeleteReservationServlet" method="post" onsubmit="return confirmDelete()">
    <div class="form-group">
      <label>Reservation ID</label>
      <input type="number" name="reservationID" id="delID" placeholder="Enter ID to cancel" min="1" required>
      <span class="err-text" id="errDel">Please enter a valid Reservation ID.</span>
    </div>
    <button type="submit" class="btn">Cancel Reservation</button>
  </form>
</div>

<script>
function confirmDelete() {
  const id = document.getElementById('delID').value;
  if (!id || parseInt(id) <= 0) {
    document.getElementById('errDel').style.display = 'block'; return false;
  }
  return confirm('Are you sure you want to cancel Reservation ID: ' + id + '?');
}
</script>
</body>
</html>