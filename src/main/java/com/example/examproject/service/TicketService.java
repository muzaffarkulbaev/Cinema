package com.example.examproject.service;

import com.example.examproject.entity.Session;
import com.example.examproject.entity.Ticket;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

import static com.example.examproject.config.MyListener.EMF;

public class TicketService extends TemplateService<Ticket>{
    public void deleteWithSession(Session serviceById) {
        try (
                EntityManager entityManager = EMF.createEntityManager();
        ){
            TypedQuery<Ticket> query = entityManager.createQuery("select m from Ticket m where m.session.id = :id", Ticket.class);
            query.setParameter("id", serviceById.getId());
            List<Ticket> resultList = query.getResultList();
            for (Ticket ticket : resultList) {
//                remove(Ticket.class,ticket.getId());
                ticket.setIsDeleted(true);
                save(ticket);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
