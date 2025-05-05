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
import static com.example.examproject.config.MyListener.sessionService;

@MultipartConfig
@WebServlet("/addMovie")
public class AddMovieServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Part part = req.getPart("photo");
        Attachment attachment = new Attachment();
        attachment.setContent(part.getInputStream().readAllBytes());
        Attachment savedAttachment = attachmentService.save(attachment);

        String movieName = req.getParameter("name");
        Integer duration = Integer.parseInt(req.getParameter("duration"));

        if(!movieService.isHasMovieWithTitle(movieName)){
            resp.sendRedirect("/admin.jsp");
            return;
        }

        Movie movie = new Movie(movieName, savedAttachment, duration);
        try {
            movieService.save(movie);
        }catch (Exception e){
            e.printStackTrace();
        }
        resp.sendRedirect("/actions/addMovie.jsp");
    }
}
