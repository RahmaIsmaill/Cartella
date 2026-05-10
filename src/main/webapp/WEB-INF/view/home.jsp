<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cartella | Premium Shopping Experience</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', sans-serif;
            background: linear-gradient(135deg, #f5f7fa 0%, #e9ecef 100%);
            color: #1a1a2e;
            line-height: 1.5;
            min-height: 100vh;
        }

        /* Modern Navbar */
        .navbar {
            background: rgba(255, 255, 255, 0.95);
            backdrop-filter: blur(10px);
            box-shadow: 0 2px 20px rgba(0,0,0,0.08);
            position: sticky;
            top: 0;
            z-index: 1000;
            border-bottom: 1px solid rgba(0,0,0,0.05);
        }

        .nav-container {
            max-width: 1280px;
            margin: 0 auto;
            padding: 1rem 2rem;
            display: flex;
            justify-content: space-between;
            align-items: center;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .logo {
            font-size: 1.8rem;
            font-weight: 800;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
            letter-spacing: -0.5px;
        }

        .nav-links {
            display: flex;
            align-items: center;
            gap: 1.5rem;
            flex-wrap: wrap;
        }

        .nav-links a {
            text-decoration: none;
            color: #4a5568;
            font-weight: 500;
            transition: all 0.3s ease;
            font-size: 0.95rem;
        }

        .nav-links a:hover {
            color: #667eea;
            transform: translateY(-1px);
        }

        .user-greeting {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            padding: 0.5rem 1.2rem;
            border-radius: 50px;
            color: white !important;
            font-weight: 600;
        }

        .btn-outline {
            border: 2px solid #667eea;
            padding: 0.5rem 1.2rem;
            border-radius: 50px;
            color: #667eea;
            font-weight: 600;
        }

        .btn-outline:hover {
            background: #667eea;
            color: white !important;
        }

        /* Main Container */
        .container {
            max-width: 1280px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        /* Hero Section */
        .hero {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            border-radius: 30px;
            padding: 3rem;
            margin-bottom: 3rem;
            color: white;
            text-align: center;
            box-shadow: 0 20px 40px rgba(102, 126, 234, 0.3);
        }

        .hero h1 {
            font-size: 2.5rem;
            margin-bottom: 1rem;
        }

        .hero p {
            font-size: 1.1rem;
            opacity: 0.95;
        }

        /* Section Headers */
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: baseline;
            margin-bottom: 2rem;
            flex-wrap: wrap;
            gap: 1rem;
        }

        .section-header h2 {
            font-size: 1.8rem;
            font-weight: 700;
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            -webkit-background-clip: text;
            background-clip: text;
            color: transparent;
        }

        .section-header a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }

        /* Product Grid */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(280px, 1fr));
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .product-card {
            background: white;
            border-radius: 20px;
            overflow: hidden;
            transition: all 0.3s cubic-bezier(0.4, 0, 0.2, 1);
            box-shadow: 0 4px 6px rgba(0,0,0,0.07);
            cursor: pointer;
        }

        .product-card:hover {
            transform: translateY(-8px);
            box-shadow: 0 20px 30px rgba(0,0,0,0.15);
        }

        .product-image {
            height: 220px;
            background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 4rem;
        }

        .product-info {
            padding: 1.5rem;
        }

        .product-info h3 {
            font-size: 1.2rem;
            margin-bottom: 0.5rem;
            color: #1a1a2e;
        }

        .price {
            font-size: 1.5rem;
            font-weight: 800;
            color: #667eea;
            margin: 0.5rem 0;
        }

        .badge {
            display: inline-block;
            padding: 0.25rem 0.75rem;
            border-radius: 50px;
            font-size: 0.75rem;
            font-weight: 600;
            margin-top: 0.5rem;
        }

        .badge-success {
            background: #48bb78;
            color: white;
        }

        .badge-danger {
            background: #f56565;
            color: white;
        }

        .btn-link {
            display: inline-block;
            margin-top: 1rem;
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
        }

        /* Reviews Section */
        .reviews-section {
            background: white;
            border-radius: 30px;
            padding: 2rem;
            box-shadow: 0 4px 20px rgba(0,0,0,0.05);
        }

        .reviews-grid {
            display: grid;
            gap: 1.5rem;
            margin-top: 1.5rem;
        }

        .review-card {
            background: #f8f9fa;
            padding: 1.5rem;
            border-radius: 16px;
            border-left: 4px solid #667eea;
            transition: all 0.3s ease;
        }

        .review-card:hover {
            transform: translateX(5px);
            background: #f1f3f5;
        }

        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.75rem;
            flex-wrap: wrap;
            gap: 0.5rem;
        }

        .reviewer-name {
            font-weight: 700;
            color: #1a1a2e;
        }

        .rating {
            color: #fbbf24;
            font-weight: 600;
        }

        .review-comment {
            color: #4a5568;
            margin: 0.75rem 0;
            line-height: 1.6;
        }

        .review-date {
            font-size: 0.75rem;
            color: #a0aec0;
        }

        /* Empty States */
        .empty-state {
            text-align: center;
            padding: 3rem;
            background: white;
            border-radius: 20px;
            color: #a0aec0;
        }

        /* Footer */
        .footer {
            background: #1a1a2e;
            color: white;
            text-align: center;
            padding: 2rem;
            margin-top: 3rem;
        }

        /* Buttons */
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 0.6rem 1.5rem;
            border-radius: 50px;
            text-decoration: none;
            font-weight: 600;
            transition: opacity 0.3s;
        }

        .btn-primary:hover {
            opacity: 0.9;
        }

        @media (max-width: 768px) {
            .nav-container {
                flex-direction: column;
                text-align: center;
            }
            .hero h1 {
                font-size: 1.8rem;
            }
            .container {
                padding: 0 1rem;
            }
            .product-grid {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>
<body>

<!-- Modern Navbar -->
<nav class="navbar">
    <div class="nav-container">
        <div class="logo">🛍️ Cartella</div>
        <div class="nav-links">
            <c:choose>
                <c:when test="${not empty sessionScope.loggedUser}">
                    <span class="user-greeting">👋 Hi, ${sessionScope.loggedUser.username}</span>
                    <a href="${pageContext.request.contextPath}/signout">Sign Out</a>
                    <a href="${pageContext.request.contextPath}/delete-account-page">Delete Account</a>
                </c:when>
                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/signin" class="btn-outline">Sign In</a>
                    <a href="${pageContext.request.contextPath}/signup" class="btn-primary">Sign Up Free</a>
                </c:otherwise>
            </c:choose>
            <a href="${pageContext.request.contextPath}/products">All Products →</a>
        </div>
    </div>
</nav>

<main class="container">
    <!-- Hero Section -->
    <div class="hero">
        <h1>✨ Premium Products, Best Prices</h1>
        <p>Discover amazing deals on thousands of products with fast shipping & secure payment</p>
    </div>

    <!-- Products Section -->
    <div class="section-header">
        <h2>🔥 Featured Products</h2>
        <a href="${pageContext.request.contextPath}/products">View All →</a>
    </div>

    <c:choose>
        <c:when test="${empty products}">
            <div class="empty-state">
                <div style="font-size: 3rem; margin-bottom: 1rem;">📦</div>
                <p>No products available at the moment. Check back soon!</p>
            </div>
        </c:when>
        <c:otherwise>
            <div class="product-grid">
                <c:forEach var="product" items="${products}">
                    <div class="product-card">
                        <div class="product-image">
                            🎁
                        </div>
                        <div class="product-info">
                            <h3>${product.name}</h3>
                            <c:if test="${not empty product.productDetails}">
                                <div class="price">$${product.productDetails.price}</div>
                                <c:choose>
                                    <c:when test="${product.productDetails.available}">
                                        <div class="badge badge-success">✓ In Stock</div>
                                    </c:when>
                                    <c:otherwise>
                                        <div class="badge badge-danger">✗ Out of Stock</div>
                                    </c:otherwise>
                                </c:choose>
                            </c:if>
                            <a href="${pageContext.request.contextPath}/products/view/${product.id}" class="btn-link">View Details →</a>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </c:otherwise>
    </c:choose>

    <!-- Reviews Section -->
    <div class="reviews-section">
        <div class="section-header">
            <h2>⭐ Customer Reviews</h2>
            <c:if test="${not empty sessionScope.loggedUser}">
                <a href="#" class="btn-primary" style="font-size: 0.9rem;">+ Write a Review</a>
            </c:if>
        </div>

        <c:choose>
            <c:when test="${empty reviews}">
                <div class="empty-state">
                    <div style="font-size: 3rem; margin-bottom: 1rem;">💬</div>
                    <p>No reviews yet. Be the first to share your experience!</p>
                </div>
            </c:when>
            <c:otherwise>
                <div class="reviews-grid">
                    <c:forEach var="review" items="${reviews}">
                        <div class="review-card">
                            <div class="review-header">
                                <span class="reviewer-name">
                                    <c:choose>
                                        <c:when test="${not empty review.user}">
                                            ${review.user.username}
                                        </c:when>
                                        <c:otherwise>
                                            Anonymous User
                                        </c:otherwise>
                                    </c:choose>
                                </span>
                                <span class="rating">★ ${review.rating}/5</span>
                            </div>
                            <div class="review-comment">"${review.comment}"</div>
                            <div class="review-date">📅 ${review.createdAt}</div>
                        </div>
                    </c:forEach>
                </div>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<footer class="footer">
    <p>© 2025 Cartella — Premium Shopping Experience. All rights reserved.</p>
    <p style="margin-top: 0.5rem; font-size: 0.8rem;">🚚 Free Shipping | 🔒 Secure Payments | 💯 30-Day Returns</p>
</footer>

</body>
</html>