package com.adminPanel.app.services;

import com.adminPanel.app.model.Product;

import java.util.List;

public interface ProductService {
    void addProduct(Product product);
    List<Product> getAllProducts();
    Product getProductById(int id);
    public void updateProduct(Product product);
    public void deleteProduct(int id);
}
