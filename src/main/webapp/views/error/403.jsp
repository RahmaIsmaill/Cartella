<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>403 - Forbidden</title>
  <style>
    body { font-family: Arial, sans-serif; text-align: center; padding: 80px 20px; background: #f5f5f5; }
    .error-container { max-width: 500px; margin: auto; background: white; padding: 40px; border-radius: 8px; box-shadow: 0 2px 10px rgba(0,0,0,0.1); }
    h1 { color: #e74c3c; font-size: 48px; margin: 0; }
    h2 { color: #333; }
    p { color: #666; }
    a { color: #3498db; text-decoration: none; }
    a:hover { text-decoration: underline; }
  </style>
</head>
<body>
<div class="error-container">
  <h1>403</h1>
  <h2>Access Denied</h2>
  <p>You do not have permission to access this resource.</p>
  <a href="${pageContext.request.contextPath}/home">Go Back Home</a>
</div>
</body>
</html>
