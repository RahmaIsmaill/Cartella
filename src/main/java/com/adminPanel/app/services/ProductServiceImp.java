package com.adminPanel.app.services;

import com.adminPanel.app.dao.ProductDAO;
import com.adminPanel.app.model.Product;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
public class ProductServiceImp implements ProductService {

    @Autowired
    private ProductDAO productDAO;

    @Override
    @Transactional
    public void addProduct(Product product) {
        productDAO.saveProduct(product);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Product> getAllProducts() {
        return productDAO.getAllProducts();
    }

    @Override
    @Transactional(readOnly = true)
    public Product getProductById(int id) {
        return productDAO.getProductById(id);
    }

    @Override
    @Transactional
    public void updateProduct(Product product) {
        productDAO.updateProduct(product);
    }

    @Override
    @Transactional
    public void deleteProduct(int id) {
        productDAO.deleteProduct(id);
    }
}
