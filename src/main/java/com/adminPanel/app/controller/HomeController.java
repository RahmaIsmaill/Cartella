package com.adminPanel.app.controller;

import com.adminPanel.app.model.product.Product;
import com.adminPanel.app.model.review.Review;
import com.adminPanel.app.service.product.ProductService;
import com.adminPanel.app.service.review.ReviewService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/")
public class HomeController extends HttpServlet {

    @Autowired
    private ProductService productService;

    @Autowired
    private ReviewService reviewService;

    @Override
    public void init() throws ServletException {
        super.init();
        SpringBeanAutowiringSupport.processInjectionBasedOnCurrentContext(this);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        List<Product> products = productService.getAllProducts();
        List<Review> reviews = reviewService.getAllReviews();

        request.setAttribute("products", products);
        request.setAttribute("reviews", reviews);

        request.getRequestDispatcher("/WEB-INF/view/home.jsp").forward(request, response);
    }
}
