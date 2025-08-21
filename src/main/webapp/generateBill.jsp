<<<<<<< Updated upstream
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
                // Fetch purchases
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

                // Save bill to bills table
                if(!purchases.isEmpty()) {
                    String insertBill = "INSERT INTO bills (accountNumber, details, totalAmount, createdAt) VALUES (?, ?, ?, NOW())";
                    PreparedStatement psBill = conn.prepareStatement(insertBill);
                    psBill.setString(1, accountNumber);
                    psBill.setString(2, details.toString());
                    psBill.setDouble(3, totalBill);
                    psBill.executeUpdate();
                    psBill.close();

                    // Clear the purchases for this customer
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
