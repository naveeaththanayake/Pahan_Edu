
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Item, servlet.ItemServlet, java.util.List" %>
<html>
<head>
    <title>Manage Items - Pahana Edu Bookshop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>

<br>
<<<<<<< Updated upstream
<h1 >PAHANA EDU BOOKSHOP</h1>
<div class ="nav"><ul>
    <li><a href="addCustomer.jsp" >Add New Customer</a></li>
    <li><a href="viewCustomers.jsp" >View Customers</a></li>
    <li><a href="manageItems.jsp" >Manage Items</a></li>
    <li><a href="addPurchase.jsp" >Add Purchase</a></li>
    <li><a href="generateBill.jsp" >Generate Bill</a></li>
    <li><a href="help.jsp" >Help</a></li>
    <li><a href="login.jsp" >Exit</a></li>
</ul>
</div>
<br></br>
=======
<h1>PAHANA EDU BOOKSHOP</h1>
<div class="nav">
    <ul>
        <li><a href="addCustomer.jsp">Add New Customer</a></li>
        <li><a href="viewCustomers.jsp">View Customers</a></li>
        <li><a href="manageItems.jsp">Manage Items</a></li>
        <li><a href="addPurchase.jsp">Add Purchase</a></li>
        <li><a href="billHistory.jsp">Bill History</a></li>
        <li><a href="saleReport.jsp">Sale Report</a></li>
        <li><a href="help.jsp">Help</a></li>
        <li><a href="login.jsp">Exit</a></li>
    </ul>
</div>
<br>
>>>>>>> Stashed changes

<div class="main-container">
    <h2>Manage Items</h2>

<<<<<<< Updated upstream
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert"><%= request.getAttribute("error") %></div>
    <% } %>


    <% if (request.getAttribute("error") != null) { %>
    <div class="alert"><%= request.getAttribute("error") %></div>
    <% } %>


=======
    <%
        String loginType = (String) session.getAttribute("loginType");
        if ("user".equals(loginType)) {
    %>
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
        <div class="form-group">
            <label for="stock" class="form-label">Stock</label>
            <input type="number" class="form-input" id="stock" name="stock" required min="0" step="0">
        </div>
<<<<<<< Updated upstream

        <button type="submit" class="btn btn-primary">Add Item</button>
    </form>
=======
        <button type="submit" class="btn btn-primary">Add Item</button>
    </form>
    <% } %>
>>>>>>> Stashed changes

    <h4>Item List</h4>
    <table class="table">
        <thead>
        <tr>
            <th>Item ID</th>
            <th>Name</th>
            <th>Price (LKR)</th>
            <th>Stock</th>
<<<<<<< Updated upstream
            <th>Actions</th>
=======
            <% if ("user".equals(loginType)) { %>
            <th>Actions</th>
            <% } %>
>>>>>>> Stashed changes
        </tr>
        </thead>
        <tbody>
        <%
            List<Item> items = ItemServlet.getAllItems();
<<<<<<< Updated upstream

=======
>>>>>>> Stashed changes
            if (items != null) {
                for (Item item : items) {
        %>
        <tr>
            <td><%= item.getItemId() %></td>
            <td><%= item.getName() %></td>
            <td><%= item.getPrice() %></td>
            <td><%= item.getStock() %></td>
<<<<<<< Updated upstream
=======
            <% if ("user".equals(loginType)) { %>
>>>>>>> Stashed changes
            <td>
                <form action="${pageContext.request.contextPath}/item" method="post" class="inline-form">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                    <input type="text" class="form-input" name="name" value="<%= item.getName() %>" required>
                    <input type="number" class="form-input" name="price" value="<%= item.getPrice() %>" required min="0" step="0.01">
                    <input type="number" class="form-input" name="stock" value="<%= item.getStock() %>" required min="0" step="0">
                    <button type="submit" class="btn btn-sm btn-primary">Update</button>
                </form>
                <form action="${pageContext.request.contextPath}/item" method="post" class="inline-form">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="itemId" value="<%= item.getItemId() %>">
                    <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                </form>
            </td>
<<<<<<< Updated upstream
=======
            <% } %>
>>>>>>> Stashed changes
        </tr>
        <%
                }
            }
        %>
        </tbody>
    </table>

    <a href="dashboard.jsp" class="btn btn-secondary">Back</a>
</div>

<<<<<<< Updated upstream


=======
>>>>>>> Stashed changes
</body>
</html>

