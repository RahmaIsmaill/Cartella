package com.adminPanel.app.service.review;

import com.adminPanel.app.dao.review.ReviewDAO;
import com.adminPanel.app.model.review.Review;
import com.adminPanel.app.service.cache.CacheService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.concurrent.TimeUnit;

@Service
@Transactional
@RequiredArgsConstructor
public class ReviewService {

    private final ReviewDAO reviewDAO;
    private final CacheService cacheService;

    public void addReview(Review review) {
        reviewDAO.save(review);
        cacheService.delete("reviews:all");
        cacheService.delete("reviews:product:" + review.getProductId());
    }

    public List<Review> getAllReviews() {
        String cacheKey = "reviews:all";
        
        List<Review> cachedReviews = cacheService.get(cacheKey, List.class);
        if (cachedReviews != null) {
            return cachedReviews;
        }
        
        List<Review> reviews = reviewDAO.findAll();
        cacheService.set(cacheKey, reviews, 15, TimeUnit.MINUTES);
        return reviews;
    }

    public List<Review> getReviewsByProduct(int productId) {
        String cacheKey = "reviews:product:" + productId;
        
        List<Review> cachedReviews = cacheService.get(cacheKey, List.class);
        if (cachedReviews != null) {
            return cachedReviews;
        }
        
        List<Review> reviews = reviewDAO.findByProductId(productId);
        cacheService.set(cacheKey, reviews, 20, TimeUnit.MINUTES);
        return reviews;
    }

    public void deleteReview(int id) {
        Review review = reviewDAO.findById(id);
        if (review != null) {
            reviewDAO.delete(id);
            cacheService.delete("reviews:all");
            cacheService.delete("reviews:product:" + review.getProductId());
        }
    }
}