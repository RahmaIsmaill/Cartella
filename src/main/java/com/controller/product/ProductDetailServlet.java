package com.controller.product;

import com.model.Product;
import com.model.Review;
import com.service.ProductService;
import com.service.ReviewService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.util.List;

@WebServlet("/product")
public class ProductDetailServlet extends HttpServlet {

    private static final Logger logger =
            LoggerFactory.getLogger(ProductDetailServlet.class);

    private final ProductService productService =
            new ProductService();

    private final ReviewService reviewService =
            new ReviewService();

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendRedirect(
                    request.getContextPath() + "/home");
            return;
        }

        Long productId;
        try {
            productId = Long.parseLong(idParam);
        } catch (NumberFormatException e) {
            response.sendError(400, "Invalid product ID");
            return;
        }

        Product product = productService.getProductById(productId);

        if (product == null) {
            response.sendError(404, "Product not found");
            return;
        }

        List<Review> reviews =
                reviewService.getReviewsByProduct(productId);

        request.setAttribute("product", product);
        request.setAttribute("reviews", reviews);

        request.getRequestDispatcher(
                "/views/product/product-detail.jsp"
        ).forward(request, response);
    }
}
