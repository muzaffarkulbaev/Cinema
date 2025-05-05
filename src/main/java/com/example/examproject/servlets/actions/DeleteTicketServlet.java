package com.example.examproject.servlets.actions;

import com.example.examproject.entity.Seat;
import com.example.examproject.entity.Ticket;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static com.example.examproject.config.MyListener.seatService;
import static com.example.examproject.config.MyListener.ticketService;

@WebServlet("/deleteTicket")
public class DeleteTicketServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int ticketId = Integer.parseInt(req.getParameter("ticket"));
        Ticket ticket = ticketService.getById(Ticket.class, ticketId);
        Seat seat = seatService.getById(Seat.class, ticket.getSeat().getId());
        seat.setIsBooked(false);
        seatService.save(seat);
//        ticketService.remove(Ticket.class, ticketId);
        ticket.setIsDeleted(true);
        ticketService.save(ticket);
        resp.sendRedirect("/myTickets.jsp");
    }
}
