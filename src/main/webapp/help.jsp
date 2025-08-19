<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Help - Pahana Edu Bookshop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
</head>
<body>

<br>
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

<div class="container">
    <h2 class="mt-5">Help - System Usage Guidelines</h2>
    <div class="mt-3">
        <h4>1. Login</h4>
        <p>Use your username and password to access the system. Contact the administrator if you face issues.</p>
        <h4>2. Adding Customers</h4>
        <p>Navigate to "Add New Customer" to register a new customer with a unique account number, name, address, and phone.</p>
        <h4>3. Editing Customers</h4>
        <p>From "View Customers", select a customer to edit their details.</p>
        <h4>4. Managing Items</h4>
        <p>Add, update, or delete items from the "Manage Items" section. Ensure item IDs are unique.</p>
        <h4>5. Adding Purchases</h4>
        <p>Go to "Add Purchase" to record items purchased by a customer, specifying the quantity purchased.</p>
        <h4>6. Generating Bills</h4>
        <p>Enter the customer's account number in "Generate Bill" to display the bill based on purchased items.</p>
        <h4>7. Exiting</h4>
        <p>Click "Exit" to log out and return to the login page.</p>
    </div>
    <a href="dashboard.jsp" class="btn btn-secondary">Back</a>
</div>
</body>
</html>