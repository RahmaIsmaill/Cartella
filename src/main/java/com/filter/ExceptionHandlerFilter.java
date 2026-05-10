package com.filter;

import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.io.IOException;

@WebFilter({"/*"})
public class ExceptionHandlerFilter extends HttpFilter {

    private static final Logger logger =
            LoggerFactory.getLogger(ExceptionHandlerFilter.class);

    @Override
    protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        try {
            chain.doFilter(request, response);
        } catch (Exception e) {
            logger.error("Unhandled exception: {}", e.getMessage(), e);

            String message = e.getMessage();
            if (e instanceof ServletException) {
                Throwable rootCause = ((ServletException) e).getRootCause();
                if (rootCause != null && rootCause.getMessage() != null) {
                    message = rootCause.getMessage();
                }
            }

            response.setStatus(500);
            request.setAttribute("errorCode", 500);
            request.setAttribute("errorMessage", message != null ? message : "An unexpected error occurred.");

            try {
                request.getRequestDispatcher("/views/error/error.jsp").forward(request, response);
            } catch (Exception forwardError) {
                logger.error("Error page forward failed: {}", forwardError.getMessage());
            }
        }
    }
}
