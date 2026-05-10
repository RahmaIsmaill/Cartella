package com.service;

import com.dao.ProductDAO;
import com.model.Product;
import com.util.CacheConstants;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import java.util.List;

public class ProductService {

    private static final Logger logger =
            LoggerFactory.getLogger(ProductService.class);

    private final ProductDAO productDAO = new ProductDAO();
    private final CacheService cacheService = new CacheService();

    public List<Product> getAllProducts() {
        logger.info("Fetching all products");
        List<Product> cached = cacheService.getList(CacheConstants.PRODUCTS_CACHE_KEY, Product.class);

        if (cached != null) {
            return cached;
        }
        List<Product> products = productDAO.findAll();
        cacheService.set(CacheConstants.PRODUCTS_CACHE_KEY, products);
        return products;
    }

    public Product getProductById(Long id) {
        logger.info("Fetching product with id: {}", id);
        Product cached = cacheService.get(CacheConstants.PRODUCT_CACHE_PREFIX + id, Product.class);
        if (cached != null) {
            return cached;
        }
        Product product = productDAO.findById(id);
        if (product != null) {
            cacheService.set(CacheConstants.PRODUCT_CACHE_PREFIX + id, product);
        } else {
            logger.warn("Product not found with id: {}", id);
        }
        return product;
    }

    public boolean addProduct(Product product) {
        logger.info("Adding new product: {}", product.getName());
        productDAO.save(product);
        cacheService.delete(CacheConstants.PRODUCTS_CACHE_KEY);
        return true;
    }

    public boolean updateProduct(Product product) {
        logger.info("Updating product with id: {}", product.getId());
        boolean updated = productDAO.update(product);

        if (updated) {
            cacheService.delete(CacheConstants.PRODUCT_CACHE_PREFIX + product.getId());
            cacheService.delete(CacheConstants.PRODUCTS_CACHE_KEY);
        }

        return updated;
    }

    public boolean deleteProduct(Long id) {
        logger.info("Deleting product with id: {}", id);
        boolean deleted = productDAO.deleteById(id);

        if (deleted) {
            cacheService.delete(CacheConstants.PRODUCT_CACHE_PREFIX + id);
            cacheService.delete(CacheConstants.PRODUCTS_CACHE_KEY);
        }

        return deleted;
    }
}
