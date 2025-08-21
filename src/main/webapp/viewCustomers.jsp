<<<<<<< Updated upstream
<<<<<<< HEAD
=======
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Customer, servlet.CustomerServlet, java.util.List" %>
=======
<<<<<<< Updated upstream
>>>>>>> 364f54e723446adc100a91643b59d04f8bfae46f
=======
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Customer, servlet.CustomerServlet, java.util.List" %>

<<<<<<< HEAD
=======
>>>>>>> Stashed changes
>>>>>>> 364f54e723446adc100a91643b59d04f8bfae46f
<html>
<head>
    <title>View Customers - Pahana Edu Bookshop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>
<<<<<<< HEAD
<h1>PAHANA EDU BOOKSHOP</h1>

=======
<<<<<<< Updated upstream

<br>
<h1>PAHANA EDU BOOKSHOP</h1>
=======
<h1>PAHANA EDU BOOKSHOP</h1>

>>>>>>> Stashed changes
>>>>>>> 364f54e723446adc100a91643b59d04f8bfae46f
<div class="nav">
    <ul>
        <li><a href="addCustomer.jsp">Add New Customer</a></li>
        <li><a href="viewCustomers.jsp">View Customers</a></li>
        <li><a href="manageItems.jsp">Manage Items</a></li>
        <li><a href="addPurchase.jsp">Add Purchase</a></li>
<<<<<<< HEAD
        <li><a href="billHistory.jsp">Bill History</a></li>
        <li><a href="saleReport.jsp">Sale Report</a></li>
=======
<<<<<<< Updated upstream
        <li><a href="generateBill.jsp">Generate Bill</a></li>
=======
        <li><a href="billHistory.jsp">Bill History</a></li>
        <li><a href="saleReport.jsp">Sale Report</a></li>
>>>>>>> Stashed changes
>>>>>>> 364f54e723446adc100a91643b59d04f8bfae46f
        <li><a href="help.jsp">Help</a></li>
        <li><a href="login.jsp">Exit</a></li>
    </ul>
</div>
<<<<<<< HEAD
=======
<<<<<<< Updated upstream
<br></br>

<div class="main-container">
    <h2>Customer List</h2>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert"><%= request.getAttribute("error") %></div>
    <% } %>
=======
>>>>>>> 364f54e723446adc100a91643b59d04f8bfae46f
<br>

<div class="container">
    <h2>Customer List</h2>

<<<<<<< HEAD
=======
>>>>>>> Stashed changes
>>>>>>> 364f54e723446adc100a91643b59d04f8bfae46f
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
<<<<<<< HEAD
                <!-- Bill Button -->
                <a href="addPurchase.jsp?accountNumber=<%= customer.getAccountNumber() %>" class="btn btn-primary">Bill</a>

                <!-- Edit Button -->
                <a href="editCustomer.jsp?accountNumber=<%= customer.getAccountNumber() %>" class="btn btn-primary">Edit</a>

                <!-- Delete Button -->
=======
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


>>>>>>> 364f54e723446adc100a91643b59d04f8bfae46f
                <form method="post" action="<%= request.getContextPath() %>/customer" style="display:inline;"
                      onsubmit="return confirm('Are you sure you want to delete this customer?');">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="accountNumber" value="<%= customer.getAccountNumber() %>">
                    <button type="submit" class="btn btn-danger">Delete</button>
<<<<<<< HEAD
=======
>>>>>>> Stashed changes
>>>>>>> 364f54e723446adc100a91643b59d04f8bfae46f
                </form>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
<<<<<<< HEAD
=======
<<<<<<< Updated upstream
    <a href="dashboard.jsp" class="btn btn-secondary">Back</a>
</div>
</body>
</html>
=======
>>>>>>> 364f54e723446adc100a91643b59d04f8bfae46f

    <a href="addCustomer.jsp" class="btn btn-primary">Add New Customer</a>
    <a href="dashboard.jsp" class="btn btn-secondary">Back to Dashboard</a>
</div>
</body>
</html>
>>>>>>> Stashed changes
<<<<<<< HEAD
=======
>>>>>>> Stashed changes
>>>>>>> 364f54e723446adc100a91643b59d04f8bfae46f
