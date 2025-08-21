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

    <div class ="nav"><ul>
        <li><a href="addCustomer.jsp" >Add New Customer</a></li>
        <li><a href="viewCustomers.jsp" >View Customers</a></li>
        <li><a href="addPurchase.jsp" >Add Purchase</a></li>
        <li><a href="billHistory.jsp" >Bill History</a></li>
        <li><a href="saleReport.jsp" >Sale Report</a></li>
        <li><a href="help.jsp" >Help</a></li>
        <li><a href="login.jsp" >Exit</a></li>
    </ul>
    </div>
</div>
</body>
</html>