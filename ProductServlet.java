package com.adminPanel.app.controller.product;

import com.adminPanel.app.model.product.Product;
import com.adminPanel.app.service.product.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/products/*")
public class ProductController extends HttpServlet {

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

            showAllProducts(request, response);

        } else if (pathInfo.startsWith("/view/")) {

            showProductDetails(request, response);

        } else {

            response.sendError(
                    HttpServletResponse.SC_NOT_FOUND,
                    "Page not found"
            );
        }
    }

    private void showAllProducts(HttpServletRequest request,
                                 HttpServletResponse response)
            throws ServletException, IOException {

        request.setAttribute(
                "products",
                productService.getAllProducts()
        );

        request.getRequestDispatcher(
                "/WEB-INF/view/allProducts.jsp"
        ).forward(request, response);
    }

    private void showProductDetails(HttpServletRequest request,
                                    HttpServletResponse response)
            throws ServletException, IOException {

        try {

            String pathInfo = request.getPathInfo();
            String idStr = pathInfo.substring("/view/".length());

            int productId = Integer.parseInt(idStr);

            Product product =
                    productService.getProductById(productId);

            if (product == null) {

                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Product not found"
                );

                return;
            }

            request.setAttribute("product", product);

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
}