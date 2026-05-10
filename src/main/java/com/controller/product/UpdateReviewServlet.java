package com.controller.product;

import com.model.Review;
import com.model.User;
import com.service.ReviewService;
import com.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.List;

@WebServlet("/update-review")
public class UpdateReviewServlet extends HttpServlet {

    private static final Logger logger = LoggerFactory.getLogger(UpdateReviewServlet.class);

    private final ReviewService reviewService = new ReviewService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("loggedInUser");

        String reviewIdParam = request.getParameter("id");
        String productIdParam = request.getParameter("productId");

        // Validate review ID using ValidationUtil
        if (!ValidationUtil.isValidLong(reviewIdParam)) {
            response.sendError(400, "Invalid review ID");
            return;
        }

        Long reviewId = Long.parseLong(reviewIdParam);
        Review review = reviewService.getReviewById(reviewId);

        if (review == null) {
            response.sendError(404, "Review not found");
            return;
        }

        // Only allow users to update their own reviews
        if (!review.getUserId().equals(user.getId())) {
            logger.warn("User {} attempted to update review {} belonging to user {}",
                    user.getEmail(), reviewId, review.getUserId());
            response.sendError(403, "You can only update your own reviews");
            return;
        }

        request.setAttribute("review", review);
        request.setAttribute("productId", productIdParam);
        request.getRequestDispatcher("/views/product/update-review.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("loggedInUser");

        String reviewIdParam = request.getParameter("reviewId");
        String productIdParam = request.getParameter("productId");
        String ratingParam = request.getParameter("rating");
        String comment = request.getParameter("comment");

        // Use ValidationUtil for review validation
        List<String> validationErrors = ValidationUtil.validateReview(ratingParam, productIdParam);

        if (!validationErrors.isEmpty()) {
            // If validation fails, redirect back to product page with error
            Long productId = ValidationUtil.isValidLong(productIdParam) ? Long.parseLong(productIdParam) : null;
            if (productId != null) {
                response.sendRedirect(request.getContextPath() + "/product?id=" + productId + "&error=" + validationErrors.get(0));
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
            return;
        }

        Long reviewId = Long.parseLong(reviewIdParam);
        Long productId = Long.parseLong(productIdParam);
        int rating = Integer.parseInt(ratingParam);

        // Get existing review and verify ownership
        Review existingReview = reviewService.getReviewById(reviewId);
        if (existingReview == null) {
            response.sendError(404, "Review not found");
            return;
        }

        if (!existingReview.getUserId().equals(user.getId())) {
            logger.warn("User {} attempted to update review {} belonging to user {}",
                    user.getEmail(), reviewId, existingReview.getUserId());
            response.sendError(403, "You can only update your own reviews");
            return;
        }

        Review review = new Review();
        review.setId(reviewId);
        review.setUserId(user.getId());
        review.setProductId(productId);
        review.setRating(rating);
        review.setComment(comment != null ? comment.trim() : "");

        boolean updated = reviewService.updateReview(review);

        if (updated) {
            logger.info("Review {} updated by user {}", reviewId, user.getEmail());
        } else {
            logger.warn("Failed to update review: {}", reviewId);
        }

        response.sendRedirect(request.getContextPath() + "/product?id=" + productId);
    }
}
