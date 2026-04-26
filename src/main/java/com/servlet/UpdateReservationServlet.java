package com.servlet;

import com.dao.ReservationDAO;
import com.model.Reservation;
import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Date;

public class UpdateReservationServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            int id = Integer.parseInt(request.getParameter("id").trim());
            ReservationDAO dao = new ReservationDAO();
            Reservation r = dao.getReservationById(id);
            if (r != null) {
                request.setAttribute("reservation", r);
            } else {
                request.setAttribute("message", "Reservation not found.");
                request.setAttribute("msgType", "error");
            }
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("msgType", "error");
        }
        request.getRequestDispatcher("reservationupdate.jsp").forward(request, response);
    }

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
            boolean success = dao.updateReservation(r);

            request.setAttribute("message", success ? "Reservation updated successfully!" : "Update failed.");
            request.setAttribute("msgType", success ? "success" : "error");
            request.setAttribute("reservation", r);
        } catch (Exception e) {
            request.setAttribute("message", "Error: " + e.getMessage());
            request.setAttribute("msgType", "error");
        }
        request.getRequestDispatcher("reservationupdate.jsp").forward(request, response);
    }
}