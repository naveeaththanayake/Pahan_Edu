<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Customer, model.Item, servlet.CustomerServlet, servlet.ItemServlet, java.util.List" %>
<html>
<head>
    <title>Add Purchase - Pahana Edu Bookshop</title>
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
    <h2 class="mt-5">Add Purchase</h2>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>
    <form action="<%= request.getContextPath() %>/purchase" method="post" class="mt-3">
        <div class="mb-3">
            <label for="accountNumber" class="form-label">Customer</label>
            <select class="form-control" id="accountNumber" name="accountNumber" required>
                <% for (Customer customer : CustomerServlet.getAllCustomers()) { %>
                <option value="<%= customer.getAccountNumber() %>"><%= customer.getName() %> (<%= customer.getAccountNumber() %>)</option>
                <% } %>
            </select>
        </div>
        <div class="mb-3">
            <label for="itemId" class="form-label">Item</label>
            <select class="form-control" id="itemId" name="itemId" required>
                <% for (Item item : ItemServlet.getAllItems()) { %>
                <option value="<%= item.getItemId() %>"><%= item.getName() %> (LKR <%= item.getPrice() %>)</option>
                <% } %>
            </select>
        </div>
        <div class="mb-3">
            <label for="quantity" class="form-label">Quantity Purchased</label>
            <input type="number" class="form-control" id="quantity" name="quantity" required min="1">
        </div>
        <button type="submit" class="btn btn-primary">Add Purchase</button>
        <a href="dashboard.jsp" class="btn btn-secondary">Back</a>
    </form>
</div>
</body>
</html>