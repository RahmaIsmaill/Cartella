package com.adminPanel.app.service.product;

import com.adminPanel.app.dao.product.ProductDAO;
import com.adminPanel.app.exception.CustomExceptions;
import com.adminPanel.app.model.product.Product;
import com.adminPanel.app.service.cache.CacheService;
import com.adminPanel.app.util.ValidationUtils;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.concurrent.TimeUnit;

@Slf4j
@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductDAO productDAO;
    private final CacheService cacheService;

    @Transactional
    public Product addProduct(Product product) {
        ValidationUtils.validateProductName(product.getName());
        ValidationUtils.validatePrice(product.getPrice());
        ValidationUtils.validateStockQuantity(product.getStockQuantity());
        
        Product savedProduct = productDAO.saveProduct(product);
        cacheService.delete("products:all");
        
        log.info("Product added successfully: {}", savedProduct.getName());
        return savedProduct;
    }

    @Transactional(readOnly = true)
    public List<Product> getAllProducts() {
        String cacheKey = "products:all";

        List<Product> cachedProducts = cacheService.get(cacheKey, List.class);
        if (cachedProducts != null) {
            log.debug("Products retrieved from cache: {} items", cachedProducts.size());
            return cachedProducts;
        }

        List<Product> products = productDAO.getAllProducts();
        cacheService.set(cacheKey, products, 10, TimeUnit.MINUTES);
        
        log.info("Products retrieved from database: {} items", products.size());
        return products;
    }

    @Transactional(readOnly = true)
    public Product getProductById(int id) {
        ValidationUtils.validateProductId(id);
        
        String cacheKey = "product:" + id;
        Product cachedProduct = cacheService.get(cacheKey, Product.class);
        
        if (cachedProduct != null) {
            log.debug("Product retrieved from cache: {}", id);
            return cachedProduct;
        }
        
        Product product = productDAO.getProductById(id);
        if (product == null) {
            throw new CustomExceptions.ResourceNotFoundException("Product not found with id: " + id);
        }
        
        cacheService.set(cacheKey, product, 15, TimeUnit.MINUTES);
        log.debug("Product retrieved from database: {}", id);
        return product;
    }

    @Transactional
    public Product updateProduct(Product product) {
        ValidationUtils.validateProductId(product.getId());
        ValidationUtils.validateProductName(product.getName());
        ValidationUtils.validatePrice(product.getPrice());
        ValidationUtils.validateStockQuantity(product.getStockQuantity());
        
        Product existingProduct = productDAO.getProductById(product.getId());
        if (existingProduct == null) {
            throw new CustomExceptions.ResourceNotFoundException("Product not found with id: " + product.getId());
        }
        
        Product updatedProduct = productDAO.updateProduct(product);
        cacheService.delete("product:" + product.getId());
        cacheService.delete("products:all");
        
        log.info("Product updated successfully: {}", updatedProduct.getName());
        return updatedProduct;
    }

    @Transactional
    public void deleteProduct(int id) {
        ValidationUtils.validateProductId(id);
        
        Product existingProduct = productDAO.getProductById(id);
        if (existingProduct == null) {
            throw new CustomExceptions.ResourceNotFoundException("Product not found with id: " + id);
        }
        
        productDAO.deleteProduct(id);
        cacheService.delete("product:" + id);
        cacheService.delete("products:all");
        
        log.info("Product deleted successfully: {}", existingProduct.getName());
    }

    @Transactional(readOnly = true)
    public List<Product> searchProducts(String keyword, String category) {
        if (keyword != null) {
            keyword = keyword.trim();
            if (keyword.isEmpty()) {
                keyword = null;
            }
        }
        
        return productDAO.searchProducts(keyword, category);
    }
}
