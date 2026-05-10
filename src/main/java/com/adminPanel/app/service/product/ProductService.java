package com.adminPanel.app.service.product;

import com.adminPanel.app.dao.product.ProductDAO;
import com.adminPanel.app.model.product.Product;
import com.adminPanel.app.service.cache.CacheService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.concurrent.TimeUnit;

@Service
@RequiredArgsConstructor
public class ProductService {

    private final ProductDAO productDAO;
    
    private final CacheService cacheService;

    @Transactional
    public void addProduct(Product product) {
        productDAO.saveProduct(product);
        cacheService.delete("products:all");
    }

    @Transactional(readOnly = true)
    public List<Product> getAllProducts() {
        String cacheKey = "products:all";

        List<Product> cachedProducts = cacheService.get(cacheKey, List.class);

        if (cachedProducts != null) {
//            System.out.println("FROM REDIS");
//            System.out.println("CACHE VALUE = " + cachedProducts);
            return cachedProducts;
        }

//        System.out.println("FROM DB");
        List<Product> products = productDAO.getAllProducts();

//        System.out.println("DB RESULT SIZE = " + products.size());

        cacheService.set(cacheKey, products, 10, TimeUnit.MINUTES);
        return products;
    }

    @Transactional(readOnly = true)
    public Product getProductById(int id) {
        String cacheKey = "product:" + id;
        Product cachedProduct = cacheService.get(cacheKey, Product.class);
        
        if (cachedProduct != null) {
            return cachedProduct;
        }
        
        Product product = productDAO.getProductById(id);
        if (product != null) {
            cacheService.set(cacheKey, product, 15, TimeUnit.MINUTES);
        }
        return product;
    }

    @Transactional
    public void updateProduct(Product product) {
        productDAO.updateProduct(product);
        cacheService.delete("product:" + product.getId());
        cacheService.delete("products:all");
    }

    @Transactional
    public void deleteProduct(int id) {
        productDAO.deleteProduct(id);
        cacheService.delete("product:" + id);
        cacheService.delete("products:all");
    }
}
