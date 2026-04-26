<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Reports</title>
<style>
  @import url('https://fonts.googleapis.com/css2?family=Playfair+Display:wght@700&family=Lato:wght@300;400;700&display=swap');
  * { margin:0; padding:0; box-sizing:border-box; }
  :root { --orange:#FF5B32; --cream:#FFF2CF; }
  body { background:var(--cream); font-family:'Lato',sans-serif; }
  header { background:var(--orange); color:var(--cream); padding:22px 30px; display:flex; align-items:center; gap:16px; }
  header a { color:var(--cream); text-decoration:none; font-size:1.3rem; }
  header h2 { font-family:'Playfair Display',serif; font-size:1.5rem; }
  .container { max-width:520px; margin:40px auto; padding:0 20px; }
  .card { background:#fff; border-radius:14px; padding:30px; box-shadow:0 4px 20px rgba(0,0,0,0.07); margin-bottom:22px; border-left:4px solid var(--orange); }
  .card h3 { font-family:'Playfair Display',serif; color:var(--orange); margin-bottom:18px; font-size:1.1rem; }
  .form-group { margin-bottom:14px; }
  label { display:block; margin-bottom:5px; font-size:0.83rem; font-weight:700; color:#555; text-transform:uppercase; letter-spacing:0.7px; }
  input[type=date] { width:100%; padding:10px 13px; border:1.5px solid #ddd; border-radius:8px; font-size:0.95rem; background:var(--cream); font-family:'Lato',sans-serif; }
  input:focus { outline:none; border-color:var(--orange); }
  .btn { padding:11px 24px; background:var(--orange); color:#fff; border:none; border-radius:8px; cursor:pointer; font-family:'Lato',sans-serif; font-weight:700; font-size:0.9rem; }
  .btn:hover { opacity:0.88; }
  .btn-outline { background:#fff; color:var(--orange); border:2px solid var(--orange); }
</style>
</head>
<body>
<header>
  <a href="index.jsp">&#8592;</a>
  <h2>Reports</h2>
</header>
<div class="container">

  <!-- Date Range Report -->
  <div class="card">
    <h3>📅 Reservations in Date Range</h3>
    <form action="ReportServlet" method="post" onsubmit="return validateDates(this)">
      <input type="hidden" name="reportType" value="dateRange">
      <div class="form-group">
        <label>From Date</label>
        <input type="date" name="fromDate" required>
      </div>
      <div class="form-group">
        <label>To Date</label>
        <input type="date" name="toDate" required>
      </div>
      <button type="submit" class="btn">Generate Report</button>
    </form>
  </div>

  <!-- Most Booked Rooms -->
  <div class="card">
    <h3>🏆 Most Frequently Booked Rooms</h3>
    <form action="ReportServlet" method="post">
      <input type="hidden" name="reportType" value="mostBooked">
      <p style="color:#888; font-size:0.88rem; margin-bottom:14px;">Shows all rooms ranked by number of bookings.</p>
      <button type="submit" class="btn">Generate Report</button>
    </form>
  </div>

  <!-- Revenue Report -->
  <div class="card">
    <h3>💰 Total Revenue Over a Period</h3>
    <form action="ReportServlet" method="post" onsubmit="return validateDates(this)">
      <input type="hidden" name="reportType" value="revenue">
      <div class="form-group">
        <label>From Date</label>
        <input type="date" name="fromDate" required>
      </div>
      <div class="form-group">
        <label>To Date</label>
        <input type="date" name="toDate" required>
      </div>
      <button type="submit" class="btn">Generate Report</button>
    </form>
  </div>

</div>
<script>
function validateDates(form) {
  const from = form.querySelector('[name=fromDate]').value;
  const to = form.querySelector('[name=toDate]').value;
  if (to < from) { alert('To date must be after From date.'); return false; }
  return true;
}
</script>
</body>
</html>