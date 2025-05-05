package com.example.examproject.servlets.actions;

import com.example.examproject.entity.Hall;
import com.example.examproject.entity.Movie;
import com.example.examproject.entity.Session;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static com.example.examproject.config.MyListener.*;

@WebServlet("/editSession")
public class EditSessionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int movieId = Integer.parseInt(req.getParameter("movieId"));
        int hallId = Integer.parseInt(req.getParameter("hallId"));
        int sessionId = Integer.parseInt(req.getParameter("sessionId"));
        String time = req.getParameter("time");
        String price = req.getParameter("price");

        Session session = sessionService.getById(Session.class, sessionId);

        Hall hall = hallService.getById(Hall.class, session.getHall().getId());
        hall.setIsAvailable(true);
        hallService.save(hall);


        movieService.getById(Movie.class, movieId);

        resp.sendRedirect("/actions/editSession.jsp");
    }
}
