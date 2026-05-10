package com.adminPanel.app.service.user;

import com.adminPanel.app.dao.user.UserDAO;
import com.adminPanel.app.enums.Roles;
import com.adminPanel.app.exception.CustomExceptions;
import com.adminPanel.app.model.user.User;
import com.adminPanel.app.service.auth.AuthService;
import com.adminPanel.app.util.ValidationUtils;
import lombok.RequiredArgsConstructor;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@Transactional
@RequiredArgsConstructor
public class UserService {

    private final UserDAO userDAO;
    private final AuthService authService;

    public User registerUser(User user) {
        ValidationUtils.validateEmail(user.getEmail());
        ValidationUtils.validatePassword(user.getPassword());
        
        User existing = userDAO.findByEmail(user.getEmail());
        if (existing != null) {
            throw new CustomExceptions.DuplicateResourceException("Email already exists");
        }
        
        String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashed);
        user.setRole(Roles.USER);
        
        return userDAO.save(user);
    }

    public User login(String email, String password) {
        ValidationUtils.validateEmail(email);
        
        User user = userDAO.findByEmail(email);
        if (user == null) {
            throw new CustomExceptions.AuthenticationException("Invalid email or password");
        }
        
        if (!BCrypt.checkpw(password, user.getPassword())) {
            throw new CustomExceptions.AuthenticationException("Invalid email or password");
        }
        
        return user;
    }

    public String generateAuthToken(User user) {
        return authService.generateToken(user.getId(), user.getEmail(), user.getRole().name());
    }

    public void deleteAccount(UUID id) {
        User user = userDAO.findById(id);
        if (user == null) {
            throw new CustomExceptions.ResourceNotFoundException("User not found");
        }
        userDAO.delete(user);
    }

    public User findById(UUID id) {
        User user = userDAO.findById(id);
        if (user == null) {
            throw new CustomExceptions.ResourceNotFoundException("User not found");
        }
        return user;
    }

    public User findByEmail(String email) {
        ValidationUtils.validateEmail(email);
        return userDAO.findByEmail(email);
    }
}