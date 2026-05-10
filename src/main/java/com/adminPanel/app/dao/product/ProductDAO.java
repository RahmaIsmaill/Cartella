package com.adminPanel.app.dao.product;

import com.adminPanel.app.model.product.Product;
import lombok.RequiredArgsConstructor;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Repository
@Transactional
@RequiredArgsConstructor
public class ProductDAO {

    private final SessionFactory sessionFactory;

    private Session getSession() {
        return sessionFactory.getCurrentSession();
    }

    @Transactional
    public void saveProduct(Product product) {
        getSession().save(product);
    }

    @Transactional(readOnly = true)
    public List<Product> getAllProducts() {
        return getSession()
                .createQuery("from Product", Product.class)
                .list();
    }

    @Transactional(readOnly = true)
    public Product getProductById(int id) {
        return getSession().get(Product.class, id);
    }

    @Transactional
    public void updateProduct(Product product) {
        getSession().update(product);
    }

    @Transactional
    public void deleteProduct(int id) {
        Product product = getSession().get(Product.class, id);
        if (product != null) {
            getSession().delete(product);
        }
    }
}
