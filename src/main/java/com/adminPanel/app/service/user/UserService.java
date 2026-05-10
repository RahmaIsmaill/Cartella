package com.adminPanel.app.service.user;

import com.adminPanel.app.dao.user.UserDAO;
import com.adminPanel.app.enums.Roles;
import com.adminPanel.app.model.user.User;
import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.UUID;

@Service
@Transactional
public class UserService {

    @Autowired
    private UserDAO userDAO;

    public void registerUser(User user) {
        User existing = userDAO.findByEmail(user.getEmail());
        if (existing != null) throw new RuntimeException("Email already exists");
        String hashed = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
        user.setPassword(hashed);
        user.setRole(Roles.USER);
        userDAO.save(user);
    }

    public User login(String email, String password) {
        User user = userDAO.findByEmail(email);
        if (user == null) return null;
        if (!BCrypt.checkpw(password, user.getPassword())) return null;
        return user;
    }

    public void deleteAccount(UUID id) {
        User user = userDAO.findById(id);
        if (user == null) throw new RuntimeException("User not found");
        userDAO.delete(user);
    }

    public User findById(UUID id) {
        return userDAO.findById(id);
    }
}