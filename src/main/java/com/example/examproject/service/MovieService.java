package com.example.examproject.service;

import com.example.examproject.dto.SessionTotalPage;
import com.example.examproject.entity.Movie;
import com.example.examproject.entity.Session;
import com.example.examproject.entity.Ticket;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.List;

import static com.example.examproject.config.MyListener.EMF;

public class MovieService extends TemplateService<Movie> {

    public boolean isHasMovieWithTitle(String title) {
        try (
                EntityManager entityManager = EMF.createEntityManager()
        ){
            TypedQuery<Long> query = entityManager.createQuery("select count(m) from Movie m where m.name ilike :title", Long.class);
            query.setParameter("title", title);
            if (query.getSingleResult() > 0) {
                return false;
            }
            return true;
        }
    }
}
