<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Customer, model.Item, servlet.CustomerServlet, servlet.ItemServlet, java.util.List" %>
<html>
<head>
    <title>Add Purchase - Pahana Edu Bookshop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>

<br>
<h1>PAHANA EDU BOOKSHOP</h1>
<div class="nav">
    <ul>
        <li><a href="addCustomer.jsp">Add New Customer</a></li>
        <li><a href="viewCustomers.jsp">View Customers</a></li>
        <li><a href="manageItems.jsp">Manage Items</a></li>
        <li><a href="addPurchase.jsp">Add Purchase</a></li>
        <li><a href="generateBill.jsp">Generate Bill</a></li>
        <li><a href="help.jsp">Help</a></li>
        <li><a href="login.jsp">Exit</a></li>
    </ul>
</div>
<br></br>

<div class="container">
    <h2 class="mt-5">Add Purchase</h2>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>

    <%
        // Get the account number if passed from "Bill" button
        String selectedAccount = request.getParameter("accountNumber");
    %>

    <form action="<%= request.getContextPath() %>/purchase" method="post">
        <div>
            <label for="accountNumber" class="form-label">Customer</label>
            <select class="form-control" id="accountNumber" name="accountNumber" required>
                <option value="">-- Select Customer --</option>
                <% for (Customer customer : CustomerServlet.getAllCustomers()) {
                    String acc = customer.getAccountNumber();
                    String selected = (selectedAccount != null && selectedAccount.equals(acc)) ? "selected" : "";
                %>
                <option value="<%= acc %>" <%= selected %>>
                    <%= customer.getName() %> (<%= acc %>)
                </option>
                <% } %>
            </select>
        </div>

        <div>
            <label for="itemId" class="form-label">Item</label>
            <select class="form-control" id="itemId" name="itemId" required>
                <% for (Item item : ItemServlet.getAllItems()) { %>
                <option value="<%= item.getItemId() %>"><%= item.getName() %> (LKR <%= item.getPrice() %>)</option>
                <% } %>
            </select>
        </div>

        <div>
            <label for="quantity" class="form-label">Quantity Purchased</label>
            <input type="number" class="form-control" id="quantity" name="quantity" required min="1">
        </div>

        <button type="submit" class="btn btn-primary">Add Purchase</button>
        <a href="dashboard.jsp" class="btn btn-secondary">Back</a>
    </form>
</div>
</body>
</html>
