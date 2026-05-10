package com.adminPanel.app.service.review;

import com.adminPanel.app.dao.review.ReviewDAO;
import com.adminPanel.app.model.review.Review;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
@RequiredArgsConstructor
public class ReviewService {

    private final ReviewDAO reviewDAO;

    public void addReview(Review review) {reviewDAO.save(review);}

    public List<Review> getAllReviews() {
        return reviewDAO.findAll();
    }

    public List<Review> getReviewsByProduct(int productId) {
        return reviewDAO.findByProductId(productId);
    }

    public void deleteReview(int id) {
        reviewDAO.delete(id);
    }
}