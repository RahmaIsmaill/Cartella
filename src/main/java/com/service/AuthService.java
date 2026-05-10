package com.service;

import com.dao.UserDAO;
import com.model.User;
import org.mindrot.jbcrypt.BCrypt;

public class AuthService {

    private final UserDAO userDAO = new UserDAO();

    public boolean register(User user) {

        boolean userExists = userDAO.existsByEmailOrUsername(user.getEmail(), user.getUsername());
        if (userExists) {
            return false;
        }
        String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashedPassword);
        user.setRole("USER");
        userDAO.save(user);
        return true;
    }

    public User login(String email, String password) {

        User user = userDAO.findByEmail(email);
        if (user == null) {
            return null;
        }

        boolean isPasswordCorrect = BCrypt.checkpw(password, user.getPassword());
        if (isPasswordCorrect) {
            return user;
        }
        return null;
    }
}