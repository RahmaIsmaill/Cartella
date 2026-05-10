<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<html>
<head>
  <title>Login</title>
  <style>
    body { font-family: Arial, sans-serif; background: #f5f5f5; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; }
    .card { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); width: 350px; }
    h2 { text-align: center; color: #333; }
    .error { color: #e74c3c; font-size: 14px; text-align: center; margin-bottom: 10px; }
    .success { color: #27ae60; font-size: 14px; text-align: center; margin-bottom: 10px; }
    input { width: 100%; padding: 10px; margin: 8px 0; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
    button { width: 100%; padding: 10px; background: #3498db; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; }
    button:hover { background: #2980b9; }
    .link { text-align: center; margin-top: 15px; }
    a { color: #3498db; text-decoration: none; }
    a:hover { text-decoration: underline; }
  </style>
</head>
<body>
<div class="card">
  <h2>Login</h2>

  <% List<String> errors = (List<String>) request.getAttribute("errors"); %>
  <% if (errors != null && !errors.isEmpty()) { %>
    <% for (String err : errors) { %>
      <p class="error"><%= err %></p>
    <% } %>
  <% } else { %>
    <p class="error">${requestScope.error}</p>
  <% } %>

  <% if ("true".equals(request.getParameter("deleted"))) { %>
    <p class="success">Your account has been deleted successfully.</p>
  <% } %>

  <form action="${pageContext.request.contextPath}/login" method="post">
    <input type="email" name="email" placeholder="Email" required>
    <input type="password" name="password" placeholder="Password" required>
    <button type="submit">Login</button>
  </form>

  <div class="link">
    Don't have an account? <a href="${pageContext.request.contextPath}/views/auth/register.jsp">Register</a>
  </div>
</div>
</body>
</html>