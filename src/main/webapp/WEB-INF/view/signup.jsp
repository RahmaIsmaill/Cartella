<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>Sign Up</title>
    <style>
        body { font-family: Arial, sans-serif; max-width: 400px; margin: 60px auto; }
        input { width: 100%; padding: 8px; margin: 6px 0 14px; box-sizing: border-box; }
        button { width: 100%; padding: 10px; background: #333; color: white; border: none; cursor: pointer; }
        .error { color: red; }
    </style>
</head>
<body>
<h2>Create Account</h2>

<c:if test="${not empty error}">
    <p class="error">${error}</p>
</c:if>

<form action="${pageContext.request.contextPath}/signup" method="post">
    <label>Username:</label>
    <input type="text" name="username" required/>

    <label>Email:</label>
    <input type="email" name="email" required/>

    <label>Password:</label>
    <input type="password" name="password" required/>

    <button type="submit">Sign Up</button>
</form>

<p>Already have an account? <a href="${pageContext.request.contextPath}/signin">Sign In</a></p>
</body>
</html>