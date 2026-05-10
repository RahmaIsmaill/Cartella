package com.filter;

import com.config.RedisConfig;
import jakarta.servlet.FilterChain;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.HttpFilter;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import redis.clients.jedis.Jedis;

import java.io.IOException;

@WebFilter({"/*"})
public class RateLimitFilter extends HttpFilter {

    private static final Logger logger =
            LoggerFactory.getLogger(RateLimitFilter.class);

    private static final int MAX_REQUESTS = 30;
    private static final int WINDOW_SECONDS = 60;

    @Override
    protected void doFilter(HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {

        String clientIp = getClientIp(request);
        String key = "rate_limit:" + clientIp;

        if (!RedisConfig.isAvailable()) {
            chain.doFilter(request, response);
            return;
        }
        try (Jedis jedis = RedisConfig.getResource()) {
            long currentCount = jedis.incr(key);
            if (currentCount == 1) {
                jedis.expire(key, WINDOW_SECONDS);
            }
            long ttl = jedis.ttl(key);

            response.setHeader("X-RateLimit-Limit", String.valueOf(MAX_REQUESTS));
            response.setHeader("X-RateLimit-Remaining", String.valueOf(Math.max(0, MAX_REQUESTS - currentCount)));
            response.setHeader("X-RateLimit-Reset", String.valueOf(System.currentTimeMillis() / 1000 + ttl));

            if (currentCount > MAX_REQUESTS) {
                logger.warn("Rate limit exceeded for IP: {}", clientIp);

                response.setStatus(429);
                response.setHeader("Retry-After", String.valueOf(ttl));
                response.setContentType("text/html");
                response.getWriter().write(
                        "<h2>429 - Too Many Requests</h2>"
                        + "<p>Please try again later.</p>");
                return;
            }
        } catch (Exception e) {
            logger.error("Rate limit check failed: {}", e.getMessage());
        }

        chain.doFilter(request, response);
    }

    private String getClientIp(HttpServletRequest request) {
        String ip = request.getHeader("X-Forwarded-For");
        if (ip == null || ip.isEmpty()) {
            ip = request.getRemoteAddr();
        } else {
            ip = ip.split(",")[0].trim();
        }

        return ip;
    }
}
