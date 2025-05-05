package com.example.examproject.servlets.auth;

import com.example.examproject.dto.RegisterDto;
import com.example.examproject.entity.Attachment;
import com.example.examproject.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

import static com.example.examproject.config.MyListener.*;

@WebServlet("/verify")
public class VerifyServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int code = Integer.parseInt(req.getParameter("code"));
        HttpSession session = req.getSession();
        Object object = session.getAttribute("registerDto");
        if (object == null) {
            resp.sendRedirect("/auth/register.jsp");
            return;
        }
        RegisterDto registerDto = (RegisterDto)object;
        if (!registerDto.getOtp().equals(code)) {
            resp.sendRedirect("/auth/register.jsp");
            return;
        }
        Attachment attachmentById = attachmentService.getById(Attachment.class, registerDto.getAttachmentId());
        User user = new User(registerDto);
        user.setAttachment(attachmentById);
        userService.save(user);
        resp.sendRedirect("/auth/login.jsp");
    }
}
