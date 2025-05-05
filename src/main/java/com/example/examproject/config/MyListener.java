package com.example.examproject.config;

import com.example.examproject.service.*;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

@WebListener
public class MyListener implements ServletContextListener {
    public static EntityManagerFactory EMF;

    public static UserService userService;
    public static AttachmentService attachmentService;
    public static HallService hallService;
    public static SeatService seatService;
    public static TicketService ticketService;
    public static SessionService sessionService;
    public static MovieService movieService;

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        EMF = Persistence.createEntityManagerFactory("myPersistence");
        userService = new UserService();
        attachmentService = new AttachmentService();
        hallService = new HallService();
        seatService = new SeatService();
        ticketService = new TicketService();
        sessionService = new SessionService();
        movieService = new MovieService();
    }
}
