package com.servlet;

import com.dao.ReservationDAO;
import com.model.Reservation;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;

public class AddReservationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("reservationID").trim());
            String name = request.getParameter("customerName").trim();
            String room = request.getParameter("roomNumber").trim();
            Date checkIn = Date.valueOf(request.getParameter("checkIn"));
            Date checkOut = Date.valueOf(request.getParameter("checkOut"));
            BigDecimal amount = new BigDecimal(request.getParameter("totalAmount").trim());

            Reservation r = new Reservation(id, name, room, checkIn, checkOut, amount);
            ReservationDAO dao = new ReservationDAO();
            boolean success = dao.addReservation(r);

            request.setAttribute("message", success ? "Reservation added successfully!" : "Failed to add reservation.");
            request.setAttribute("msgType", success ? "success" : "error");
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("msgType", "error");
        }
        request.getRequestDispatcher("reservationadd.jsp").forward(request, response);
    }
}