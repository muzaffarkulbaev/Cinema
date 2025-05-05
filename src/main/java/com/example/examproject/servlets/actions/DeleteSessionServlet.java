package com.example.examproject.servlets.actions;

import com.example.examproject.entity.Hall;
import com.example.examproject.entity.Session;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static com.example.examproject.config.MyListener.*;

@WebServlet("/deleteSession")
public class DeleteSessionServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int sessionId = Integer.parseInt(req.getParameter("sessionId"));
        Session serviceById = sessionService.getById(Session.class, sessionId);
        ticketService.deleteWithSession(serviceById);
        Hall hall = hallService.getById(Hall.class, serviceById.getHall().getId());
        hall.setIsAvailable(true);
        hallService.save(hall);
        sessionService.remove(Session.class,sessionId);
        resp.sendRedirect("/actions/sessionList.jsp");
    }
}
