<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.model.Product" %>
<html>
<head>
  <title>Update Product</title>
  <style>
    body { font-family: Arial, sans-serif; background: #f5f5f5; margin: 0; }
    .navbar { background: #2c3e50; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
    .navbar a { color: white; text-decoration: none; margin-left: 15px; }
    .navbar a:hover { color: #3498db; }
    .container { max-width: 500px; margin: 40px auto; padding: 0 20px; }
    .card { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
    h2 { text-align: center; color: #2c3e50; }
    .error { color: #e74c3c; font-size: 14px; text-align: center; margin-bottom: 10px; }
    input, textarea { width: 100%; padding: 10px; margin: 8px 0; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; font-family: Arial; }
    textarea { min-height: 100px; }
    button { width: 100%; padding: 10px; background: #3498db; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; }
    button:hover { background: #2980b9; }
    .back-link { display: inline-block; margin-bottom: 20px; color: #3498db; text-decoration: none; }
    .back-link:hover { text-decoration: underline; }
  </style>
</head>
<body>
<%
  Product product = (Product) request.getAttribute("product");
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

  <div class="card">
    <h2>Update Product</h2>

    <p class="error">${requestScope.error}</p>

    <form action="${pageContext.request.contextPath}/update-product" method="post">
      <input type="hidden" name="id" value="<%= product.getId() %>">

      <input type="text" name="name" value="<%= product.getName() %>" placeholder="Product Name" required>
      <textarea name="description" placeholder="Product Description"><%= product.getDescription() != null ? product.getDescription() : "" %></textarea>
      <input type="number" name="price" step="0.01" min="0.01" value="<%= product.getPrice() %>" placeholder="Price ($)" required>
      <input type="url" name="imageUrl" value="<%= product.getImageUrl() != null ? product.getImageUrl() : "" %>" placeholder="Image URL (optional)">

      <button type="submit">Update Product</button>
    </form>
  </div>
</div>
</body>
</html>
