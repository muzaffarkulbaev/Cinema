package com.example.examproject.config;


import com.example.examproject.entity.User;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.HashSet;
import java.util.Set;

@WebFilter(urlPatterns = "/*")
public class MyFilter implements Filter {

    HashSet<String> openPages = new HashSet<>(Set.of(
            "/auth/login.jsp",
            "/auth/register.jsp",
            "/auth/verify.jsp",
            "/login",
            "/register",
            "/verify"
    ));

    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException, ServletException, ServletException {
        HttpServletRequest request = (HttpServletRequest)servletRequest;
        HttpServletResponse response = (HttpServletResponse)servletResponse;

        String url = request.getRequestURI();
        if (openPages.contains(url)) {
            System.out.println("It contains");
            filterChain.doFilter(request, response);
            return;
        }

        User user = (User)request.getSession().getAttribute("user");
        if (user == null) {
            response.sendRedirect("/auth/login.jsp");
            return;
        }

        System.out.println("Login fall");

        filterChain.doFilter(servletRequest, servletResponse);
    }

}
