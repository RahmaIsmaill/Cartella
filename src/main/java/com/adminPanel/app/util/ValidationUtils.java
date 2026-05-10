package com.adminPanel.app.util;

import com.adminPanel.app.exception.CustomExceptions;
import lombok.extern.slf4j.Slf4j;

import java.util.regex.Pattern;

@Slf4j
public class ValidationUtils {

    private static final Pattern EMAIL_PATTERN = Pattern.compile(
            "^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$"
    );

    private static final Pattern PASSWORD_PATTERN = Pattern.compile(
            "^(?=.*[0-9])(?=.*[a-z])(?=.*[A-Z])(?=.*[@#$%^&+=])(?=\\S+$).{8,}$"
    );

    private static final Pattern PRODUCT_NAME_PATTERN = Pattern.compile(
            "^[a-zA-Z0-9\\s\\-\\.,]{3,255}$"
    );

    public static void validateEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            throw new CustomExceptions.ValidationException("Email is required");
        }
        
        if (!EMAIL_PATTERN.matcher(email).matches()) {
            throw new CustomExceptions.ValidationException("Invalid email format");
        }
        
        if (email.length() > 255) {
            throw new CustomExceptions.ValidationException("Email too long (max 255 characters)");
        }
    }

    public static void validatePassword(String password) {
        if (password == null || password.trim().isEmpty()) {
            throw new CustomExceptions.ValidationException("Password is required");
        }
        
        if (password.length() < 8) {
            throw new CustomExceptions.ValidationException("Password must be at least 8 characters long");
        }
        
        if (!PASSWORD_PATTERN.matcher(password).matches()) {
            throw new CustomExceptions.ValidationException(
                    "Password must contain at least one digit, one lowercase, one uppercase, and one special character"
            );
        }
        
        if (password.length() > 128) {
            throw new CustomExceptions.ValidationException("Password too long (max 128 characters)");
        }
    }

    public static void validateProductName(String name) {
        if (name == null || name.trim().isEmpty()) {
            throw new CustomExceptions.ValidationException("Product name is required");
        }
        
        if (!PRODUCT_NAME_PATTERN.matcher(name).matches()) {
            throw new CustomExceptions.ValidationException("Invalid product name format");
        }
    }

    public static void validatePrice(Double price) {
        if (price == null) {
            throw new CustomExceptions.ValidationException("Price is required");
        }
        
        if (price <= 0) {
            throw new CustomExceptions.ValidationException("Price must be greater than 0");
        }
        
        if (price > 999999.99) {
            throw new CustomExceptions.ValidationException("Price too high (max 999,999.99)");
        }
    }

    public static void validateStockQuantity(Integer quantity) {
        if (quantity == null) {
            throw new CustomExceptions.ValidationException("Stock quantity is required");
        }
        
        if (quantity < 0) {
            throw new CustomExceptions.ValidationException("Stock quantity cannot be negative");
        }
        
        if (quantity > 999999) {
            throw new CustomExceptions.ValidationException("Stock quantity too high (max 999,999)");
        }
    }

    public static void validateRating(Integer rating) {
        if (rating == null) {
            throw new CustomExceptions.ValidationException("Rating is required");
        }
        
        if (rating < 1 || rating > 5) {
            throw new CustomExceptions.ValidationException("Rating must be between 1 and 5");
        }
    }

    public static void validateProductId(Integer productId) {
        if (productId == null) {
            throw new CustomExceptions.ValidationException("Product ID is required");
        }
        
        if (productId <= 0) {
            throw new CustomExceptions.ValidationException("Product ID must be positive");
        }
    }

    public static void validateReviewComment(String comment) {
        if (comment != null && comment.length() > 1000) {
            throw new CustomExceptions.ValidationException("Comment too long (max 1000 characters)");
        }
    }

    public static void sanitizeString(String input) {
        if (input != null) {
            input.trim();
        }
    }

    public static boolean isValidEmail(String email) {
        try {
            validateEmail(email);
            return true;
        } catch (CustomExceptions.ValidationException e) {
            return false;
        }
    }

    public static boolean isValidPassword(String password) {
        try {
            validatePassword(password);
            return true;
        } catch (CustomExceptions.ValidationException e) {
            return false;
        }
    }
}
