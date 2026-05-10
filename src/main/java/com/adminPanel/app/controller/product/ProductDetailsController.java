package com.adminPanel.app.controller.product;

import com.adminPanel.app.model.product.Product;
import com.adminPanel.app.model.review.Review;
import com.adminPanel.app.model.user.User;
import com.adminPanel.app.service.product.ProductService;
import com.adminPanel.app.service.review.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.List;

@WebServlet("/products/view/*")
public class ProductDetailsController extends HttpServlet {


    @Autowired
    private ProductService productService;

    @Autowired
    private ReviewService reviewService;

    @Override
    public void init() throws ServletException {
        super.init();

        SpringBeanAutowiringSupport
                .processInjectionBasedOnCurrentContext(this);
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int productId = extractProductId(request);

            Product product =
                    productService.getProductById(productId);

            if (product == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Product not found"
                );

                return;
            }

            List<Review> reviews =
                    reviewService.getReviewsByProduct(productId);

            request.setAttribute("product", product);
            request.setAttribute("reviews", reviews);

            request.getRequestDispatcher(
                    "/WEB-INF/view/productDetails.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product id"
            );
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int productId = extractProductId(request);

            String comment =
                    request.getParameter("comment");

            String ratingStr =
                    request.getParameter("rating");

            if (comment == null || comment.trim().isEmpty()) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Comment is required"
                );

                return;
            }

            int rating = Integer.parseInt(ratingStr);

            if (rating < 1 || rating > 5) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Rating must be between 1 and 5"
                );

                return;
            }

            Product product =
                    productService.getProductById(productId);

            if (product == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Product not found"
                );

                return;
            }

            User user =
                    (User) request.getSession()
                            .getAttribute("loggedUser");

            if (user == null) {

                response.sendRedirect(
                        request.getContextPath() + "/login"
                );

                return;
            }

            Review review = new Review();

            review.setComment(comment.trim());
            review.setRating(rating);
            review.setUser(user);
            review.setProduct(product);

            reviewService.addReview(review);

            response.sendRedirect(
                    request.getContextPath()
                            + "/products/view/"
                            + productId
            );

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid input"
            );
        }
    }

    private int extractProductId(HttpServletRequest request) {

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {

            throw new NumberFormatException();
        }

        return Integer.parseInt(
                pathInfo.substring(1)
        );
    }
}