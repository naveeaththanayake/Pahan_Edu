<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dashboard - Pahana Edu Bookshop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>
<<<<<<< HEAD
<h1 >PAHANA EDU BOOKSHOP</h1>
<div class="container">

=======
<div class="container">
    <h2 class="mt-5">Pahana Edu Bookshop Dashboard</h2>
>>>>>>> 1663456386a8ff69af37a533a86f5a231db12e4d
    <% if (session.getAttribute("username") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    } %>
<<<<<<< HEAD
    <br>

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
    <div class="mt-4">
        <a href="addCustomer.jsp" class="btn btn-primary m-2">Add New Customer</a>
        <a href="viewCustomers.jsp" class="btn btn-primary m-2">View Customers</a>
        <a href="manageItems.jsp" class="btn btn-primary m-2">Manage Items</a>
        <a href="addPurchase.jsp" class="btn btn-primary m-2">Add Purchase</a>
        <a href="generateBill.jsp" class="btn btn-primary m-2">Generate Bill</a>
        <a href="help.jsp" class="btn btn-primary m-2">Help</a>
        <a href="login.jsp" class="btn btn-danger m-2">Exit</a>
    </div>
>>>>>>> 1663456386a8ff69af37a533a86f5a231db12e4d
</div>
</body>
</html>