package com.example.examproject.service;

import com.example.examproject.entity.User;
import com.example.examproject.entity.enums.Role;
import jakarta.persistence.EntityManager;

import java.util.List;

import static com.example.examproject.config.MyListener.EMF;

public class UserService extends TemplateService<User>{
    public User findByEmail(String email) {
        try (
                EntityManager entityManager = EMF.createEntityManager();
        ){
            try {
                return entityManager.createQuery("select u from User u where u.email = :email", User.class).setParameter("email",email).getSingleResult();
            }catch (Exception e){
                return null;
            }
        }catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    public List<User> getAdmins() {
        List<User> users = getAll(User.class);
        users.removeIf(u -> u.getRole() == Role.USER || u.getRole() == Role.SUPER_ADMIN);
        return users;
    }

    public List<User> getOnlyUsers() {
        List<User> users = getAll(User.class);
        users.removeIf(u -> u.getRole() == Role.ADMIN || u.getRole() == Role.SUPER_ADMIN);
        return users;
    }

    public void setRole(User user, Role role) {
        user.setRole(role);
        try (
                EntityManager entityManager = EMF.createEntityManager()
        ){
            entityManager.getTransaction().begin();
            entityManager.merge(user);
            entityManager.getTransaction().commit();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}
