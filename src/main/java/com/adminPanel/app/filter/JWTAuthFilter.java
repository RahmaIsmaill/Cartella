package com.adminPanel.app.filter;

import com.adminPanel.app.enums.Roles;
import com.adminPanel.app.util.JWTUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@Component
@WebFilter(urlPatterns = {"/api/*"})
public class JWTAuthFilter implements Filter {

    @Autowired
    private JWTUtil jwtUtil;

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest = (HttpServletRequest) request;
        HttpServletResponse httpResponse = (HttpServletResponse) response;

        // Allow access to auth endpoints without JWT
        String path = httpRequest.getRequestURI();
        if (path.startsWith("/api/auth/")) {
            chain.doFilter(request, response);
            return;
        }

        // Check for JWT token in Authorization header
        String authHeader = httpRequest.getHeader("Authorization");
        String token = jwtUtil.getTokenFromHeader(authHeader);

        if (token == null) {
            httpResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            httpResponse.setContentType("application/json");
            httpResponse.getWriter().write("{\"success\": false, \"message\": \"Authorization token required\"}");
            return;
        }

        // Validate JWT token
        if (!jwtUtil.validateToken(token)) {
            httpResponse.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            httpResponse.setContentType("application/json");
            httpResponse.getWriter().write("{\"success\": false, \"message\": \"Invalid or expired token\"}");
            return;
        }

        // Check admin-only endpoints
        if (path.startsWith("/api/admin/")) {
            String role = jwtUtil.extractRole(token);
            if (!Roles.ADMIN.toString().equals(role)) {
                httpResponse.setStatus(HttpServletResponse.SC_FORBIDDEN);
                httpResponse.setContentType("application/json");
                httpResponse.getWriter().write("{\"success\": false, \"message\": \"Access denied. Admin privileges required.\"}");
                return;
            }
        }

        // Add user info to request attributes
        String email = jwtUtil.extractUsername(token);
        String role = jwtUtil.extractRole(token);
        httpRequest.setAttribute("userEmail", email);
        httpRequest.setAttribute("userRole", role);

        chain.doFilter(request, response);
    }
}
