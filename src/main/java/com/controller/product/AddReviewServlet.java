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

@WebServlet("/add-review")
public class AddReviewServlet extends HttpServlet {

    private static final Logger logger =
            LoggerFactory.getLogger(AddReviewServlet.class);

    private final ReviewService reviewService =
            new ReviewService();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession()
                .getAttribute("loggedInUser");

        String productIdParam = request.getParameter("productId");
        String ratingParam = request.getParameter("rating");
        String comment = request.getParameter("comment");

        // Use ValidationUtil for validation
        List<String> validationErrors = ValidationUtil.validateReview(ratingParam, productIdParam);

        if (!validationErrors.isEmpty()) {
            // Try to redirect to product page if product ID is valid
            if (ValidationUtil.isValidLong(productIdParam)) {
                Long productId = Long.parseLong(productIdParam);
                response.sendRedirect(request.getContextPath() + "/product?id=" + productId);
            } else {
                response.sendError(400, validationErrors.get(0));
            }
            return;
        }

        Long productId = Long.parseLong(productIdParam);
        int rating = Integer.parseInt(ratingParam);

        Review review = new Review();
        review.setUserId(user.getId());
        review.setProductId(productId);
        review.setRating(rating);
        review.setComment(comment.trim());

        reviewService.addReview(review);
        logger.info("Review added for product {} by user {}",
                productId, user.getEmail());

        response.sendRedirect(
                request.getContextPath()
                        + "/product?id=" + productId
        );
    }
}
