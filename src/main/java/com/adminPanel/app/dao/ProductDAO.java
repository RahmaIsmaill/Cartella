package com.adminPanel.app.dao;

import com.adminPanel.app.model.Product;

import java.util.List;

public interface ProductDAO {


    void saveProduct(Product product);
    List<Product> getAllProducts();
    Product getProductById(int id);
    public void updateProduct(Product product);
    public void deleteProduct(int id);

}
