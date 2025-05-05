package com.example.examproject.servlets.actions;

import com.example.examproject.dto.SessionDto;
import com.example.examproject.entity.Attachment;
import com.example.examproject.entity.Hall;
import com.example.examproject.entity.Movie;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

import java.io.IOException;

import static com.example.examproject.config.MyListener.*;

@WebServlet("/addSessionServlet")
public class AddSessionServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        String time = req.getParameter("time");
        Integer movieId = Integer.parseInt(req.getParameter("movieId"));
        Movie movie = movieService.getById(Movie.class, movieId);
        int price = Integer.parseInt(req.getParameter("price"));
        int hallId = Integer.parseInt(req.getParameter("hallId"));
        Hall hall = hallService.getById(Hall.class, hallId);
        hall.setIsAvailable(false);
        Hall savedHall = hallService.save(hall);

        SessionDto sessionDto = new SessionDto(movie,time,price,savedHall);
        sessionService.saveDto(sessionDto);
        resp.sendRedirect("/admin.jsp");

    }
}
