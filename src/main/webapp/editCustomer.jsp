<<<<<<< Updated upstream
=======
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Customer, servlet.CustomerServlet" %>

<%
    String accountNumber = request.getParameter("accountNumber");
    Customer customer = CustomerServlet.getCustomerById(accountNumber);
%>

<html>
<head>
    <title>Edit Customer - Pahana Edu Bookshop</title>
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
        <li><a href="billHistory.jsp">Bill History</a></li>
        <li><a href="saleReport.jsp">Sale Report</a></li>
        <li><a href="help.jsp">Help</a></li>
        <li><a href="login.jsp">Exit</a></li>
    </ul>
</div>
<br>

<div class="container">
    <h2>Edit Customer</h2>

    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>

    <form action="<%= request.getContextPath() %>/customer" method="post" class="f">
        <input type="hidden" name="action" value="update">
        <input type="hidden" name="accountNumber" value="<%= customer.getAccountNumber() %>">

        <div class="mb-3">
            <label for="accountNumberDisplay" class="form-label">Account Number</label>
            <input type="text" class="form-control" id="accountNumberDisplay" value="<%= customer.getAccountNumber() %>" disabled>
        </div>

        <div class="mb-3">
            <label for="name" class="form-label">Name</label>
            <input type="text" class="form-control" id="name" name="name" value="<%= customer.getName() %>" required>
        </div>

        <div class="mb-3">
            <label for="address" class="form-label">Address</label>
            <input type="text" class="form-control" id="address" name="address" value="<%= customer.getAddress() %>" required>
        </div>

        <div class="mb-3">
            <label for="phone" class="form-label">Phone</label>
            <input type="text" class="form-control" id="phone" name="phone" value="<%= customer.getPhone() %>" required pattern="[0-9]{10}">
        </div>

        <button type="submit" class="btn btn-primary">Update Customer</button>
        <a href="viewCustomers.jsp" class="btn btn-secondary">Cancel</a>
    </form>
</div>
</body>
</html>
>>>>>>> Stashed changes
