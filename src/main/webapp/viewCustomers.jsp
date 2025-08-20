<<<<<<< Updated upstream
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Customer, servlet.CustomerServlet, java.util.List" %>
=======
<<<<<<< Updated upstream
=======
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Customer, servlet.CustomerServlet, java.util.List" %>

>>>>>>> Stashed changes
<html>
<head>
    <title>View Customers - Pahana Edu Bookshop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>
<<<<<<< Updated upstream

<br>
<h1>PAHANA EDU BOOKSHOP</h1>
=======
<h1>PAHANA EDU BOOKSHOP</h1>

>>>>>>> Stashed changes
<div class="nav">
    <ul>
        <li><a href="addCustomer.jsp">Add New Customer</a></li>
        <li><a href="viewCustomers.jsp">View Customers</a></li>
        <li><a href="manageItems.jsp">Manage Items</a></li>
        <li><a href="addPurchase.jsp">Add Purchase</a></li>
<<<<<<< Updated upstream
        <li><a href="generateBill.jsp">Generate Bill</a></li>
=======
        <li><a href="billHistory.jsp">Bill History</a></li>
        <li><a href="saleReport.jsp">Sale Report</a></li>
>>>>>>> Stashed changes
        <li><a href="help.jsp">Help</a></li>
        <li><a href="login.jsp">Exit</a></li>
    </ul>
</div>
<<<<<<< Updated upstream
<br></br>

<div class="main-container">
    <h2>Customer List</h2>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert"><%= request.getAttribute("error") %></div>
    <% } %>
=======
<br>

<div class="container">
    <h2>Customer List</h2>

>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
                <a href="editCustomer.jsp?accountNumber=<%= customer.getAccountNumber() %>" class="btn btn-sm btn-primary">Edit</a>
                <form action="${pageContext.request.contextPath}/customer" method="post" class="inline-form">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="accountNumber" value="<%= customer.getAccountNumber() %>">

                    <!-- FIXED: use scriptlet instead of EL -->
                    <a href="addPurchase.jsp?accountNumber=<%= customer.getAccountNumber() %>" class="btn btn-primary">Bill</a>

                    <button type="submit" class="btn btn-sm btn-danger">Delete</button>
=======

                <a href="addPurchase.jsp?accountNumber=<%= customer.getAccountNumber() %>" class="btn btn-primary">Bill</a>


                <a href="editCustomer.jsp?accountNumber=<%= customer.getAccountNumber() %>" class="btn btn-primary">Edit</a>


                <form method="post" action="<%= request.getContextPath() %>/customer" style="display:inline;"
                      onsubmit="return confirm('Are you sure you want to delete this customer?');">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="accountNumber" value="<%= customer.getAccountNumber() %>">
                    <button type="submit" class="btn btn-danger">Delete</button>
>>>>>>> Stashed changes
                </form>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
<<<<<<< Updated upstream
    <a href="dashboard.jsp" class="btn btn-secondary">Back</a>
</div>
</body>
</html>
=======

    <a href="addCustomer.jsp" class="btn btn-primary">Add New Customer</a>
    <a href="dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
</div>
</body>
</html>
>>>>>>> Stashed changes
>>>>>>> Stashed changes
