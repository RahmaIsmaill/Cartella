package com.controller.product;

import com.model.User;
import com.service.ProductService;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

@WebServlet("/delete-product")
public class DeleteProductServlet extends HttpServlet {

    private static final Logger logger =
            LoggerFactory.getLogger(DeleteProductServlet.class);

    private final ProductService productService =
            new ProductService();

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        User user = (User) request.getSession()
                .getAttribute("loggedInUser");

        if (!"ADMIN".equals(user.getRole())) {
            logger.warn("Non-admin user {} attempted to delete product",
                    user.getEmail());
            response.sendError(403,
                    "Access denied. Admin only.");
            return;
        }

        String idParam = request.getParameter("id");

        if (idParam == null || idParam.trim().isEmpty()) {
            response.sendError(400, "Product ID is required");
            return;
        }

        Long productId;
        try {
            productId = Long.parseLong(idParam);
        } catch (NumberFormatException e) {
            response.sendError(400, "Invalid product ID");
            return;
        }

        boolean deleted =
                productService.deleteProduct(productId);

        if (deleted) {
            logger.info("Product {} deleted by admin: {}",
                    productId, user.getEmail());
        } else {
            logger.warn("Failed to delete product: {}", productId);
        }

        response.sendRedirect(
                request.getContextPath() + "/home"
        );
    }
}
