<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<html>
<head>
  <title>Register</title>
  <style>
    body { font-family: Arial, sans-serif; background: #f5f5f5; display: flex; justify-content: center; align-items: center; min-height: 100vh; margin: 0; }
    .card { background: white; padding: 30px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); width: 350px; }
    h2 { text-align: center; color: #333; }
    .error { color: #e74c3c; font-size: 14px; text-align: center; margin-bottom: 10px; }
    input { width: 100%; padding: 10px; margin: 8px 0; border: 1px solid #ddd; border-radius: 4px; box-sizing: border-box; }
    button { width: 100%; padding: 10px; background: #27ae60; color: white; border: none; border-radius: 4px; cursor: pointer; font-size: 16px; }
    button:hover { background: #219a52; }
    .link { text-align: center; margin-top: 15px; }
    a { color: #3498db; text-decoration: none; }
    a:hover { text-decoration: underline; }
  </style>
</head>
<body>
<div class="card">
  <h2>Register</h2>

  <% List<String> errors = (List<String>) request.getAttribute("errors"); %>
  <% if (errors != null && !errors.isEmpty()) { %>
    <% for (String err : errors) { %>
      <p class="error"><%= err %></p>
    <% } %>
  <% } else { %>
    <p class="error">${requestScope.error}</p>
  <% } %>

  <form action="${pageContext.request.contextPath}/register" method="post">
    <input type="text" name="username" placeholder="Username (min 3 chars)" required>
    <input type="email" name="email" placeholder="Email" required>
    <input type="password" name="password" placeholder="Password (min 6 chars)" required>
    <button type="submit">Register</button>
  </form>

  <div class="link">
    Already have an account? <a href="${pageContext.request.contextPath}/views/auth/login.jsp">Login</a>
  </div>
</div>
</body>
</html>