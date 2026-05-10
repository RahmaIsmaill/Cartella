<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>All Products - Cartella E-Commerce</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            min-height: 100vh;
        }

        .navbar {
            background: white;
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
            color: #2c3e50;
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
            background: #f8f9fa;
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

        .container {
            max-width: 1200px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .page-header {
            text-align: center;
            margin-bottom: 3rem;
        }

        .page-title {
            font-size: 2.5rem;
            color: #2c3e50;
            margin-bottom: 1rem;
        }

        .page-subtitle {
            color: #7f8c8d;
            font-size: 1.1rem;
        }

        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .product-card {
            background: white;
            border-radius: 15px;
            overflow: hidden;
            box-shadow: 0 10px 30px rgba(0, 0, 0, 0.1);
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }

        .product-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 20px 40px rgba(0, 0, 0, 0.15);
        }

        .product-image {
            width: 100%;
            height: 200px;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            font-size: 3rem;
            font-weight: bold;
        }

        .product-info {
            padding: 1.5rem;
        }

        .product-name {
            font-size: 1.3rem;
            font-weight: bold;
            color: #2c3e50;
            margin-bottom: 0.5rem;
        }

        .product-price {
            font-size: 1.5rem;
            color: #27ae60;
            font-weight: bold;
            margin-bottom: 1rem;
        }

        .product-availability {
            display: inline-block;
            padding: 0.3rem 0.8rem;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
            margin-bottom: 1rem;
        }

        .available {
            background: #d4edda;
            color: #155724;
        }

        .unavailable {
            background: #f8d7da;
            color: #721c24;
        }

        .product-actions {
            display: flex;
            gap: 0.5rem;
        }

        .btn-sm {
            padding: 0.4rem 0.8rem;
            font-size: 0.9rem;
        }

        .empty-state {
            text-align: center;
            padding: 4rem 2rem;
            color: #7f8c8d;
        }

        .empty-state-icon {
            font-size: 4rem;
            margin-bottom: 1rem;
        }

        .empty-state-title {
            font-size: 1.5rem;
            margin-bottom: 0.5rem;
        }

        .empty-state-message {
            font-size: 1rem;
            margin-bottom: 2rem;
        }

        @media (max-width: 768px) {
            .nav-container {
                flex-direction: column;
                gap: 1rem;
            }

            .products-grid {
                grid-template-columns: 1fr;
            }

            .page-title {
                font-size: 2rem;
            }
        }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="nav-container">
            <div class="logo">🛍️ Cartella</div>
            <div class="nav-links">
                <a href="${pageContext.request.contextPath}/">Home</a>
                <a href="${pageContext.request.contextPath}/products">Products</a>
                <c:if test="${not empty requestScope.loggedUser}">
                    <div class="user-info">
                        <span>👤 ${requestScope.loggedUser.username}</span>
                        <c:if test="${requestScope.loggedUser.role == 'ADMIN'}">
                            <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-primary btn-sm">Admin Panel</a>
                        </c:if>
                        <a href="${pageContext.request.contextPath}/signout" class="btn btn-secondary btn-sm">Logout</a>
                    </div>
                </c:if>
                <c:if test="${empty requestScope.loggedUser}">
                    <a href="${pageContext.request.contextPath}/signin" class="btn btn-primary">Login</a>
                    <a href="${pageContext.request.contextPath}/signup" class="btn btn-secondary">Register</a>
                </c:if>
            </div>
        </div>
    </nav>

    <div class="container">
        <div class="page-header">
            <h1 class="page-title">🛍️ All Products</h1>
            <p class="page-subtitle">Browse our complete collection of products</p>
        </div>

        <c:choose>
            <c:when test="${not empty products and products.size() > 0}">
                <div class="products-grid">
                    <c:forEach var="product" items="${products}">
                        <div class="product-card">
                            <div class="product-image">
                                📦
                            </div>
                            <div class="product-info">
                                <h3 class="product-name">${product.name}</h3>
                                <div class="product-price">$${product.productDetails.price}</div>
                                <span class="product-availability ${product.productDetails.available ? 'available' : 'unavailable'}">
                                    ${product.productDetails.available ? '✓ In Stock' : '✗ Out of Stock'}
                                </span>
                                <div class="product-actions">
                                    <a href="${pageContext.request.contextPath}/products/view/${product.id}" class="btn btn-primary btn-sm">View Details</a>
                                    <c:if test="${not empty requestScope.loggedUser and requestScope.loggedUser.role == 'ADMIN'}">
                                        <a href="${pageContext.request.contextPath}/admin/products/update/${product.id}" class="btn btn-secondary btn-sm">Edit</a>
                                    </c:if>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </c:when>
            <c:otherwise>
                <div class="empty-state">
                    <div class="empty-state-icon">📦</div>
                    <h2 class="empty-state-title">No Products Found</h2>
                    <p class="empty-state-message">We couldn't find any products in our inventory.</p>
                    <c:if test="${not empty requestScope.loggedUser and requestScope.loggedUser.role == 'ADMIN'}">
                        <a href="${pageContext.request.contextPath}/admin/products/add" class="btn btn-primary">Add First Product</a>
                    </c:if>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</body>
</html>
