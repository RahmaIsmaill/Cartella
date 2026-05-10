package com.adminPanel.app.filter;

import com.adminPanel.app.service.rate.RateLimitService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import javax.servlet.*;
import javax.servlet.http.*;
import java.io.IOException;
import java.util.concurrent.TimeUnit;

@Component
public class RateLimitFilter implements Filter {

    @Autowired
    private RateLimitService rateLimitService;

    @Override
    public void doFilter(ServletRequest request,
                         ServletResponse response,
                         FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest httpRequest =
                (HttpServletRequest) request;

        HttpServletResponse httpResponse =
                (HttpServletResponse) response;

        String clientIp = getClientIp(httpRequest);

        String endpoint =
                httpRequest.getRequestURI();

        boolean allowed =
                rateLimitService.isAllowed(
                        clientIp,
                        endpoint,
                        100,
                        1,
                        TimeUnit.MINUTES
                );

        if (!allowed) {

            httpResponse.setStatus(
                    HttpServletResponse.SC_BAD_REQUEST
            );

            httpResponse.setContentType("text/plain");

            httpResponse.getWriter().write(
                    "Rate limit exceeded. Try again later."
            );

            return;
        }

        chain.doFilter(request, response);
    }

    private String getClientIp(HttpServletRequest request) {

        String xForwardedFor =
                request.getHeader("X-Forwarded-For");

        if (xForwardedFor != null
                && !xForwardedFor.isEmpty()
                && !"unknown".equalsIgnoreCase(xForwardedFor)) {

            return xForwardedFor
                    .split(",")[0]
                    .trim();
        }

        String xRealIp =
                request.getHeader("X-Real-IP");

        if (xRealIp != null
                && !xRealIp.isEmpty()
                && !"unknown".equalsIgnoreCase(xRealIp)) {

            return xRealIp;
        }

        return request.getRemoteAddr();
    }
}