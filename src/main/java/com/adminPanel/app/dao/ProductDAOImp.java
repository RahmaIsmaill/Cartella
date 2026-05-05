package com.adminPanel.app.dao;

import com.adminPanel.app.model.Product;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
public class ProductDAOImp implements ProductDAO {

    @Autowired
    private SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Override
    @Transactional
    public void saveProduct(Product product) {
        getSession().save(product);
    }

    @Override
    @Transactional(readOnly = true)
    public List<Product> getAllProducts() {
        return getSession()
                .createQuery("from Product", Product.class)
                .list();
    }

    @Override
    @Transactional(readOnly = true)
    public Product getProductById(int id) {
        return getSession().get(Product.class, id);
    }

    @Override
    @Transactional
    public void updateProduct(Product product) {
        getSession().update(product);
    }

    @Override
    @Transactional
    public void deleteProduct(int id) {
        Product product = getSession().get(Product.class, id);
        if (product != null) {
            getSession().delete(product);
        }
    }
}
