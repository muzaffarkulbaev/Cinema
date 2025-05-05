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
import java.util.List;

import static com.example.examproject.config.MyListener.*;
import static com.example.examproject.config.MyListener.hallService;

@WebServlet("/deleteMovie")
public class DeleteMovieServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            int movieId = Integer.parseInt(req.getParameter("movieId"));
            Movie movie = movieService.getById(Movie.class, movieId);
            List<Session> sessions = sessionService.getAll(Session.class);
            for (Session session : sessions) {
                if (session.getMovie().getId() == movieId) {
                    ticketService.deleteWithSession(session);
                    Hall hall = hallService.getById(Hall.class, session.getHall().getId());
                    hall.setIsAvailable(true);
                    hallService.save(hall);
                    sessionService.remove(Session.class, session.getId());
                }
            }
            movieService.remove(Movie.class, movieId);
        }catch (Exception e){
            e.printStackTrace();
        }

        resp.sendRedirect("/actions/movieList.jsp");
    }
}
