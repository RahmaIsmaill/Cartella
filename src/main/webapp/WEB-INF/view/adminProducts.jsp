<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cartella - Admin Panel</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', sans-serif;
            background: linear-gradient(135deg, #1a1a2e 0%, #2d3748 100%);
            color: white;
            min-height: 100vh;
        }

        .navbar {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 20px rgba(0,0,0,0.2);
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 1px solid rgba(255,255,255,0.1);
        }

        .nav-container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            font-size: 1.8rem;
            font-weight: 800;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 1.5rem;
        }

        .nav-links a {
            color: white;
            text-decoration: none;
            font-weight: 500;
            transition: all 0.3s ease;
            padding: 0.5rem 1rem;
            border-radius: 8px;
        }

        .nav-links a:hover {
            background: rgba(255, 255, 255, 0.1);
        }

        .container {
            max-width: 1280px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .admin-header {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2rem;
            margin-bottom: 2rem;
            text-align: center;
        }

        .admin-header h1 {
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .admin-header p {
            color: #a0aec0;
        }

        .actions-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .actions-bar h2 {
            font-size: 1.5rem;
        }

        .btn {
            padding: 0.75rem 1.5rem;
            border: none;
            border-radius: 12px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            cursor: pointer;
        }

        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }

        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 10px 20px rgba(102, 126, 234, 0.3);
        }

        .btn-secondary {
            background: rgba(255, 255, 255, 0.1);
            color: white;
            border: 2px solid rgba(255, 255, 255, 0.2);
        }

        .btn-secondary:hover {
            background: rgba(255, 255, 255, 0.2);
        }

        .products-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 1.5rem;
        }

        .product-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 1.5rem;
            transition: all 0.3s ease;
            border: 1px solid rgba(255, 255, 255, 0.1);
        }

        .product-card:hover {
            transform: translateY(-5px);
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 15px 30px rgba(0,0,0,0.2);
        }

        .product-name {
            font-size: 1.2rem;
            font-weight: 700;
            margin-bottom: 1rem;
            color: white;
        }

        .product-details {
            margin: 1rem 0;
            color: #a0aec0;
            font-size: 0.9rem;
        }

        .product-price {
            font-size: 1.5rem;
            font-weight: 800;
            color: #48bb78;
            margin: 1rem 0;
        }

        .product-availability {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 600;
            margin: 0.5rem 0;
        }

        .available {
            background: #48bb78;
            color: white;
        }

        .not-available {
            background: #f56565;
            color: white;
        }

        .product-actions {
            display: flex;
            gap: 0.5rem;
            margin-top: 1rem;
        }

        .btn-sm {
            padding: 0.5rem 1rem;
            font-size: 0.875rem;
        }

        .btn-danger {
            background: #f56565;
            color: white;
        }

        .btn-danger:hover {
            background: #e53e3e;
        }

        .empty-state {
            text-align: center;
            padding: 3rem;
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            color: #a0aec0;
        }

        .stats {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(200px, 1fr));
            gap: 1rem;
            margin-bottom: 2rem;
        }

        .stat-card {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 15px;
            padding: 1.5rem;
            text-align: center;
        }

        .stat-number {
            font-size: 2rem;
            font-weight: 800;
            color: #667eea;
            margin-bottom: 0.5rem;
        }

        .stat-label {
            color: #a0aec0;
            font-size: 0.9rem;
        }

        @media (max-width: 768px) {
            .container {
                padding: 0 1rem;
            }
            
            .products-grid {
                grid-template-columns: 1fr;
            }
            
            .actions-bar {
                flex-direction: column;
                align-items: stretch;
            }
            
            .stats {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>
<nav class="navbar">
    <div class="nav-container">
        <div class="logo">🛍️ Cartella Admin</div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/">🏠 Home</a>
            <a href="${pageContext.request.contextPath}/admin/products">📦 Products</a>
            <a href="${pageContext.request.contextPath}/signout">🚪 Sign Out</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="admin-header">
        <h1>👑 Admin Dashboard</h1>
        <p>Manage your e-commerce store</p>
    </div>

    <div class="stats">
        <div class="stat-card">
            <div class="stat-number">${products.size()}</div>
            <div class="stat-label">Total Products</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">
                <c:set var="availableCount" value="0"/>
                <c:forEach var="product" items="${products}">
                    <c:if test="${product.productDetails.available}">
                        <c:set var="availableCount" value="${availableCount + 1}"/>
                    </c:if>
                </c:forEach>
                ${availableCount}
            </div>
            <div class="stat-label">In Stock</div>
        </div>
        <div class="stat-card">
            <div class="stat-number">
                <c:set var="outOfStockCount" value="0"/>
                <c:forEach var="product" items="${products}">
                    <c:if test="${not product.productDetails.available}">
                        <c:set var="outOfStockCount" value="${outOfStockCount + 1}"/>
                    </c:if>
                </c:forEach>
                ${outOfStockCount}
            </div>
            <div class="stat-label">Out of Stock</div>
        </div>
    </div>

    <div class="actions-bar">
        <h2>📦 Products Management</h2>
        <a href="${pageContext.request.contextPath}/admin/products/add" class="btn btn-primary">
            ➕ Add New Product
        </a>
    </div>

    <c:choose>
        <c:when test="${empty products}">
            <div class="empty-state">
                <div style="font-size: 3rem; margin-bottom: 1rem;">📦</div>
                <h3>No products found</h3>
                <p>Start by adding your first product to the catalog.</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="products-grid">
                <c:forEach var="product" items="${products}">
                    <div class="product-card">
                        <div class="product-name">${product.name}</div>
                        
                        <c:if test="${not empty product.productDetails}">
                            <div class="product-details">
                                <p><strong>Details:</strong> ${product.productDetails.name}</p>
                                <p><strong>Price:</strong> $${product.productDetails.price}</p>
                            </div>
                            
                            <div class="product-price">$${product.productDetails.price}</div>
                            
                            <c:choose>
                                <c:when test="${product.productDetails.available}">
                                    <span class="product-availability available">✓ In Stock</span>
                                </c:when>
                                <c:otherwise>
                                    <span class="product-availability not-available">✗ Out of Stock</span>
                                </c:otherwise>
                            </c:choose>
                        </c:if>
                        
                        <div class="product-actions">
                            <a href="${pageContext.request.contextPath}/products/view/${product.id}" class="btn btn-secondary btn-sm">
                                👁️ View
                            </a>
                            <form action="${pageContext.request.contextPath}/admin/products/delete" method="post" style="display: inline;">
                                <input type="hidden" name="id" value="${product.id}">
                                <button type="submit" class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this product?')">
                                    🗑️ Delete
                                </button>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
