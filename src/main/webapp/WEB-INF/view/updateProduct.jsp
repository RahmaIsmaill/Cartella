<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Product - Cartella E-Commerce</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #1a1a2e 0%, #16213e 100%);
            min-height: 100vh;
            color: #fff;
        }

        .navbar {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            padding: 1rem 0;
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .nav-container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 1.5rem;
            font-weight: bold;
            color: #667eea;
        }

        .nav-links {
            display: flex;
            gap: 2rem;
            align-items: center;
        }

        .nav-links a {
            text-decoration: none;
            color: #fff;
            font-weight: 500;
            transition: color 0.3s ease;
        }

        .nav-links a:hover {
            color: #667eea;
        }

        .user-info {
            display: flex;
            align-items: center;
            gap: 1rem;
            padding: 0.5rem 1rem;
            background: rgba(255, 255, 255, 0.1);
            border-radius: 8px;
        }

        .btn {
            padding: 0.5rem 1rem;
            border: none;
            border-radius: 6px;
            cursor: pointer;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.3);
        }

        .btn-secondary {
            background: #6c757d;
            color: white;
        }

        .btn-secondary:hover {
            background: #5a6268;
        }

        .btn-danger {
            background: #dc3545;
            color: white;
        }

        .btn-danger:hover {
            background: #c82333;
        }

        .container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.1);
        }

        .form-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .form-title {
            font-size: 2rem;
            color: #fff;
            margin-bottom: 0.5rem;
        }

        .form-subtitle {
            color: #b8c5d6;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 500;
            color: #b8c5d6;
        }

        .form-input {
            width: 100%;
            padding: 0.8rem;
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 8px;
            background: rgba(255, 255, 255, 0.1);
            color: #fff;
            font-size: 1rem;
            transition: all 0.3s ease;
        }

        .form-input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.2);
        }

        .form-input::placeholder {
            color: rgba(255, 255, 255, 0.5);
        }

        .form-checkbox {
            width: auto;
            margin-right: 0.5rem;
        }

        .form-actions {
            display: flex;
            gap: 1rem;
            justify-content: center;
            margin-top: 2rem;
        }

        .alert {
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1rem;
        }

        .alert-error {
            background: rgba(220, 53, 69, 0.2);
            border: 1px solid #dc3545;
            color: #ff6b6b;
        }

        .alert-success {
            background: rgba(40, 167, 69, 0.2);
            border: 1px solid #28a745;
            color: #4caf50;
        }

        .product-info {
            background: rgba(255, 255, 255, 0.05);
            padding: 1rem;
            border-radius: 8px;
            margin-bottom: 1.5rem;
        }

        .product-info h3 {
            color: #667eea;
            margin-bottom: 0.5rem;
        }

        .product-info p {
            color: #b8c5d6;
            font-size: 0.9rem;
        }

        @media (max-width: 768px) {
            .nav-container {
                flex-direction: column;
                gap: 1rem;
            }

            .form-container {
                padding: 1.5rem;
            }

            .form-actions {
                flex-direction: column;
            }

            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <div class="logo">🛍️ Cartella Admin</div>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/admin/products">Products</a>
                <a href="${pageContext.request.contextPath}/">Home</a>
                <div class="user-info">
                    <span>👤 ${loggedUser.username}</span>
                    <a href="${pageContext.request.contextPath}/signout" class="btn btn-danger btn-sm">Logout</a>
                </div>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="form-container">
            <div class="form-header">
                <h1 class="form-title">✏️ Update Product</h1>
                <p class="form-subtitle">Edit product information and details</p>
            </div>

            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <strong>Error:</strong> ${error}
                </div>
            </c:if>

            <c:if test="${not empty success}">
                <div class="alert alert-success">
                    <strong>Success:</strong> ${success}
                </div>
            </c:if>

            <c:if test="${not empty product}">
                <div class="product-info">
                    <h3>Current Product Information</h3>
                    <p><strong>ID:</strong> ${product.id}</p>
                    <p><strong>Current Price:</strong> $${product.productDetails.price}</p>
                    <p><strong>Current Status:</strong> ${product.productDetails.available ? 'Available' : 'Unavailable'}</p>
                </div>

                <form action="${pageContext.request.contextPath}/admin/products/update" method="post">
                    <input type="hidden" name="id" value="${product.id}">

                    <div class="form-group">
                        <label for="name" class="form-label">Product Name *</label>
                        <input type="text" id="name" name="name" class="form-input" 
                               value="${product.name}" required
                               placeholder="Enter product name">
                    </div>

                    <div class="form-group">
                        <label for="detailsName" class="form-label">Product Details Name</label>
                        <input type="text" id="detailsName" name="detailsName" class="form-input" 
                               value="${product.productDetails.name}"
                               placeholder="Enter detailed product name (optional)">
                    </div>

                    <div class="form-group">
                        <label for="price" class="form-label">Price ($) *</label>
                        <input type="number" id="price" name="price" class="form-input" 
                               value="${product.productDetails.price}" required
                               step="0.01" min="0" placeholder="Enter product price">
                    </div>

                    <div class="form-group">
                        <label class="form-label">
                            <input type="checkbox" id="available" name="available" class="form-checkbox" 
                                   ${product.productDetails.available ? 'checked' : ''}>
                            Product Available
                        </label>
                    </div>

                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">💾 Update Product</button>
                        <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary">❌ Cancel</a>
                    </div>
                </form>
            </c:if>

            <c:if test="${empty product}">
                <div class="alert alert-error">
                    <strong>Error:</strong> Product not found or invalid product ID.
                </div>
                <div class="form-actions">
                    <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-primary">← Back to Products</a>
                </div>
            </c:if>
        </div>
    </div>

    <script>
        // Form validation
        document.querySelector('form').addEventListener('submit', function(e) {
            const name = document.getElementById('name').value.trim();
            const price = document.getElementById('price').value;

            if (!name) {
                alert('Product name is required');
                e.preventDefault();
                return;
            }

            if (!price || parseFloat(price) < 0) {
                alert('Please enter a valid price');
                e.preventDefault();
                return;
            }
        });

        // Auto-save draft (optional enhancement)
        let autoSaveTimer;
        const form = document.querySelector('form');
        
        form.addEventListener('input', function() {
            clearTimeout(autoSaveTimer);
            autoSaveTimer = setTimeout(function() {
                // Here you could implement auto-save functionality
                console.log('Auto-saving draft...');
            }, 5000);
        });
    </script>
</body>
</html>
