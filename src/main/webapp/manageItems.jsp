<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Item, servlet.ItemServlet, java.util.List" %>
<html>
<head>
    <title>Manage Items - Pahana Edu Bookshop</title>
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
    <h2>Manage Items</h2>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert"><%= request.getAttribute("error") %></div>
    <% } %>
    <h4>Add New Item</h4>
    <form action="${pageContext.request.contextPath}/item" method="post">
        <input type="hidden" name="action" value="add">
        <div class="form-group">
            <label for="itemId" class="form-label">Item ID</label>
            <input type="text" class="form-input" id="itemId" name="itemId" required>
        </div>
        <div class="form-group">
            <label for="name" class="form-label">Name</label>
            <input type="text" class="form-input" id="name" name="name" required>
        </div>
        <div class="form-group">
            <label for="price" class="form-label">Price (LKR)</label>
            <input type="number" class="form-input" id="price" name="price" required min="0" step="0.01">
        </div>
        <button type="submit" class="btn btn-primary">Add Item</button>
    </form>

    <h4>Item List</h4>
    <table class="table">
        <thead>
        <tr>
            <th>Item ID</th>
            <th>Name</th>
            <th>Price (LKR)</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            List<Item> items = ItemServlet.getAllItems();
            for (Item item : items) {
        %>
        <tr>
            <td><%= item.getItemId() %></td>
            <td><%= item.getName() %></td>
            <td><%= item.getPrice() %></td>
            <td>
                <form action="${pageContext.request.contextPath}/item" method="post" class="inline-form">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                    <input type="text" class="form-input" name="name" value="<%= item.getName() %>" required>
                    <input type="number" class="form-input" name="price" value="<%= item.getPrice() %>" required min="0" step="0.01">
                    <button type="submit" class="btn btn-sm btn-primary">Update</button>
                </form>
                <form action="${pageContext.request.contextPath}/item" method="post" class="inline-form">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
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