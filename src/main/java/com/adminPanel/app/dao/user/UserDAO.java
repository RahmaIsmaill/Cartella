package com.adminPanel.app.dao.user;

import com.adminPanel.app.model.user.User;
import lombok.RequiredArgsConstructor;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import javax.persistence.NoResultException;
import java.util.UUID;

@Repository
@Transactional
@RequiredArgsConstructor
public class UserDAO {

    private final SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    public User save(User user) {
        getSession().save(user);
        return user;
    }

    public User findByEmail(String email) {
        try {
            return getSession()
                    .createQuery("FROM User WHERE email = :email", User.class)
                    .setParameter("email", email)
                    .getSingleResult();
        } catch (NoResultException e) {
            return null;
        }
    }

    public User findById(UUID id) {
        return getSession().get(User.class, id);
    }

    public void delete(User user) {
        getSession().delete(user);
    }
}