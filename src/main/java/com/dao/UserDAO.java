package com.dao;

import com.config.dbConnection;
import com.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {

    public void save(User user) {

        String sql = "INSERT INTO users(username,email,password,role) VALUES(?,?,?,?)";
        try (Connection connection = dbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, user.getUsername());
            statement.setString(2, user.getEmail());
            statement.setString(3, user.getPassword());
            statement.setString(4, user.getRole());
            statement.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
    public boolean existsByEmailOrUsername(String email, String username) {

        String sql = "SELECT id FROM users WHERE email = ? OR username = ?";
        try (Connection connection = dbConnection.getConnection();

             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, email);
            statement.setString(2, username);
            ResultSet resultSet = statement.executeQuery();
            return resultSet.next();
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public User findByEmail(String email) {

        String sql = "SELECT * FROM users WHERE email = ?";
        try (Connection connection = dbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, email);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                User user = new User();
                user.setId(resultSet.getLong("id"));
                user.setUsername(resultSet.getString("username"));
                user.setEmail(resultSet.getString("email"));
                user.setPassword(resultSet.getString("password"));
                user.setRole(resultSet.getString("role"));
                return user;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return null;
    }

    public User findById(Long id) {
        String sql = "SELECT * FROM users WHERE id = ?";

        try (Connection connection = dbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, id);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                User user = new User();
                user.setId(resultSet.getLong("id"));
                user.setUsername(resultSet.getString("username"));
                user.setEmail(resultSet.getString("email"));
                user.setPassword(resultSet.getString("password"));
                user.setRole(resultSet.getString("role"));
                return user;
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return null;
    }

    public boolean deleteById(Long id) {
        String sql = "DELETE FROM users WHERE id = ?";

        try (Connection connection = dbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, id);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

}