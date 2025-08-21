<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Dashboard - Pahana Edu Bookshop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>
<div class="container">
    <h1 >PAHANA EDU BOOKSHOP</h1>
    <% if (session.getAttribute("username") == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    } %>
<<<<<<< Updated upstream
<<<<<<< HEAD
=======
=======
>>>>>>> 364f54e723446adc100a91643b59d04f8bfae46f
    <div class="mt-4">
        <a href="addCustomer.jsp" class="btn btn-primary m-2">Add New Customer</a>
        <a href="viewCustomers.jsp" class="btn btn-primary m-2">View Customers</a>
        <a href="manageItems.jsp" class="btn btn-primary m-2">Manage Items</a>
        <a href="addPurchase.jsp" class="btn btn-primary m-2">Add Purchase</a>
        <a href="generateBill.jsp" class="btn btn-primary m-2">Generate Bill</a>
        <a href="help.jsp" class="btn btn-primary m-2">Help</a>
        <a href="login.jsp" class="btn btn-danger m-2">Exit</a>
<<<<<<< HEAD
=======
=======

>>>>>>> Stashed changes
>>>>>>> 364f54e723446adc100a91643b59d04f8bfae46f

    <div class ="nav"><ul>
        <li><a href="addCustomer.jsp" >Add New Customer</a></li>
        <li><a href="viewCustomers.jsp" >View Customers</a></li>
        <li><a href="manageItems.jsp" >Manage Items</a></li>
        <li><a href="addPurchase.jsp" >Add Purchase</a></li>
<<<<<<< HEAD
        <li><a href="billHistory.jsp" >Bill History</a></li>
        <li><a href="saleReport.jsp" >Sale Report</a></li>
        <li><a href="help.jsp" >Help</a></li>
        <li><a href="login.jsp" >Exit</a></li>
    </ul>
>>>>>>> Stashed changes
=======
<<<<<<< Updated upstream
        <li><a href="generateBill.jsp" >Generate Bill</a></li>
=======
        <li><a href="billHistory.jsp" >Bill History</a></li>
        <li><a href="saleReport.jsp" >Sale Report</a></li>
>>>>>>> Stashed changes
        <li><a href="help.jsp" >Help</a></li>
        <li><a href="login.jsp" >Exit</a></li>
    </ul>
>>>>>>> 364f54e723446adc100a91643b59d04f8bfae46f
    </div>
</div>
</body>
</html>