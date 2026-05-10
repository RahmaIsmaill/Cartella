<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Error ${requestScope.errorCode}</title>
  <style>
    body { font-family: Arial, sans-serif; text-align: center; padding: 50px; }
    .error-container { max-width: 500px; margin: auto; }
    h1 { color: #e74c3c; }
    a { color: #3498db; text-decoration: none; }
    a:hover { text-decoration: underline; }
  </style>
</head>
<body>
<div class="error-container">
  <h1>Error ${requestScope.errorCode}</h1>
  <p>${requestScope.errorMessage}</p>
  <a href="${pageContext.request.contextPath}/home">Go Back Home</a>
</div>
</body>
</html>
