<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dashboard - Pahana Edu Bookshop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>
<div class="container">
    <h2 class="mt-5">Pahana Edu Bookshop Dashboard</h2>
    <% if (session.getAttribute("username") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    } %>
    <div class="mt-4">
        <a href="addCustomer.jsp" class="btn btn-primary m-2">Add New Customer</a>
        <a href="viewCustomers.jsp" class="btn btn-primary m-2">View Customers</a>
        <a href="manageItems.jsp" class="btn btn-primary m-2">Manage Items</a>
        <a href="addPurchase.jsp" class="btn btn-primary m-2">Add Purchase</a>
        <a href="generateBill.jsp" class="btn btn-primary m-2">Generate Bill</a>
        <a href="help.jsp" class="btn btn-primary m-2">Help</a>
        <a href="login.jsp" class="btn btn-danger m-2">Exit</a>
    </div>
</div>
</body>
</html>