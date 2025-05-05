package com.example.examproject.servlets.auth;

import com.example.examproject.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static com.example.examproject.config.MyListener.userService;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        User user = userService.findByEmail(email);
        if (user != null && user.getPassword().equals(password)) {
            req.getSession().setAttribute("user", user);
            System.out.println("user.toString() = " + user.toString());
        }else {
            System.out.println("User is null");
            resp.sendRedirect("/auth/login.jsp");
            return;
        }
        resp.sendRedirect("/cabinet.jsp");
    }
}
