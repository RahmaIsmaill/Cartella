package com.dao;

import com.config.dbConnection;
import com.model.Review;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ReviewDAO {

    public List<Review> findByProductId(Long productId) {
        String sql = "SELECT r.*, u.username FROM reviews r " +
                "JOIN users u ON r.user_id = u.id " +
                "WHERE r.product_id = ? ORDER BY r.created_at DESC";
        List<Review> reviews = new ArrayList<>();

        try (Connection connection = dbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, productId);
            ResultSet resultSet = statement.executeQuery();

            while (resultSet.next()) {
                reviews.add(reviewMapper(resultSet));
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return reviews;
    }

    public Review findById(Long id) {
        String sql = "SELECT r.*, u.username FROM reviews r " +
                "JOIN users u ON r.user_id = u.id " +
                "WHERE r.id = ?";

        try (Connection connection = dbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, id);
            ResultSet resultSet = statement.executeQuery();

            if (resultSet.next()) {
                return reviewMapper(resultSet);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return null;
    }

    public void save(Review review) {
        String sql = "INSERT INTO reviews(user_id, product_id, rating, comment) VALUES(?, ?, ?, ?)";

        try (Connection connection = dbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setLong(1, review.getUserId());
            statement.setLong(2, review.getProductId());
            statement.setInt(3, review.getRating());
            statement.setString(4, review.getComment());

            statement.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean update(Review review) {
        String sql = "UPDATE reviews SET rating = ?, comment = ? WHERE id = ?";

        try (Connection connection = dbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setInt(1, review.getRating());
            statement.setString(2, review.getComment());
            statement.setLong(3, review.getId());

            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean deleteById(Long id) {
        String sql = "DELETE FROM reviews WHERE id = ?";

        try (Connection connection = dbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, id);
            return statement.executeUpdate() > 0;

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private Review reviewMapper(ResultSet resultSet) throws SQLException {
        Review review = new Review();
        review.setId(resultSet.getLong("id"));
        review.setUserId(resultSet.getLong("user_id"));
        review.setProductId(resultSet.getLong("product_id"));
        review.setRating(resultSet.getInt("rating"));
        review.setComment(resultSet.getString("comment"));
        review.setCreatedAt(resultSet.getTimestamp("created_at"));
        review.setUsername(resultSet.getString("username"));
        return review;
    }
}
