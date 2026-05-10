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

@WebServlet("/delete-review")
public class DeleteReviewServlet extends HttpServlet {

    private static final Logger logger = LoggerFactory.getLogger(DeleteReviewServlet.class);

    private final ReviewService reviewService = new ReviewService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("loggedInUser");

        String reviewIdParam = request.getParameter("id");

        // Validate review ID using ValidationUtil
        if (!ValidationUtil.isValidLong(reviewIdParam)) {
            response.sendError(400, "Invalid review ID");
            return;
        }

        Long reviewId = Long.parseLong(reviewIdParam);

        // Get review before deletion to verify ownership and get product ID for redirect
        Review review = reviewService.getReviewById(reviewId);

        if (review == null) {
            response.sendError(404, "Review not found");
            return;
        }

        // Only allow users to delete their own reviews (or admin can delete any)
        if (!review.getUserId().equals(user.getId()) && !"ADMIN".equals(user.getRole())) {
            logger.warn("User {} attempted to delete review {} belonging to user {}",
                    user.getEmail(), reviewId, review.getUserId());
            response.sendError(403, "You can only delete your own reviews");
            return;
        }

        Long productId = review.getProductId();
        boolean deleted = reviewService.deleteReview(reviewId);

        if (deleted) {
            logger.info("Review {} deleted by user {}", reviewId, user.getEmail());
        } else {
            logger.warn("Failed to delete review: {}", reviewId);
        }

        response.sendRedirect(request.getContextPath() + "/product?id=" + productId);
    }
}
