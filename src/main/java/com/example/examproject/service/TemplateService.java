package com.example.examproject.service;

import com.example.examproject.entity.Attachment;
import com.example.examproject.entity.TemplateEntity;
import jakarta.persistence.EntityManager;

import java.util.List;

import static com.example.examproject.config.MyListener.EMF;

public class TemplateService<T extends TemplateEntity> {
    public T save(T t){
        try (
                EntityManager entityManager = EMF.createEntityManager()
        ){
            entityManager.getTransaction().begin();
            if (t.getId() == null){
                entityManager.persist(t);
                entityManager.flush();
            }else entityManager.merge(t);
            entityManager.getTransaction().commit();
            return t;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public void remove(Class<T> clazz,Integer id) {
        try (
                EntityManager entityManager = EMF.createEntityManager();
        ){
            entityManager.getTransaction().begin();
            T t = entityManager.find(clazz, id);
            entityManager.remove(t);
            entityManager.getTransaction().commit();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public List<T> getAll(Class<T> clazz) {
        try (
                EntityManager em = EMF.createEntityManager();
        ){
            List<T> resultList = em.createQuery("select s from %s s order by s.id".formatted(clazz.getName()), clazz).getResultList();
            return resultList;
        }
    }

    public T getById(Class<T> clazz,int id) {
        try (
                EntityManager entityManager = EMF.createEntityManager();
        ){
            T t = entityManager.find(clazz, id);
            return t;
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}
