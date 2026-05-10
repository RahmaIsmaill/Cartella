package com.adminPanel.app.dao.review;

import com.adminPanel.app.model.review.Review;
import lombok.RequiredArgsConstructor;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
@RequiredArgsConstructor
public class ReviewDAO {

    private final SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

        public void save(Review review) {
        getSession().save(review);
    }

        public List<Review> findAll() {
        return getSession()
                .createQuery("FROM Review ORDER BY createdAt DESC", Review.class)
                .getResultList();
    }

        public List<Review> findByProductId(int productId) {
        return getSession()
                .createQuery("FROM Review WHERE product.id = :pid ORDER BY createdAt DESC", Review.class)
                .setParameter("pid", productId)
                .getResultList();
    }

        public Review findById(int id) {
        return getSession().get(Review.class, id);
    }

        public void delete(int id) {
        Review review = findById(id);
        if (review != null) {
            getSession().delete(review);
        }
    }
}