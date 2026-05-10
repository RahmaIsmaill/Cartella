package com.util;

import java.util.ArrayList;
import java.util.List;
import java.util.regex.Pattern;

public class ValidationUtil {

    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$");

    private static final int MIN_PASSWORD_LENGTH = 6;
    private static final int MIN_USERNAME_LENGTH = 3;
    private static final int MAX_USERNAME_LENGTH = 50;

    public static List<String> validateRegistration(
            String username, String email, String password) {

        List<String> errors = new ArrayList<>();

        if (username == null || username.trim().isEmpty()) {
            errors.add("Username is required");
        } else if (username.trim().length() < MIN_USERNAME_LENGTH) {
            errors.add("Username must be at least "
                    + MIN_USERNAME_LENGTH + " characters");
        } else if (username.trim().length() > MAX_USERNAME_LENGTH) {
            errors.add("Username must be at most "
                    + MAX_USERNAME_LENGTH + " characters");
        }

        if (email == null || email.trim().isEmpty()) {
            errors.add("Email is required");
        } else if (!EMAIL_PATTERN.matcher(email.trim()).matches()) {
            errors.add("Invalid email format");
        }

        if (password == null || password.trim().isEmpty()) {
            errors.add("Password is required");
        } else if (password.length() < MIN_PASSWORD_LENGTH) {
            errors.add("Password must be at least "
                    + MIN_PASSWORD_LENGTH + " characters");
        }

        return errors;
    }

    public static List<String> validateLogin(
            String email, String password) {

        List<String> errors = new ArrayList<>();

        if (email == null || email.trim().isEmpty()) {
            errors.add("Email is required");
        }

        if (password == null || password.trim().isEmpty()) {
            errors.add("Password is required");
        }

        return errors;
    }

    public static List<String> validateProduct(
            String name, String productPrice) {

        List<String> errors = new ArrayList<>();

        if (name == null || name.trim().isEmpty()) {
            errors.add("Product name is required");
        }

        if (productPrice == null || productPrice.trim().isEmpty()) {
            errors.add("Price is required");
        } else {
            try {
                double price = Double.parseDouble(productPrice);
                if (price <= 0) {
                    errors.add("Price must be greater than zero");
                }
            } catch (NumberFormatException e) {
                errors.add("Invalid price format");
            }
        }

        return errors;
    }

    public static List<String> validateReview(
            String ratingStr, String productIdStr) {

        List<String> errors = new ArrayList<>();

        if (ratingStr == null || ratingStr.trim().isEmpty()) {
            errors.add("Rating is required");
        } else {
            try {
                int rating = Integer.parseInt(ratingStr);
                if (rating < 1 || rating > 5) {
                    errors.add("Rating must be between 1 and 5");
                }
            } catch (NumberFormatException e) {
                errors.add("Invalid rating format");
            }
        }

        if (productIdStr == null || productIdStr.trim().isEmpty()) {
            errors.add("Product ID is required");
        } else {
            try {
                Long.parseLong(productIdStr);
            } catch (NumberFormatException e) {
                errors.add("Invalid product ID");
            }
        }

        return errors;
    }

    public static boolean isValidLong(String value) {
        if (value == null || value.trim().isEmpty()) {
            return false;
        }
        try {
            Long.parseLong(value);
            return true;
        } catch (NumberFormatException e) {
            return false;
        }
    }
}
