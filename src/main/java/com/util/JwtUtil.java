package com.util;

import io.jsonwebtoken.Claims;
import io.jsonwebtoken.Jwts;
import io.jsonwebtoken.SignatureAlgorithm;
import io.jsonwebtoken.security.Keys;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.crypto.SecretKey;
import java.util.Date;

public class JwtUtil {

    private static final Logger logger =
            LoggerFactory.getLogger(JwtUtil.class);

    private static final SecretKey SECRET_KEY = Keys.secretKeyFor(SignatureAlgorithm.HS256);

    private static final long EXPIRATION_TIME = 1000 * 60 * 60 * 24;

    public static String generateToken(Long userId, String email, String role) {
        logger.info("Generating JWT token for user: {}", email);

        return Jwts.builder()
                .setSubject(String.valueOf(userId))
                .claim("email", email)
                .claim("role", role)
                .setIssuedAt(new Date())
                .setExpiration(new Date(System.currentTimeMillis() + EXPIRATION_TIME))
                .signWith(SECRET_KEY)
                .compact();
    }

    public static Claims validateToken(String token) {
        try {
            return Jwts.parserBuilder()
                    .setSigningKey(SECRET_KEY)
                    .build()
                    .parseClaimsJws(token)
                    .getBody();
        } catch (Exception e) {
            logger.warn("Invalid JWT token: {}", e.getMessage());
            return null;
        }
    }

    public static Long extractUserId(String token) {
        Claims claims = validateToken(token);
        if (claims != null) {
            return Long.parseLong(claims.getSubject());
        }
        return null;
    }

    public static String extractEmail(String token) {
        Claims claims = validateToken(token);
        if (claims != null) {
            return (String) claims.get("email");
        }
        return null;
    }

    public static String extractRole(String token) {
        Claims claims = validateToken(token);
        if (claims != null) {
            return (String) claims.get("role");
        }
        return null;
    }
}
