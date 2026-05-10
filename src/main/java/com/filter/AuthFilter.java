package com.filter;

import com.model.User;
import com.util.JwtUtil;
import io.jsonwebtoken.Claims;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

@WebFilter({"/home", "/product/*", "/products", "/add-product",
        "/delete-product", "/add-review", "/delete-account"})
public class AuthFilter extends HttpFilter {

    private static final Logger logger = LoggerFactory.getLogger(AuthFilter.class);

    @Override
    protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {

        response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
        response.setHeader("Pragma", "no-cache");
        response.setDateHeader("Expires", 0);


        HttpSession session = request.getSession(false);
        User user = null;

        if (session != null) {
            user = (User) session.getAttribute("loggedInUser");
        }

        if (user == null) {
            String token = extractJwtFromCookies(request);
            if (token != null) {
                Claims claims = JwtUtil.validateToken(token);
                if (claims != null) {
                    user = new User();
                    user.setId(Long.parseLong(claims.getSubject()));
                    user.setEmail((String) claims.get("email"));
                    user.setRole((String) claims.get("role"));

                    HttpSession newSession = request.getSession(true);
                    newSession.setAttribute("loggedInUser", user);
                    logger.info("JWT auth successful for: {}",
                            user.getEmail());
                }
            }
        }

        if (user == null) {
            logger.warn("Unauthenticated access attempt to: {}",
                    request.getRequestURI());
            response.sendRedirect(request.getContextPath() + "/views/auth/login.jsp");
            return;
        }
        chain.doFilter(request, response);
    }

    private String extractJwtFromCookies(HttpServletRequest request) {
        Cookie[] cookies = request.getCookies();

        if (cookies != null) {
            for (Cookie cookie : cookies) {
                if ("jwt_token".equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }

        return null;
    }
}
