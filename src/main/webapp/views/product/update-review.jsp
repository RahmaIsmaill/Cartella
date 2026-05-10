<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.model.Review" %>
<html>
<head>
  <title>Update Review</title>
  <style>
    body { font-family: Arial, sans-serif; background: #f5f5f5; margin: 0; }
    .navbar { background: #2c3e50; color: white; padding: 15px 30px; display: flex; justify-content: space-between; align-items: center; }
    .navbar a { color: white; text-decoration: none; margin-left: 15px; }
    .navbar a:hover { color: #3498db; }
    .container { max-width: 500px; margin: 40px auto; padding: 0 20px; }
    .card { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
    h2 { text-align: center; color: #2c3e50; }
    .error { color: #e74c3c; font-size: 14px; text-align: center; margin-bottom: 10px; }
    textarea { width: 100%; padding: 10px; margin: 8px 0; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; font-family: Arial; min-height: 100px; }
    select { width: 100%; padding: 10px; margin: 8px 0; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
    button { width: 100%; padding: 10px; background: #3498db; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; }
    button:hover { background: #2980b9; }
    .back-link { display: inline-block; margin-bottom: 20px; color: #3498db; text-decoration: none; }
    .back-link:hover { text-decoration: underline; }
    .stars { color: #f39c12; font-size: 20px; }
  </style>
</head>
<body>
<%
  Review review = (Review) request.getAttribute("review");
  String productId = (String) request.getAttribute("productId");
%>
<div class="navbar">
  <div><strong>E-Commerce</strong></div>
  <div>
    <a href="${pageContext.request.contextPath}/home">Home</a>
    <a href="${pageContext.request.contextPath}/logout">Logout</a>
  </div>
</div>

<div class="container">
  <a class="back-link" href="${pageContext.request.contextPath}/product?id=<%= productId %>">&larr; Back to Product</a>

  <div class="card">
    <h2>Update Your Review</h2>

    <p class="error">${requestScope.error}</p>

    <form action="${pageContext.request.contextPath}/update-review" method="post">
      <input type="hidden" name="reviewId" value="<%= review.getId() %>">
      <input type="hidden" name="productId" value="<%= productId %>">

      <label for="rating">Rating:</label>
      <select name="rating" id="rating" required>
        <option value="5" <%= review.getRating() == 5 ? "selected" : "" %>>5 - Excellent</option>
        <option value="4" <%= review.getRating() == 4 ? "selected" : "" %>>4 - Good</option>
        <option value="3" <%= review.getRating() == 3 ? "selected" : "" %>>3 - Average</option>
        <option value="2" <%= review.getRating() == 2 ? "selected" : "" %>>2 - Poor</option>
        <option value="1" <%= review.getRating() == 1 ? "selected" : "" %>>1 - Terrible</option>
      </select>

      <br><br>

      <label for="comment">Your Review:</label>
      <textarea name="comment" id="comment" placeholder="Write your review here..."><%= review.getComment() != null ? review.getComment() : "" %></textarea>

      <br><br>

      <button type="submit">Update Review</button>
    </form>
  </div>
</div>
</body>
</html>
