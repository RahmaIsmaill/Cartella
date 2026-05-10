package com.controller.product;

import com.model.Product;
import com.model.User;
import com.service.ProductService;
import com.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.List;

@WebServlet("/update-product")
public class UpdateProductServlet extends HttpServlet {

    private static final Logger logger = LoggerFactory.getLogger(UpdateProductServlet.class);

    private final ProductService productService = new ProductService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("loggedInUser");

        if (!"ADMIN".equals(user.getRole())) {
            logger.warn("Non-admin user {} attempted to access update-product", user.getEmail());
            response.sendError(403, "Access denied. Admin only.");
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

        Product product = productService.getProductById(productId);

        if (product == null) {
            response.sendError(404, "Product not found");
            return;
        }

        request.setAttribute("product", product);
        request.getRequestDispatcher("/views/product/update-product.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        User user = (User) request.getSession().getAttribute("loggedInUser");
        if (!"ADMIN".equals(user.getRole())) {
            response.sendError(403, "Access denied. Admin only.");
            return;
        }

        String idParam = request.getParameter("id");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String priceStr = request.getParameter("price");
        String imageUrl = request.getParameter("imageUrl");

        if (!ValidationUtil.isValidLong(idParam)) {
            request.setAttribute("error", "Invalid product ID");
            request.getRequestDispatcher("/views/product/update-product.jsp").forward(request, response);
            return;
        }

        Long productId = Long.parseLong(idParam);

        Product existingProduct = productService.getProductById(productId);
        if (existingProduct == null) {
            response.sendError(404, "Product not found");
            return;
        }

        List<String> validationErrors = ValidationUtil.validateProduct(name, priceStr);

        if (!validationErrors.isEmpty()) {
            request.setAttribute("error", validationErrors.get(0));
            request.setAttribute("product", existingProduct);
            request.getRequestDispatcher("/views/product/update-product.jsp").forward(request, response);
            return;
        }

        BigDecimal price = new BigDecimal(priceStr);

        Product product = new Product();
        product.setId(productId);
        product.setName(name.trim());
        product.setDescription(description != null ? description.trim() : "");
        product.setPrice(price);
        product.setImageUrl(imageUrl != null ? imageUrl.trim() : "");

        boolean updated = productService.updateProduct(product);

        if (updated) {
            logger.info("Product {} updated by admin: {}", productId, user.getEmail());
        } else {
            logger.warn("Failed to update product: {}", productId);
        }

        response.sendRedirect(request.getContextPath() + "/home");
    }
}
