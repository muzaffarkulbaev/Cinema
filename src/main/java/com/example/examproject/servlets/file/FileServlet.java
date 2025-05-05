package com.example.examproject.servlets.file;

import com.example.examproject.entity.Attachment;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

import static com.example.examproject.config.MyListener.attachmentService;

@WebServlet("/file/*")
public class FileServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String path = req.getRequestURI();
        int id = Integer.parseInt(path.substring(path.lastIndexOf("/") + 1));

        Attachment attachment = attachmentService.getById(Attachment.class, id);
        if (attachment != null && attachment.getContent() != null) {
            resp.setContentType("image/jpeg");
            resp.getOutputStream().write(attachment.getContent());
        }
    }
}
