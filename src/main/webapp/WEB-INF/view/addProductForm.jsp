<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cartella - Add Product</title>
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
            max-width: 800px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .form-container {
            background: rgba(255, 255, 255, 0.1);
            backdrop-filter: blur(10px);
            border-radius: 20px;
            padding: 2.5rem;
            box-shadow: 0 20px 40px rgba(0,0,0,0.2);
        }

        .form-header {
            text-align: center;
            margin-bottom: 2rem;
        }

        .form-header h1 {
            font-size: 2rem;
            margin-bottom: 0.5rem;
        }

        .form-header p {
            color: #a0aec0;
        }

        .form-group {
            margin-bottom: 1.5rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #e2e8f0;
        }

        .form-group input,
        .form-group select {
            width: 100%;
            padding: 0.875rem 1rem;
            background: rgba(255, 255, 255, 0.1);
            border: 2px solid rgba(255, 255, 255, 0.2);
            border-radius: 12px;
            color: white;
            font-size: 1rem;
            transition: all 0.3s ease;
            outline: none;
        }

        .form-group input::placeholder {
            color: #a0aec0;
        }

        .form-group input:focus,
        .form-group select:focus {
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.2);
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 0.75rem;
            margin: 1.5rem 0;
        }

        .checkbox-group input[type="checkbox"] {
            width: auto;
            transform: scale(1.2);
        }

        .error-message {
            background: rgba(245, 101, 101, 0.2);
            color: #fc8181;
            padding: 1rem;
            border-radius: 12px;
            margin-bottom: 1.5rem;
            border: 1px solid rgba(245, 101, 101, 0.3);
        }

        .form-actions {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
        }

        .btn {
            padding: 0.875rem 2rem;
            border: none;
            border-radius: 12px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s ease;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            justify-content: center;
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

        @media (max-width: 768px) {
            .container {
                padding: 0 1rem;
            }
            
            .form-container {
                padding: 1.5rem;
            }
            
            .form-actions {
                flex-direction: column;
            }
        }
    </style>
</head>
<body>
<nav class="navbar">
    <div class="nav-container">
        <div class="logo">🛍️ Cartella Admin</div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/admin/products">📦 Products</a>
            <a href="${pageContext.request.contextPath}/">🏠 Home</a>
            <a href="${pageContext.request.contextPath}/signout">🚪 Sign Out</a>
        </div>
    </div>
</nav>

<div class="container">
    <div class="form-container">
        <div class="form-header">
            <h1>➕ Add New Product</h1>
            <p>Fill in the details to add a new product to your catalog</p>
        </div>

        <c:if test="${not empty error}">
            <div class="error-message">
                ⚠️ ${error}
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/admin/products/add" method="post">
            <div class="form-group">
                <label for="name">Product Name *</label>
                <input type="text"
                       id="name"
                       name="name"
                       placeholder="Enter product name"
                       value="${param.name}"
                       required>
            </div>

            <div class="form-group">
                <label for="detailsName">Details Name *</label>
                <input type="text"
                       id="detailsName"
                       name="detailsName"
                       placeholder="Enter detailed product name"
                       value="${param.detailsName}"
                       required>
            </div>

            <div class="form-group">
                <label for="price">Price ($) *</label>
                <input type="number"
                       id="price"
                       name="price"
                       placeholder="0.00"
                       step="0.01"
                       min="0"
                       value="${param.price}"
                       required>
            </div>

            <div class="checkbox-group">
                <input type="checkbox"
                       id="available"
                       name="available"
                       value="true"
                       ${empty param.available ? 'checked' : ''}>
                <label for="available">Available for purchase</label>
            </div>

            <div class="form-actions">
                <button type="submit" class="btn btn-primary">
                    ✅ Add Product
                </button>
                <a href="${pageContext.request.contextPath}/admin/products" class="btn btn-secondary">
                    ❌ Cancel
                </a>
            </div>
        </form>
    </div>
</div>
</body>
</html>
