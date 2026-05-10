package com.adminPanel.app.controller.admin;

import com.adminPanel.app.model.product.Product;
import com.adminPanel.app.model.product.ProductDetails;
import com.adminPanel.app.service.product.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.Date;

@WebServlet("/admin/products/*")
public class AdminProductManagementController extends HttpServlet {
    @Autowired
    private ProductService productService;

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

        String pathInfo = request.getPathInfo();

        if (pathInfo == null || pathInfo.equals("/")) {

            showAdminProducts(request, response);

        } else if (pathInfo.equals("/add")) {

            showAddForm(request, response);

        } else if (pathInfo.startsWith("/update/")) {

            showUpdateForm(request, response);

        } else {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Page not found"
            );
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        if (pathInfo.equals("/add")) {

            addProduct(request, response);

        } else if (pathInfo.equals("/update")) {

            updateProduct(request, response);

        } else if (pathInfo.equals("/delete")) {

            deleteProduct(request, response);

        } else {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Page not found"
            );
        }
    }

    private void showAdminProducts(HttpServletRequest request,
                                   HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute(
                "products",
                productService.getAllProducts()
        );

        request.getRequestDispatcher(
                "/WEB-INF/view/adminProducts.jsp"
        ).forward(request, response);
    }

    private void showAddForm(HttpServletRequest request,
                             HttpServletResponse response)
            throws ServletException, IOException {

        request.getRequestDispatcher(
                "/WEB-INF/view/addProductForm.jsp"
        ).forward(request, response);
    }

    private void addProduct(HttpServletRequest request,
                            HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String name = request.getParameter("name");
            String detailsName =
                    request.getParameter("detailsName");

            String priceStr =
                    request.getParameter("price");

            String availableStr =
                    request.getParameter("available");

            validateProductInput(name, priceStr);

            Product product = new Product();
            product.setName(name.trim());

            ProductDetails details = new ProductDetails();

            details.setProduct(product);

            details.setName(
                    detailsName != null &&
                            !detailsName.trim().isEmpty()
                            ? detailsName.trim()
                            : name.trim()
            );

            details.setPrice(
                    Double.parseDouble(priceStr)
            );

            details.setAvailable(
                    Boolean.parseBoolean(
                            availableStr != null
                                    ? availableStr
                                    : "true"
                    )
            );

            details.setExpiration_date(
                    new Date(
                            System.currentTimeMillis()
                                    + 365L * 24 * 60 * 60 * 1000
                    )
            );

            product.setProductDetails(details);

            productService.addProduct(product);

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/products"
            );

        } catch (IllegalArgumentException e) {

            request.setAttribute("error", e.getMessage());

            request.getRequestDispatcher(
                    "/WEB-INF/view/addProductForm.jsp"
            ).forward(request, response);
        }
    }

    private void showUpdateForm(HttpServletRequest request,
                                HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String pathInfo = request.getPathInfo();
            String idStr =
                    pathInfo.substring("/update/".length());

            int id = Integer.parseInt(idStr);

            Product product =
                    productService.getProductById(id);

            if (product == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Product not found"
                );

                return;
            }

            request.setAttribute("product", product);

            request.getRequestDispatcher(
                    "/WEB-INF/view/updateProduct.jsp"
            ).forward(request, response);

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product id"
            );
        }
    }

    private void updateProduct(HttpServletRequest request,
                               HttpServletResponse response)
            throws ServletException, IOException {

        try {

            int id = Integer.parseInt(
                    request.getParameter("id")
            );

            String name =
                    request.getParameter("name");

            String priceStr =
                    request.getParameter("price");

            String availableStr =
                    request.getParameter("available");

            validateProductInput(name, priceStr);

            Product product =
                    productService.getProductById(id);

            if (product == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Product not found"
                );

                return;
            }

            product.setName(name.trim());

            ProductDetails details =
                    product.getProductDetails();

            details.setPrice(
                    Double.parseDouble(priceStr)
            );

            details.setAvailable(
                    Boolean.parseBoolean(availableStr)
            );

            productService.updateProduct(product);

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/products"
            );

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product id"
            );

        } catch (IllegalArgumentException e) {

            request.setAttribute("error", e.getMessage());

            request.getRequestDispatcher(
                    "/WEB-INF/view/updateProduct.jsp"
            ).forward(request, response);
        }
    }

    private void deleteProduct(HttpServletRequest request,
                               HttpServletResponse response)
            throws IOException {

        try {

            int id = Integer.parseInt(
                    request.getParameter("id")
            );

            productService.deleteProduct(id);

            response.sendRedirect(
                    request.getContextPath()
                            + "/admin/products"
            );

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid product id"
            );
        }
    }

    private void validateProductInput(String name,
                                      String priceStr) {

        if (name == null || name.trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "Product name is required"
            );
        }

        if (priceStr == null || priceStr.trim().isEmpty()) {

            throw new IllegalArgumentException(
                    "Price is required"
            );
        }

        try {

            double price =
                    Double.parseDouble(priceStr);

            if (price < 0) {

                throw new IllegalArgumentException(
                        "Price cannot be negative"
                );
            }

        } catch (NumberFormatException e) {

            throw new IllegalArgumentException(
                    "Invalid price format"
            );
        }
    }
}