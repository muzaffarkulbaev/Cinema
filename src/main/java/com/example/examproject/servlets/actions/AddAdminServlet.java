package com.example.examproject.servlets.actions;

import com.example.examproject.entity.User;
import com.example.examproject.entity.enums.Role;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static com.example.examproject.config.MyListener.userService;

@WebServlet("/addAdminServlet")
public class AddAdminServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int id = Integer.parseInt(req.getParameter("userId"));
        User byId = userService.getById(User.class, id);
        byId.setRole(Role.ADMIN);
        userService.setRole(byId, Role.ADMIN);
        resp.sendRedirect("/superAdmin.jsp");
    }
}
