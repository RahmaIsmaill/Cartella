<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.model.Product" %>
<%@ page import="com.model.Review" %>
<%@ page import="com.model.User" %>
<%@ page import="java.util.List" %>
<html>
<head>
  <title>Product Details</title>
  <style>
    body { font-family: Arial, sans-serif; background: #f5f5f5; margin: 0; }
    .navbar { background: #2c3e50; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
    .navbar a { color: white; text-decoration: none; margin-left: 15px; }
    .navbar a:hover { color: #3498db; }
    .container { max-width: 900px; margin: 20px auto; padding: 0 20px; }
    .product-detail { background: white; border-radius: 8px; padding: 30px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); display: flex; gap: 30px; }
    .product-detail img { width: 400px; height: 300px; object-fit: cover; border-radius: 8px; }
    .product-detail .info { flex: 1; }
    .product-detail h1 { margin: 0 0 10px; color: #2c3e50; }
    .product-detail .price { color: #27ae60; font-size: 28px; font-weight: bold; }
    .product-detail .desc { color: #666; margin: 15px 0; line-height: 1.6; }
    .back-link { display: inline-block; margin-bottom: 20px; color: #3498db; text-decoration: none; }
    .back-link:hover { text-decoration: underline; }
    .reviews-section { margin-top: 30px; }
    .review-card { background: white; padding: 15px; border-radius: 8px; box-shadow: 0 1px 4px rgba(0,0,0,0.1); margin-bottom: 15px; }
    .review-card .header { display: flex; justify-content: space-between; align-items: center; }
    .review-card .username { font-weight: bold; color: #2c3e50; }
    .review-card .date { color: #999; font-size: 12px; }
    .review-card .stars { color: #f39c12; }
    .review-card .comment { color: #555; margin-top: 8px; }
    .add-review { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); margin-top: 20px; }
    .add-review h3 { margin-top: 0; }
    .add-review textarea { width: 100%; padding: 10px; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; min-height: 80px; font-family: Arial; }
    .add-review select, .add-review input { padding: 10px; border: 1px solid #ddd; border-radius: 4px; margin: 5px 0; }
    .add-review button { padding: 10px 20px; background: #3498db; color: white; border: none; border-radius: 4px; cursor: pointer; }
    .add-review button:hover { background: #2980b9; }
    .error { color: #e74c3c; }
    .no-reviews { color: #999; font-style: italic; }
    .review-actions { margin-top: 10px; }
    .review-actions a { display: inline-block; padding: 5px 10px; background: #3498db; color: white; text-decoration: none; border-radius: 4px; font-size: 12px; margin-right: 5px; }
    .review-actions a:hover { background: #2980b9; }
    .review-actions form { display: inline; }
    .review-actions button { padding: 5px 10px; background: #e74c3c; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 12px; }
    .review-actions button:hover { background: #c0392b; }
  </style>
</head>
<body>
<%
  Product product = (Product) request.getAttribute("product");
  List<Review> reviews = (List<Review>) request.getAttribute("reviews");
  User loggedInUser = (User) session.getAttribute("loggedInUser");
%>

<div class="navbar">
  <div><strong>E-Commerce</strong></div>
  <div>
    <a href="${pageContext.request.contextPath}/home">Home</a>
    <a href="${pageContext.request.contextPath}/logout">Logout</a>
  </div>
</div>

<div class="container">
  <a class="back-link" href="${pageContext.request.contextPath}/home">&larr; Back to Products</a>

  <div class="product-detail">
    <% if (product.getImageUrl() != null && !product.getImageUrl().isEmpty()) { %>
      <img src="<%= product.getImageUrl() %>" alt="<%= product.getName() %>">
    <% } else { %>
      <img src="https://via.placeholder.com/400x300?text=No+Image" alt="No image">
    <% } %>
    <div class="info">
      <h1><%= product.getName() %></h1>
      <p class="price">$<%= product.getPrice() %></p>
      <p class="desc"><%= product.getDescription() != null ? product.getDescription() : "No description available." %></p>
    </div>
  </div>

  <div class="reviews-section">
    <h2>Reviews</h2>

    <% if (reviews == null || reviews.isEmpty()) { %>
      <p class="no-reviews">No reviews yet. Be the first to review!</p>
    <% } else { %>
      <% for (Review r : reviews) { %>
        <div class="review-card">
          <div class="header">
            <span class="username"><%= r.getUsername() %></span>
            <span class="date"><%= r.getCreatedAt() != null ? r.getCreatedAt().toString() : "" %></span>
          </div>
          <div class="stars">
            <% for (int i = 1; i <= 5; i++) { %>
              <%= i <= r.getRating() ? "&#9733;" : "&#9734;" %>
            <% } %>
          </div>
          <p class="comment"><%= r.getComment() != null ? r.getComment() : "" %></p>

          <%-- Show edit/delete buttons only for the user's own reviews or admin --%>
          <% if (loggedInUser != null && (r.getUserId().equals(loggedInUser.getId()) || "ADMIN".equals(loggedInUser.getRole()))) { %>
            <div class="review-actions">
              <a href="${pageContext.request.contextPath}/update-review?id=<%= r.getId() %>&productId=<%= product.getId() %>">Edit</a>
              <form action="${pageContext.request.contextPath}/delete-review" method="post" onsubmit="return confirm('Are you sure you want to delete this review?');">
                <input type="hidden" name="id" value="<%= r.getId() %>">
                <button type="submit">Delete</button>
              </form>
            </div>
          <% } %>
        </div>
      <% } %>
    <% } %>

    <div class="add-review">
      <h3>Write a Review</h3>
      <p class="error">${requestScope.error}</p>

      <form action="${pageContext.request.contextPath}/add-review" method="post">
        <input type="hidden" name="productId" value="<%= product.getId() %>">

        <label>Rating:</label>
        <select name="rating" required>
          <option value="5">5 - Excellent</option>
          <option value="4">4 - Good</option>
          <option value="3">3 - Average</option>
          <option value="2">2 - Poor</option>
          <option value="1">1 - Terrible</option>
        </select>

        <br><br>

        <textarea name="comment" placeholder="Write your review here..."></textarea>

        <br><br>

        <button type="submit">Submit Review</button>
      </form>
    </div>
  </div>
</div>
</body>
</html>
