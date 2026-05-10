package com.service;

import com.dao.ReviewDAO;
import com.model.Review;
import com.util.CacheConstants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

public class ReviewService {

    private static final Logger logger = LoggerFactory.getLogger(ReviewService.class);
    private final ReviewDAO reviewDAO = new ReviewDAO();
    private final CacheService cacheService = new CacheService();

    public List<Review> getReviewsByProduct(Long productId) {
        logger.info("Fetching reviews for product id: {}", productId);

        String cacheKey = CacheConstants.REVIEWS_CACHE_PREFIX + productId;
        List<Review> cached = cacheService.getList(cacheKey, Review.class);

        if (cached != null) {
            return cached;
        }

        List<Review> reviews = reviewDAO.findByProductId(productId);
        cacheService.set(cacheKey, reviews);
        return reviews;
    }

    public Review getReviewById(Long id) {
        logger.info("Fetching review with id: {}", id);

        String cacheKey = CacheConstants.REVIEW_CACHE_PREFIX + id;
        Review cached = cacheService.get(cacheKey, Review.class);

        if (cached != null) {
            return cached;
        }

        Review review = reviewDAO.findById(id);
        if (review != null) {
            cacheService.set(cacheKey, review);
        }
        return review;
    }

    public boolean addReview(Review review) {
        logger.info("Adding review for product id: {} by user id: {}",
                review.getProductId(), review.getUserId());
        if (review.getRating() < 1 || review.getRating() > 5) {
            logger.warn("Invalid rating: {}", review.getRating());
            return false;
        }

        reviewDAO.save(review);
        cacheService.delete(CacheConstants.REVIEWS_CACHE_PREFIX + review.getProductId());
        return true;
    }

    public boolean updateReview(Review review) {
        logger.info("Updating review with id: {}", review.getId());
        if (review.getRating() < 1 || review.getRating() > 5) {
            logger.warn("Invalid rating: {}", review.getRating());
            return false;
        }

        boolean updated = reviewDAO.update(review);
        if (updated) {
            cacheService.delete(CacheConstants.REVIEW_CACHE_PREFIX + review.getId());
            cacheService.delete(CacheConstants.REVIEWS_CACHE_PREFIX + review.getProductId());
        }
        return updated;
    }

    public boolean deleteReview(Long id) {
        logger.info("Deleting review with id: {}", id);

        Review review = reviewDAO.findById(id);
        boolean deleted = reviewDAO.deleteById(id);

        if (deleted) {
            cacheService.delete(CacheConstants.REVIEW_CACHE_PREFIX + id);
            if (review != null) {
                cacheService.delete(CacheConstants.REVIEWS_CACHE_PREFIX + review.getProductId());
            }
        }
        return deleted;
    }
}
