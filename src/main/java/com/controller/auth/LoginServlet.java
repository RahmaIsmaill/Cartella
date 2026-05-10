package com.controller.auth;

import com.model.User;
import com.service.AuthService;
import com.util.JwtUtil;
import com.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private final AuthService authService = new AuthService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

        String email = request.getParameter("email");
        String password = request.getParameter("password");

        java.util.List<String> validationErrors = ValidationUtil.validateLogin(email, password);
        if (!validationErrors.isEmpty()) {
            request.setAttribute("errors", validationErrors);
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
            return;
        }

        User user = authService.login(email, password);

        if (user != null) {
            HttpSession session = request.getSession();
            session.setAttribute("loggedInUser", user);
            String token = JwtUtil.generateToken(user.getId(), user.getEmail(), user.getRole());

            Cookie jwtCookie = new Cookie("jwt_token", token);

            jwtCookie.setHttpOnly(true);
            jwtCookie.setPath("/");
            jwtCookie.setMaxAge(60 * 60 * 24);
            response.addCookie(jwtCookie);
            response.sendRedirect(request.getContextPath() + "/home");
        } else {
            request.setAttribute("error", "Invalid Email or Password");
            request.getRequestDispatcher("/views/auth/login.jsp").forward(request, response);
        }

    }

}