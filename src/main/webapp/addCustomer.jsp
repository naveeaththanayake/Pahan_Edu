<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Customer - Pahana Edu Bookshop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>

<div class="mt-4">
    <a href="addCustomer.jsp" class="btn btn-primary m-2">Add New Customer</a>
    <a href="viewCustomers.jsp" class="btn btn-primary m-2">View Customers</a>
    <a href="manageItems.jsp" class="btn btn-primary m-2">Manage Items</a>
    <a href="addPurchase.jsp" class="btn btn-primary m-2">Add Purchase</a>
    <a href="generateBill.jsp" class="btn btn-primary m-2">Generate Bill</a>
    <a href="help.jsp" class="btn btn-primary m-2">Help</a>
    <a href="login.jsp" class="btn btn-danger m-2">Exit</a>
</div>

<div class="container">
    <h2 class="mt-5">Add New Customer</h2>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>
    <form action="<%= request.getContextPath() %>/customer" method="post" class="mt-3">
        <input type="hidden" name="action" value="add">
        <div class="mb-3">
            <label for="accountNumber" class="form-label">Account Number</label>
            <input type="text" class="form-control" id="accountNumber" name="accountNumber" required>
        </div>
        <div class="mb-3">
            <label for="name" class="form-label">Name</label>
            <input type="text" class="form-control" id="name" name="name" required>
        </div>
        <div class="mb-3">
            <label for="address" class="form-label">Address</label>
            <input type="text" class="form-control" id="address" name="address" required>
        </div>
        <div class="mb-3">
            <label for="phone" class="form-label">Phone</label>
            <input type="text" class="form-control" id="phone" name="phone" required pattern="[0-9]{10}">
        </div>
        <button type="submit" class="btn btn-primary">Add Customer</button>
        <a href="dashboard.jsp" class="btn btn-secondary">Back</a>
    </form>
</div>
</body>
</html>