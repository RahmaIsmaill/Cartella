package com.dao;

import com.config.dbConnection;
import com.model.Product;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {

    public List<Product> findAll() {
        String sql = "SELECT * FROM products ORDER BY created_at DESC";
        List<Product> products = new ArrayList<>();

        try (Connection connection = dbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql);
             ResultSet resultSet = statement.executeQuery()) {
            while (resultSet.next()) {
                products.add(productMapper(resultSet));
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return products;
    }

    public Product findById(Long id) {
        String sql = "SELECT * FROM products WHERE id = ?";
        try (Connection connection = dbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, id);
            ResultSet resultSet = statement.executeQuery();
            if (resultSet.next()) {
                return productMapper(resultSet);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    public void save(Product product) {
        String sql = "INSERT INTO products(name, description, price, image_url) VALUES(?, ?, ?, ?)";

        try (Connection connection = dbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {

            statement.setString(1, product.getName());
            statement.setString(2, product.getDescription());
            statement.setBigDecimal(3, product.getPrice());
            statement.setString(4, product.getImageUrl());

            statement.executeUpdate();

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean update(Product product) {
        String sql = "UPDATE products SET name = ?, description = ?, price = ?, image_url = ? WHERE id = ?";
        try (Connection connection = dbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setString(1, product.getName());
            statement.setString(2, product.getDescription());
            statement.setBigDecimal(3, product.getPrice());
            statement.setString(4, product.getImageUrl());
            statement.setLong(5, product.getId());
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    public boolean deleteById(Long id) {
        String sql = "DELETE FROM products WHERE id = ?";
        try (Connection connection = dbConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(sql)) {
            statement.setLong(1, id);
            return statement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    private Product productMapper(ResultSet resultSet) throws SQLException {
        Product product = new Product();
        product.setId(resultSet.getLong("id"));
        product.setName(resultSet.getString("name"));
        product.setDescription(resultSet.getString("description"));
        product.setPrice(resultSet.getBigDecimal("price"));
        product.setImageUrl(resultSet.getString("image_url"));
        product.setCreatedAt(resultSet.getTimestamp("created_at"));
        return product;
    }
}
