<<<<<<< Updated upstream
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Customer, java.util.List" %>
<html>
<head>
    <title>Generate Bill - Pahana Edu Bookshop</title>
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
    <h2 class="mt-5">Generate Bill</h2>
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>
    <form action="<%= request.getContextPath() %>/bill" method="post" class="mt-3">
        <div class="mb-3">
            <label for="accountNumber" class="form-label">Account Number</label>
            <input type="text" class="form-control" id="accountNumber" name="accountNumber" required>
        </div>
        <button type="submit" class="btn btn-primary">Generate Bill</button>
    </form>

    <% if (request.getAttribute("customer") != null) { %>
    <h4 class="mt-5">Bill Details</h4>
    <%
        Customer customer = (Customer) request.getAttribute("customer");
        Double totalBill = (Double) request.getAttribute("totalBill");
        List<String> purchaseDetails = (List<String>) request.getAttribute("purchaseDetails");
    %>
    <table class="table table-bordered">
        <tr><th>Account Number</th><td><%= customer.getAccountNumber() %></td></tr>
        <tr><th>Name</th><td><%= customer.getName() %></td></tr>
        <tr><th>Address</th><td><%= customer.getAddress() %></td></tr>
        <tr><th>Phone</th><td><%= customer.getPhone() %></td></tr>
        <tr><th>Purchases</th><td>
            <% for (String detail : purchaseDetails) { %>
            <%= detail %><br>
            <% } %>
        </td></tr>
        <tr><th>Total Bill (LKR)</th><td><%= String.format("%.2f", totalBill) %></td></tr>
    </table>
    <% } %>
    <a href="dashboard.jsp" class="btn btn-secondary">Back</a>
</div>
</body>
</html>
=======

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Customer, model.Item, servlet.CustomerServlet, servlet.ItemServlet, util.DBConnection, java.sql.*, java.util.*" %>
<html>
<head>
    <title>Bill - Pahana Edu Bookshop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
    <script>
        function printPage() {
            window.print();
        }
    </script>
    <style>
        @media print {
            .no-print { display: none; }
        }
    </style>
</head>
<body>

<%
    String accountNumber = request.getParameter("accountNumber");
    if(accountNumber != null && !accountNumber.isEmpty()) {

        Customer customer = CustomerServlet.getCustomerById(accountNumber);
        if(customer != null) {
            List<Map<String,Object>> purchases = new ArrayList<>();
            double totalBill = 0;
            StringBuilder details = new StringBuilder();

            try(Connection conn = DBConnection.getConnection()) {

                String sql = "SELECT i.name, i.price, p.quantity FROM purchases p JOIN items i ON p.itemId = i.itemId WHERE p.accountNumber = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, accountNumber);
                ResultSet rs = stmt.executeQuery();

                while(rs.next()) {
                    String itemName = rs.getString("name");
                    int qty = rs.getInt("quantity");
                    double price = rs.getDouble("price");
                    double total = qty * price;

                    details.append(itemName).append(" x").append(qty).append(" = LKR ").append(String.format("%.2f", total)).append("; ");

                    Map<String,Object> row = new HashMap<>();
                    row.put("itemName", itemName);
                    row.put("quantity", qty);
                    row.put("price", price);
                    row.put("total", total);
                    purchases.add(row);

                    totalBill += total;
                }

                if(!purchases.isEmpty()) {
                    String insertBill = "INSERT INTO bills (accountNumber, details, totalAmount, createdAt) VALUES (?, ?, ?, NOW())";
                    PreparedStatement psBill = conn.prepareStatement(insertBill);
                    psBill.setString(1, accountNumber);
                    psBill.setString(2, details.toString());
                    psBill.setDouble(3, totalBill);
                    psBill.executeUpdate();
                    psBill.close();

                    String deletePurchases = "DELETE FROM purchases WHERE accountNumber = ?";
                    PreparedStatement psDelete = conn.prepareStatement(deletePurchases);
                    psDelete.setString(1, accountNumber);
                    psDelete.executeUpdate();
                    psDelete.close();
                }

                stmt.close();
                rs.close();

            } catch(Exception e) { e.printStackTrace(); }
%>

<div class="container">
    <h1>PAHANA EDU BOOKSHOP</h1>
    <h3>Bill for Customer: <%= customer.getName() %> (<%= customer.getAccountNumber() %>)</h3>
    <p>Address: <%= customer.getAddress() %> | Phone: <%= customer.getPhone() %></p>

    <table class="table">
        <thead>
        <tr>
            <th>Item</th>
            <th>Quantity</th>
            <th>Price (LKR)</th>
            <th>Total (LKR)</th>
        </tr>
        </thead>
        <tbody>
        <% for(Map<String,Object> p : purchases) { %>
        <tr>
            <td><%= p.get("itemName") %></td>
            <td><%= p.get("quantity") %></td>
            <td><%= String.format("%.2f", p.get("price")) %></td>
            <td><%= String.format("%.2f", p.get("total")) %></td>
        </tr>
        <% } %>
        <tr>
            <th colspan="3" style="text-align:right;">Total Bill</th>
            <th>LKR <%= String.format("%.2f", totalBill) %></th>
        </tr>
        </tbody>
    </table>

    <h3>Thank you for choosing us!</h3>
    <h3>"The more that you read, the more things you will know. The more that you learn, the more places you'll go."</h3>

    <div style="text-align:center; margin-top:20px;">
        <button class="btn btn-success no-print" onclick="printPage()">Print Bill</button>
        <a href="addPurchase.jsp" class="btn btn-secondary no-print">Back</a>
    </div>
</div>

<% } else { %>
<p>Customer not found.</p>
<% } %>
<% } else { %>
<p>No account selected.</p>
<% } %>

</body>
</html>

>>>>>>> Stashed changes
