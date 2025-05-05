package com.example.examproject.servlets.actions;

import com.example.examproject.entity.Hall;
import com.example.examproject.entity.Seat;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static com.example.examproject.config.MyListener.hallService;
import static com.example.examproject.config.MyListener.seatService;

@WebServlet("/addSeats")
public class AddSeats extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int hallId = Integer.parseInt(req.getParameter("hall"));
        int seatCount = Integer.parseInt(req.getParameter("seatCount"));
        Hall hall = hallService.getById(Hall.class, hallId);
        for (int i = 0; i < seatCount; i++) {
            Seat seat = new Seat(false, hall);
            seatService.save(seat);
        }
        resp.sendRedirect("/actions/addSeats.jsp");
    }
}
