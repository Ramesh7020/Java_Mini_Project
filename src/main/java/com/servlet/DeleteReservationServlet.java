package com.servlet;

import com.dao.ReservationDAO;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;

public class DeleteReservationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("reservationID").trim());
            ReservationDAO dao = new ReservationDAO();
            boolean success = dao.deleteReservation(id);
            request.setAttribute("message", success ? "Reservation cancelled successfully!" : "No reservation found with that ID.");
            request.setAttribute("msgType", success ? "success" : "error");
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("msgType", "error");
        }
        request.getRequestDispatcher("reservationdelete.jsp").forward(request, response);
    }
}