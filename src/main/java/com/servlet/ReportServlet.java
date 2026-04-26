package com.servlet;

import com.dao.ReservationDAO;
import com.model.Reservation;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;
import java.util.List;

public class ReportServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String reportType = request.getParameter("reportType");
        ReservationDAO dao = new ReservationDAO();
        try {
            if ("dateRange".equals(reportType)) {
                Date from = Date.valueOf(request.getParameter("fromDate"));
                Date to = Date.valueOf(request.getParameter("toDate"));
                List<Reservation> list = dao.getReservationsByDateRange(from, to);
                request.setAttribute("dateRangeResults", list);
                request.setAttribute("fromDate", request.getParameter("fromDate"));
                request.setAttribute("toDate", request.getParameter("toDate"));
            } else if ("mostBooked".equals(reportType)) {
                List<String[]> rooms = dao.getMostBookedRooms();
                request.setAttribute("mostBookedResults", rooms);
            } else if ("revenue".equals(reportType)) {
                Date from = Date.valueOf(request.getParameter("fromDate"));
                Date to = Date.valueOf(request.getParameter("toDate"));
                BigDecimal revenue = dao.getTotalRevenue(from, to);
                request.setAttribute("revenue", revenue);
                request.setAttribute("fromDate", request.getParameter("fromDate"));
                request.setAttribute("toDate", request.getParameter("toDate"));
            }
            request.setAttribute("reportType", reportType);
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("msgType", "error");
        }
        request.getRequestDispatcher("report_result.jsp").forward(request, response);
    }
}