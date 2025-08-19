<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
    <title>Login - Pahana Edu Bookshop</title>

</head>
<body>
<div class="main-container">
    <h2 class="mt-5">Pahana Edu Bookshop </h2>
    <h3>Login</h3>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert"><%= request.getAttribute("error") %></div>
    <% } %>
    <form action="<%= request.getContextPath() %>/login" method="post">
        <div class="form-group">
            <label for="username" class="form-label">Username</label>
            <input type="text" class="form-input" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-input" id="password" name="password" required>
        </div>
        <button type="submit" class="btn btn-primary">Login</button>
    </form>
</div>
</body>
</html>