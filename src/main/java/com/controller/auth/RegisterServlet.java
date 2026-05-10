package com.controller.auth;

import com.model.User;
import com.service.AuthService;
import com.util.ValidationUtil;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private final AuthService authService =
            new AuthService();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        java.util.List<String> validationErrors = ValidationUtil.validateRegistration(username, email, password);
        if (!validationErrors.isEmpty()) {
            request.setAttribute("errors", validationErrors);
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
            return;
        }

        User user = new User();
        user.setUsername(username);
        user.setEmail(email);
        user.setPassword(password);

        boolean registered = authService.register(user);

        if (registered) {
            response.sendRedirect(request.getContextPath() + "/views/auth/login.jsp");
        } else {
            request.setAttribute("error", "Username or Email already exists");
            request.getRequestDispatcher("/views/auth/register.jsp").forward(request, response);
        }
    }
}