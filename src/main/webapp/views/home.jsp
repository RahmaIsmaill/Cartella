<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.model.Product" %>
<%@ page import="com.model.User" %>
<%@ page import="java.util.List" %>
<html>
<head>
  <title>Home - E-Commerce</title>
  <style>
    body { font-family: Arial, sans-serif; background: #f5f5f5; margin: 0; }
    .navbar { background: #2c3e50; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
    .navbar a { color: white; text-decoration: none; margin-left: 15px; }
    .navbar a:hover { color: #3498db; }
    .navbar .user-info { font-size: 14px; }
    .container { max-width: 1200px; margin: 20px auto; padding: 0 20px; }
    .products-grid { display: grid; grid-template-columns: repeat(auto-fill, minmax(280px, 1fr)); gap: 20px; }
    .product-card { background: white; border-radius: 8px; overflow: hidden; box-shadow: 0 2px 8px rgba(0,0,0,0.1); transition: transform 0.2s; }
    .product-card:hover { transform: translateY(-3px); }
    .product-card img { width: 100%; height: 200px; object-fit: cover; }
    .product-card .info { padding: 15px; }
    .product-card h3 { margin: 0 0 8px; color: #333; }
    .product-card .price { color: #27ae60; font-size: 20px; font-weight: bold; }
    .product-card .desc { color: #666; font-size: 14px; margin: 8px 0; }
    .product-card a { display: inline-block; padding: 8px 16px; background: #3498db; color: white; text-decoration: none; border-radius: 4px; font-size: 14px; }
    .product-card a:hover { background: #2980b9; }
    .admin-actions { margin-bottom: 20px; }
    .admin-actions a { display: inline-block; padding: 10px 20px; background: #e67e22; color: white; text-decoration: none; border-radius: 4px; }
    .admin-actions a:hover { background: #d35400; }
    .delete-form { display: inline; }
    .delete-form button { background: #e74c3c; color: white; border: none; padding: 6px 12px; border-radius: 4px; cursor: pointer; font-size: 12px; }
    .delete-form button:hover { background: #c0392b; }
    .edit-link { display: inline-block; padding: 6px 12px; background: #3498db; color: white; text-decoration: none; border-radius: 4px; font-size: 12px; margin-right: 5px; }
    .edit-link:hover { background: #2980b9; }
    .error { color: #e74c3c; text-align: center; }
    .empty { text-align: center; color: #999; padding: 40px; }
    h1 { color: #2c3e50; }
    .badge { background: #e67e22; color: white; padding: 2px 8px; border-radius: 10px; font-size: 12px; }
  </style>
</head>
<body>
<%
  User loggedInUser = (User) session.getAttribute("loggedInUser");
  List<Product> products = (List<Product>) request.getAttribute("products");
%>

<div class="navbar">
  <div>
    <strong>E-Commerce</strong>
  </div>
  <div class="user-info">
    Welcome, <%= loggedInUser.getUsername() %>
    <% if ("ADMIN".equals(loggedInUser.getRole())) { %>
      <span class="badge">Admin</span>
    <% } %>
    |
    <a href="${pageContext.request.contextPath}/logout">Logout</a>
  </div>
</div>

<div class="container">
  <h1>Products</h1>

  <p class="error">${requestScope.error}</p>

  <% if ("ADMIN".equals(loggedInUser.getRole())) { %>
    <div class="admin-actions">
      <a href="${pageContext.request.contextPath}/add-product">+ Add New Product</a>
    </div>
  <% } %>

  <% if (products == null || products.isEmpty()) { %>
    <p class="empty">No products available yet.</p>
  <% } else { %>
    <div class="products-grid">
      <% for (Product p : products) { %>
        <div class="product-card">
          <% if (p.getImageUrl() != null && !p.getImageUrl().isEmpty()) { %>
            <img src="<%= p.getImageUrl() %>" alt="<%= p.getName() %>">
          <% } else { %>
            <img src="https://via.placeholder.com/280x200?text=No+Image" alt="No image">
          <% } %>
          <div class="info">
            <h3><%= p.getName() %></h3>
            <p class="price">$<%= p.getPrice() %></p>
            <p class="desc"><%= p.getDescription() != null ? p.getDescription() : "" %></p>
            <a href="${pageContext.request.contextPath}/product?id=<%= p.getId() %>">View Details</a>

            <% if ("ADMIN".equals(loggedInUser.getRole())) { %>
              <a class="edit-link" href="${pageContext.request.contextPath}/update-product?id=<%= p.getId() %>">Edit</a>
              <form class="delete-form" action="${pageContext.request.contextPath}/delete-product" method="post" onsubmit="return confirm('Are you sure you want to delete this product?');">
                <input type="hidden" name="id" value="<%= p.getId() %>">
                <button type="submit">Delete</button>
              </form>
            <% } %>
          </div>
        </div>
      <% } %>
    </div>
  <% } %>

  <hr style="margin: 40px 0; border: none; border-top: 1px solid #ddd;">

  <div style="text-align: center;">
    <form action="${pageContext.request.contextPath}/delete-account" method="post" onsubmit="return confirm('Are you sure you want to delete your account? This cannot be undone.');">
      <button type="submit" style="background: #e74c3c; color: white; border: none; padding: 8px 16px; border-radius: 4px; cursor: pointer;">Delete My Account</button>
    </form>
  </div>
</div>
</body>
</html>