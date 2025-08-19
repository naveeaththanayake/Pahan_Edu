<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Customer, java.util.List" %>
<html>
<head>
    <title>Generate Bill - Pahana Edu Bookshop</title>
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
    <h2 class="mt-5">Generate Bill</h2>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>
    <form action="<%= request.getContextPath() %>/bill" method="post" class="mt-3">
        <div class="mb-3">
            <label for="accountNumber" class="form-label">Account Number</label>
            <input type="text" class="form-control" id="accountNumber" name="accountNumber" required>
        </div>
        <button type="submit" class="btn btn-primary">Generate Bill</button>
    </form>

    <% if (request.getAttribute("customer") != null) { %>
    <h4 class="mt-5">Bill Details</h4>
    <%
        Customer customer = (Customer) request.getAttribute("customer");
        Double totalBill = (Double) request.getAttribute("totalBill");
        List<String> purchaseDetails = (List<String>) request.getAttribute("purchaseDetails");
    %>
    <table class="table table-bordered">
        <tr><th>Account Number</th><td><%= customer.getAccountNumber() %></td></tr>
        <tr><th>Name</th><td><%= customer.getName() %></td></tr>
        <tr><th>Address</th><td><%= customer.getAddress() %></td></tr>
        <tr><th>Phone</th><td><%= customer.getPhone() %></td></tr>
        <tr><th>Purchases</th><td>
            <% for (String detail : purchaseDetails) { %>
            <%= detail %><br>
            <% } %>
        </td></tr>
        <tr><th>Total Bill (LKR)</th><td><%= String.format("%.2f", totalBill) %></td></tr>
    </table>
    <% } %>
    <a href="dashboard.jsp" class="btn btn-secondary">Back</a>
</div>
</body>
</html>