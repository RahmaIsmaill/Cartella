package com.adminPanel.app.controller.product;

import com.adminPanel.app.service.product.ProductService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/product-list")
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

        request.setAttribute(
                "products",
                productService.getAllProducts()
        );

        request.getRequestDispatcher(
                "/WEB-INF/view/allProducts.jsp"
        ).forward(request, response);
    }
}