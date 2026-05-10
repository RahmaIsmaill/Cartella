package com.adminPanel.app.controller.auth;

import com.adminPanel.app.model.user.User;
import com.adminPanel.app.service.user.UserService;
import com.adminPanel.app.util.JWTUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.support.SpringBeanAutowiringSupport;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.HashMap;
import java.util.Map;
import java.util.stream.Collectors;

import com.fasterxml.jackson.databind.ObjectMapper;

@WebServlet("/api/auth/*")
public class AuthController extends HttpServlet {

    @Autowired
    private UserService userService;

    @Autowired
    private JWTUtil jwtUtil;

    private final ObjectMapper objectMapper = new ObjectMapper();

    @Override
    public void init() throws ServletException {
        super.init();
        SpringBeanAutowiringSupport.processInjectionBasedOnServletContext(this, getServletContext());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        if ("/validate".equals(pathInfo)) {
            handleValidateToken(request, response);
        } else {
            sendErrorResponse(response, HttpServletResponse.SC_NOT_FOUND, "Endpoint not found");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String pathInfo = request.getPathInfo();

        if ("/login".equals(pathInfo)) {
            handleLogin(request, response);
        } else if ("/register".equals(pathInfo)) {
            handleRegister(request, response);
        } else {
            sendErrorResponse(response, HttpServletResponse.SC_NOT_FOUND, "Endpoint not found");
        }
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            String requestBody = request.getReader().lines().collect(Collectors.joining(System.lineSeparator()));
            LoginRequest loginRequest = objectMapper.readValue(requestBody, LoginRequest.class);

            User user = userService.login(loginRequest.getEmail(), loginRequest.getPassword());

            Map<String, Object> responseData = new HashMap<>();

            if (user != null) {
                // Generate JWT token
                String token = jwtUtil.generateToken(user.getEmail(), user.getRole().toString());

                responseData.put("success", true);
                responseData.put("message", "Login successful");
                responseData.put("token", token);
                responseData.put("user", Map.of(
                        "id", user.getId(),
                        "username", user.getUsername(),
                        "email", user.getEmail(),
                        "role", user.getRole()
                ));

                sendJsonResponse(response, HttpServletResponse.SC_OK, responseData);
            } else {
                responseData.put("success", false);
                responseData.put("message", "Invalid email or password");
                sendJsonResponse(response, HttpServletResponse.SC_UNAUTHORIZED, responseData);
            }

        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("message", "Login failed: " + e.getMessage());
            sendJsonResponse(response, HttpServletResponse.SC_BAD_REQUEST, errorResponse);
        }
    }

    private void handleRegister(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            String requestBody = request.getReader().lines().collect(Collectors.joining(System.lineSeparator()));
            RegisterRequest registerRequest = objectMapper.readValue(requestBody, RegisterRequest.class);

            User user = new User();
            user.setUsername(registerRequest.getUsername());
            user.setEmail(registerRequest.getEmail());
            user.setPassword(registerRequest.getPassword());

            User registeredUser = userService.registerUser(user);

            Map<String, Object> responseData = new HashMap<>();

            if (registeredUser != null) {
                // Generate JWT token for new user
                String token = jwtUtil.generateToken(registeredUser.getEmail(), registeredUser.getRole().toString());

                responseData.put("success", true);
                responseData.put("message", "Registration successful");
                responseData.put("token", token);
                responseData.put("user", Map.of(
                        "id", registeredUser.getId(),
                        "username", registeredUser.getUsername(),
                        "email", registeredUser.getEmail(),
                        "role", registeredUser.getRole()
                ));

                sendJsonResponse(response, HttpServletResponse.SC_CREATED, responseData);
            } else {
                responseData.put("success", false);
                responseData.put("message", "Registration failed");
                sendJsonResponse(response, HttpServletResponse.SC_BAD_REQUEST, responseData);
            }

        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("message", "Registration failed: " + e.getMessage());
            sendJsonResponse(response, HttpServletResponse.SC_BAD_REQUEST, errorResponse);
        }
    }

    private void handleValidateToken(HttpServletRequest request, HttpServletResponse response)
            throws IOException {

        try {
            String authHeader = request.getHeader("Authorization");
            String token = jwtUtil.getTokenFromHeader(authHeader);

            Map<String, Object> responseData = new HashMap<>();

            if (token != null && jwtUtil.validateToken(token)) {
                String email = jwtUtil.extractUsername(token);
                String role = jwtUtil.extractRole(token);

                responseData.put("success", true);
                responseData.put("message", "Token is valid");
                responseData.put("email", email);
                responseData.put("role", role);

                sendJsonResponse(response, HttpServletResponse.SC_OK, responseData);
            } else {
                responseData.put("success", false);
                responseData.put("message", "Invalid or expired token");
                sendJsonResponse(response, HttpServletResponse.SC_UNAUTHORIZED, responseData);
            }

        } catch (Exception e) {
            Map<String, Object> errorResponse = new HashMap<>();
            errorResponse.put("success", false);
            errorResponse.put("message", "Token validation failed: " + e.getMessage());
            sendJsonResponse(response, HttpServletResponse.SC_UNAUTHORIZED, errorResponse);
        }
    }

    private void sendJsonResponse(HttpServletResponse response, int status, Map<String, Object> data)
            throws IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setStatus(status);

        PrintWriter out = response.getWriter();
        out.print(objectMapper.writeValueAsString(data));
        out.flush();
    }

    private void sendErrorResponse(HttpServletResponse response, int status, String message)
            throws IOException {

        Map<String, Object> errorResponse = new HashMap<>();
        errorResponse.put("success", false);
        errorResponse.put("message", message);

        sendJsonResponse(response, status, errorResponse);
    }

    // DTO Classes
    public static class LoginRequest {
        private String email;
        private String password;

        // Getters and Setters
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }
    }

    public static class RegisterRequest {
        private String username;
        private String email;
        private String password;

        // Getters and Setters
        public String getUsername() { return username; }
        public void setUsername(String username) { this.username = username; }
        public String getEmail() { return email; }
        public void setEmail(String email) { this.email = email; }
        public String getPassword() { return password; }
        public void setPassword(String password) { this.password = password; }
    }
}
