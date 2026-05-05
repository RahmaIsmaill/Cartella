package com.adminPanel.app.controller;

import com.adminPanel.app.services.ProductService;
import com.adminPanel.app.model.Product;
import com.adminPanel.app.model.ProductDetails;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@Controller
@RequestMapping("/products")
public class ProductController {

    @Autowired
    private ProductService productService;

    @GetMapping
    public String showAllProducts(Model model) {
        List<Product> allProducts = productService.getAllProducts();
        model.addAttribute("AllProducts", allProducts);
        return "AllProductsPage";
    }

    @GetMapping("/delete/{id}")
    public String deleteProduct(@PathVariable int id) {
        productService.deleteProduct(id);
        return "redirect:/products";
    }

    @GetMapping("/view/{id}")
    public String viewDetails(Model model, @PathVariable int id) {
        Product product = productService.getProductById(id);
        if (product == null) {
            return "redirect:/products";
        }
        model.addAttribute("product", product);
        return "viewDetails";
    }

    @GetMapping("/add")
    public String showAddProductForm(Model model) {
        Product product = new Product();
        product.setProductDetails(new ProductDetails());
        model.addAttribute("product", product);
        return "addProductFormPage";
    }

    @PostMapping("/add")
    public String addProduct(@ModelAttribute Product product) {
        if (product.getProductDetails() == null) {
            product.setProductDetails(new ProductDetails());
        }
        product.getProductDetails().setProduct(product);
        productService.addProduct(product);
        return "redirect:/products";
    }


    @GetMapping("/update/{id}")
    public String showUpdateProductForm(Model model , @PathVariable int id) {
        Product product = productService.getProductById(id);
        model.addAttribute("product", product);
        return "updateProductDetails";
    }

    @PostMapping("/update")
    public String updateProduct(@ModelAttribute Product product) {
        if (product.getProductDetails() == null) {
            product.setProductDetails(new ProductDetails());
        }
        product.getProductDetails().setProduct(product);
        productService.updateProduct(product);
        return "redirect:/products";
    }


}
