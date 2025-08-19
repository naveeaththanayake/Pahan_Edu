<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Customer, servlet.CustomerServlet, java.util.List" %>
<html>
<head>
    <title>View Customers - Pahana Edu Bookshop</title>
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

<div class="main-container">
    <h2>Customer List</h2>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert"><%= request.getAttribute("error") %></div>
    <% } %>
    <table class="table">
        <thead>
        <tr>
            <th>Account Number</th>
            <th>Name</th>
            <th>Address</th>
            <th>Phone</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Customer> customers = CustomerServlet.getAllCustomers();
            for (Customer customer : customers) {
        %>
        <tr>
            <td><%= customer.getAccountNumber() %></td>
            <td><%= customer.getName() %></td>
            <td><%= customer.getAddress() %></td>
            <td><%= customer.getPhone() %></td>
            <td>
                <a href="editCustomer.jsp?accountNumber=<%= customer.getAccountNumber() %>" class="btn btn-sm btn-primary">Edit</a>
                <form action="${pageContext.request.contextPath}/customer" method="post" class="inline-form">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="accountNumber" value="<%= customer.getAccountNumber() %>">
                    <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                </form>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
    <a href="dashboard.jsp" class="btn btn-secondary">Back</a>
</div>
</body>
</html>