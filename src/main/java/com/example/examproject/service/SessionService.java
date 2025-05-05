package com.example.examproject.service;

import com.example.examproject.dto.SessionDto;
import com.example.examproject.dto.SessionTotalPage;
import com.example.examproject.entity.Movie;
import com.example.examproject.entity.Session;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;

import java.util.Collections;
import java.util.List;

import static com.example.examproject.config.MyListener.EMF;

public class SessionService extends TemplateService<Session>{

    public Session saveDto(SessionDto sessionDto) {
        Session buildSession = Session.builder()
                .movie(sessionDto.movie())
                .time(sessionDto.time())
                .price(sessionDto.price())
                .hall(sessionDto.hall())
                .build();

        return save(buildSession);
    }

    public SessionTotalPage getByFilter(String search, int minPrice, int maxPrice, int currentPage) {
        try (EntityManager entityManager = EMF.createEntityManager()) {
            // Исправлен ilike -> lower(m.name) like lower(...)
            TypedQuery<Movie> query = entityManager.createQuery(
                    "select m from Movie m where lower(m.name) like lower(concat(:search, '%'))", Movie.class);
            query.setParameter("search", search);
            List<Movie> movieList = query.getResultList();

            if (movieList.isEmpty()) {
                return new SessionTotalPage(Collections.emptyList(), 0);
            }

            int maxPlusOne = maxPrice + 1;

            TypedQuery<Session> typedQuery = entityManager.createQuery(
                    "select p from Session p where p.movie in :movieList and price > :min and price < :max", Session.class);
            typedQuery.setParameter("movieList", movieList);
            typedQuery.setParameter("min", minPrice);
            typedQuery.setParameter("max", maxPlusOne);
            typedQuery.setFirstResult((currentPage - 1) * 3);
            typedQuery.setMaxResults(3);

            TypedQuery<Long> typedQuery1 = entityManager.createQuery(
                    "select count(p) from Session p where p.movie in :movieList and price > :min and price < :max", Long.class);
            typedQuery1.setParameter("movieList", movieList);
            typedQuery1.setParameter("min", minPrice);
            typedQuery1.setParameter("max", maxPlusOne);

            long totalCount = typedQuery1.getSingleResult();
            System.out.println("totalCount = " + totalCount);
            int totalPages = (int) ((totalCount + 2) / 3);

            return new SessionTotalPage(typedQuery.getResultList(), totalPages);
        }
    }


}
