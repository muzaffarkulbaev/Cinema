package com.example.examproject.servlets.actions;

import com.example.examproject.entity.Hall;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static com.example.examproject.config.MyListener.hallService;

@WebServlet("/addHall")
public class AddHallServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Hall hall = new Hall();
        hall.setIsAvailable(true);
        hallService.save(hall);
        resp.sendRedirect("/actions/addHall.jsp");
    }
}
