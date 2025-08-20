<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Customer, model.Item, servlet.CustomerServlet, servlet.ItemServlet, util.DBConnection, java.sql.*, java.util.*" %>
<html>
<head>
    <title>Manage Purchases - Pahana Edu Bookshop</title>
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
        <li><a href="saleReport.jsp" >Sale Report</a></li>
        <li><a href="help.jsp">Help</a></li>
        <li><a href="login.jsp">Exit</a></li>
    </ul>
</div>
<br>

<div class="container">
    <h2>Manage Purchases</h2>

    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>

    <%-- Select Customer --%>
    <form method="get">
        <label for="accountNumber">Select Customer:</label>
        <select name="accountNumber" id="accountNumber" onchange="this.form.submit()">
            <%
                String selectedAccount = request.getParameter("accountNumber");
                for (Customer c : CustomerServlet.getAllCustomers()) {
            %>
            <option value="<%= c.getAccountNumber() %>"
                    <%= (selectedAccount != null && selectedAccount.equals(c.getAccountNumber())) ? "selected" : "" %>>
                <%= c.getName() %> (<%= c.getAccountNumber() %>)
            </option>
            <% } %>
        </select>
    </form>

    <br/>


    <%
        List<Map<String,Object>> purchases = new ArrayList<>();
        if (selectedAccount != null) {
            try (Connection conn = DBConnection.getConnection()) {
                String sql = "SELECT p.purchaseId, i.name, i.price, p.quantity " +
                        "FROM purchases p JOIN items i ON p.itemId = i.itemId " +
                        "WHERE p.accountNumber = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, selectedAccount);
                ResultSet rs = stmt.executeQuery();
                while (rs.next()) {
                    Map<String,Object> row = new HashMap<>();
                    row.put("purchaseId", rs.getInt("purchaseId"));
                    row.put("itemName", rs.getString("name"));
                    row.put("price", rs.getDouble("price"));
                    row.put("quantity", rs.getInt("quantity"));
                    purchases.add(row);
                }
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
    %>

    <% if (!purchases.isEmpty()) { %>
    <h3>Purchases for <%= CustomerServlet.getCustomerById(selectedAccount).getName() %></h3>
    <table class="table">
        <thead>
        <tr>
            <th>Item</th>
            <th>Quantity</th>
            <th>Price</th>
            <th>Total</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <%
            double totalBill = 0;
            for (Map<String,Object> p : purchases) {
                String itemName = (String) p.get("itemName");
                int quantity = (int) p.get("quantity");
                double price = (double) p.get("price");
                double total = quantity * price;
                totalBill += total;
                int purchaseId = (int) p.get("purchaseId");
        %>
        <tr>
            <td><%= itemName %></td>
            <td>
                <form method="post" action="managePurchase.jsp">
                    <input type="hidden" name="purchaseId" value="<%= purchaseId %>">
                    <input type="hidden" name="accountNumber" value="<%= selectedAccount %>">
                    <input type="number" name="quantity" value="<%= quantity %>" min="1" required>
                    <button type="submit" name="action" value="update" class="btn btn-sm btn-primary">Update</button>
                </form>
            </td>
            <td><%= price %></td>
            <td><%= total %></td>
            <td>
                <form method="post" action="managePurchase.jsp" style="display:inline;">
                    <input type="hidden" name="purchaseId" value="<%= purchaseId %>">
                    <input type="hidden" name="accountNumber" value="<%= selectedAccount %>">
                    <button type="submit" name="action" value="delete" class="btn btn-sm btn-danger">Delete</button>
                </form>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <h4>Total Bill: LKR <%= totalBill %></h4>
    <% } else if (selectedAccount != null) { %>
    <p>No purchases found for this customer.</p>
    <% } %>

</div>


<%
    String action = request.getParameter("action");
    String purchaseIdStr = request.getParameter("purchaseId");
    String accountNumber = request.getParameter("accountNumber");
    if (action != null && purchaseIdStr != null) {
        int purchaseId = Integer.parseInt(purchaseIdStr);
        try (Connection conn = DBConnection.getConnection()) {
            if ("update".equals(action)) {
                int newQty = Integer.parseInt(request.getParameter("quantity"));
                PreparedStatement stmt = conn.prepareStatement("UPDATE purchases SET quantity=? WHERE purchaseId=?");
                stmt.setInt(1, newQty);
                stmt.setInt(2, purchaseId);
                stmt.executeUpdate();
            } else if ("delete".equals(action)) {
                PreparedStatement stmt = conn.prepareStatement("DELETE FROM purchases WHERE purchaseId=?");
                stmt.setInt(1, purchaseId);
                stmt.executeUpdate();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        response.sendRedirect("managePurchase.jsp?accountNumber=" + accountNumber);
        return;
    }
%>

</body>
</html>
