package com.example.examproject.servlets.book;

import com.example.examproject.entity.Seat;
import com.example.examproject.entity.Session;
import com.example.examproject.entity.Ticket;
import com.example.examproject.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static com.example.examproject.config.MyListener.*;

@WebServlet("/bookPlace")
public class BookPlaceServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String[] seatIdsParam = req.getParameterValues("seatIds");
        int userId = Integer.parseInt(req.getParameter("userId"));
        int sessionId = Integer.parseInt(req.getParameter("sessionId"));

        User user = userService.getById(User.class, userId);
        Session session = sessionService.getById(Session.class, sessionId);

        if (seatIdsParam != null) {
            for (String seatIdStr : seatIdsParam) {
                int seatId = Integer.parseInt(seatIdStr);
                Seat seat = seatService.getById(Seat.class, seatId);

                Ticket ticket = new Ticket();
                ticket.setSeat(seat);
                ticket.setUser(user);
                ticket.setSession(session);

                ticketService.save(ticket);
                seatService.changeStateToBooked(seatId);
            }
        }

        resp.sendRedirect("/cabinet.jsp");
    }
}
