<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cartella - ${product.name}</title>
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
            text-decoration: none;
            color: #4a5568;
            font-weight: 500;
            transition: all 0.3s ease;
        }

        .nav-links a:hover {
            color: #667eea;
        }

        .container {
            max-width: 1280px;
            margin: 2rem auto;
            padding: 0 2rem;
        }

        .product-container {
            display: grid;
            grid-template-columns: 1fr 400px;
            gap: 2rem;
            margin-bottom: 3rem;
        }

        .product-info {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .product-title {
            font-size: 2rem;
            font-weight: 800;
            color: #1a1a2e;
            margin-bottom: 1rem;
        }

        .product-price {
            font-size: 2.5rem;
            font-weight: 900;
            color: #667eea;
            margin: 1rem 0;
        }

        .product-availability {
            display: inline-block;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            font-weight: 600;
            margin: 1rem 0;
        }

        .available {
            background: #48bb78;
            color: white;
        }

        .not-available {
            background: #f56565;
            color: white;
        }

        .product-details {
            margin: 1.5rem 0;
            color: #4a5568;
            line-height: 1.6;
        }

        .product-image {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
            text-align: center;
            font-size: 8rem;
        }

        .actions {
            display: flex;
            gap: 1rem;
            margin-top: 2rem;
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

        .btn-danger {
            background: #f56565;
            color: white;
        }

        .btn-danger:hover {
            background: #e53e3e;
        }

        .reviews-section {
            background: white;
            border-radius: 20px;
            padding: 2rem;
            box-shadow: 0 10px 30px rgba(0,0,0,0.1);
        }

        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 2rem;
        }

        .section-header h2 {
            font-size: 1.5rem;
            color: #1a1a2e;
        }

        .review-form {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 1.5rem;
            margin-bottom: 2rem;
        }

        .form-group {
            margin-bottom: 1rem;
        }

        .form-group label {
            display: block;
            margin-bottom: 0.5rem;
            font-weight: 600;
            color: #2d3748;
        }

        .form-group input,
        .form-group textarea {
            width: 100%;
            padding: 0.75rem;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            transition: border-color 0.3s ease;
        }

        .form-group input:focus,
        .form-group textarea:focus {
            outline: none;
            border-color: #667eea;
        }

        .form-group textarea {
            resize: vertical;
            min-height: 100px;
        }

        .rating-select {
            display: flex;
            gap: 0.5rem;
            align-items: center;
        }

        .star {
            font-size: 1.5rem;
            color: #e2e8f0;
            cursor: pointer;
            transition: color 0.3s ease;
        }

        .star:hover,
        .star.selected {
            color: #fbbf24;
        }

        .reviews-list {
            display: grid;
            gap: 1rem;
        }

        .review-card {
            background: #f8f9fa;
            border-radius: 15px;
            padding: 1.5rem;
            border-left: 4px solid #667eea;
        }

        .review-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 0.75rem;
        }

        .reviewer-name {
            font-weight: 700;
            color: #1a1a2e;
        }

        .review-rating {
            color: #fbbf24;
            font-weight: 600;
        }

        .review-comment {
            color: #4a5568;
            margin: 0.75rem 0;
            line-height: 1.6;
        }

        .review-date {
            font-size: 0.875rem;
            color: #a0aec0;
        }

        .empty-state {
            text-align: center;
            padding: 2rem;
            color: #a0aec0;
        }

        @media (max-width: 768px) {
            .product-container {
                grid-template-columns: 1fr;
            }
            
            .actions {
                flex-direction: column;
            }
            
            .container {
                padding: 0 1rem;
            }
        }
    </style>
</head>
<body>
<nav class="navbar">
    <div class="nav-container">
        <div class="logo">🛍️ Cartella</div>
        <div class="nav-links">
            <a href="${pageContext.request.contextPath}/">← Back to Products</a>
            <c:if test="${not empty sessionScope.loggedUser}">
                <span>👋 ${sessionScope.loggedUser.username}</span>
            </c:if>
        </div>
    </div>
</nav>

<div class="container">
    <div class="product-container">
        <div class="product-info">
            <h1 class="product-title">${product.name}</h1>
            
            <c:if test="${not empty product.productDetails}">
                <div class="product-price">$${product.productDetails.price}</div>
                
                <c:choose>
                    <c:when test="${product.productDetails.available}">
                        <span class="product-availability available">✓ In Stock</span>
                    </c:when>
                    <c:otherwise>
                        <span class="product-availability not-available">✗ Out of Stock</span>
                    </c:otherwise>
                </c:choose>
                
                <div class="product-details">
                    <p><strong>Product Name:</strong> ${product.productDetails.name}</p>
                    <p><strong>Expiration Date:</strong> 
                        <fmt:formatDate value="${product.productDetails.expiration_date}" pattern="yyyy-MM-dd"/>
                    </p>
                </div>
            </c:if>
            
            <div class="actions">
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">← Back to Products</a>
                <c:if test="${not empty sessionScope.loggedUser and sessionScope.loggedUser.role == 'ADMIN'}">
                    <form action="${pageContext.request.contextPath}/admin/products/delete" method="post" style="display: inline;">
                        <input type="hidden" name="id" value="${product.id}">
                        <button type="submit" class="btn btn-danger" onclick="return confirm('Are you sure you want to delete this product?')">
                            🗑️ Delete Product
                        </button>
                    </form>
                </c:if>
            </div>
        </div>
        
        <div class="product-image">
            🎁
        </div>
    </div>

    <div class="reviews-section">
        <div class="section-header">
            <h2>⭐ Customer Reviews</h2>
            <c:if test="${not empty sessionScope.loggedUser}">
                <span>${reviews.size()} reviews</span>
            </c:if>
        </div>

        <c:if test="${not empty sessionScope.loggedUser}">
            <div class="review-form">
                <h3>Write a Review</h3>
                <form action="${pageContext.request.contextPath}/products/view/${product.id}" method="post">
                    <div class="form-group">
                        <label for="rating">Rating</label>
                        <div class="rating-select">
                            <c:forEach begin="1" end="5" var="i">
                                <span class="star" data-rating="${i}">★</span>
                            </c:forEach>
                            <input type="hidden" id="rating" name="rating" value="5">
                        </div>
                    </div>
                    
                    <div class="form-group">
                        <label for="comment">Your Review</label>
                        <textarea id="comment" name="comment" placeholder="Share your experience with this product..." required></textarea>
                    </div>
                    
                    <button type="submit" class="btn btn-primary">Submit Review</button>
                </form>
            </div>
        </c:if>

        <div class="reviews-list">
            <c:choose>
                <c:when test="${empty reviews}">
                    <div class="empty-state">
                        <div style="font-size: 3rem; margin-bottom: 1rem;">💬</div>
                        <p>No reviews yet. Be the first to share your experience!</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <c:forEach var="review" items="${reviews}">
                        <div class="review-card">
                            <div class="review-header">
                                <span class="reviewer-name">
                                    <c:if test="${not empty review.user}">
                                        ${review.user.username}
                                    </c:if>
                                    <c:if test="${empty review.user}">
                                        Anonymous User
                                    </c:if>
                                </span>
                                <span class="review-rating">
                                    ${'★'.repeat(review.rating)}${'☆'.repeat(5-review.rating)}
                                </span>
                            </div>
                            <div class="review-comment">"${review.comment}"</div>
                            <div class="review-date">
                                📅 <fmt:formatDate value="${review.createdAt}" pattern="yyyy-MM-dd HH:mm"/>
                            </div>
                        </div>
                    </c:forEach>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>

<script>
    // Rating stars interaction
    const stars = document.querySelectorAll('.star');
    const ratingInput = document.getElementById('rating');
    
    stars.forEach((star, index) => {
        star.addEventListener('click', () => {
            const rating = index + 1;
            ratingInput.value = rating;
            updateStars(rating);
        });
        
        star.addEventListener('mouseenter', () => {
            updateStars(index + 1);
        });
    });
    
    document.querySelector('.rating-select').addEventListener('mouseleave', () => {
        updateStars(parseInt(ratingInput.value));
    });
    
    function updateStars(rating) {
        stars.forEach((star, index) => {
            if (index < rating) {
                star.classList.add('selected');
            } else {
                star.classList.remove('selected');
            }
        });
    }
    
    // Initialize stars
    updateStars(parseInt(ratingInput.value) || 5);
</script>
</body>
</html>
