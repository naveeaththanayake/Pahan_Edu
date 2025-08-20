<<<<<<< Updated upstream
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Customer, model.Item, servlet.CustomerServlet, servlet.ItemServlet, java.util.List" %>
=======
<<<<<<< Updated upstream
=======
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Customer, model.Item,servlet.BillServlet, servlet.CustomerServlet, servlet.ItemServlet, util.DBConnection, java.sql.*, java.util.*" %>
>>>>>>> Stashed changes
<html>
<head>
    <title>Add Purchase - Pahana Edu Bookshop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
<<<<<<< Updated upstream
=======
    <script>
        function printBill() {
            // Redirect to generateBill.jsp with accountNumber
            var accountNumber = document.getElementById("accountNumber").value;
            if(accountNumber) {
                window.location.href = "generateBill.jsp?accountNumber=" + accountNumber;
            } else {
                alert("Please select a customer first!");
            }
        }
    </script>
>>>>>>> Stashed changes
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
<<<<<<< Updated upstream
        <li><a href="generateBill.jsp">Generate Bill</a></li>
=======
        <li><a href="billHistory.jsp">Bill History</a></li>
        <li><a href="saleReport.jsp" >Sale Report</a></li>
>>>>>>> Stashed changes
        <li><a href="help.jsp">Help</a></li>
        <li><a href="login.jsp">Exit</a></li>
    </ul>
</div>
<<<<<<< Updated upstream
<br></br>

<div class="container">
    <h2 class="mt-5">Add Purchase</h2>
=======
<br>

<div class="container">
    <h2>Add Purchase</h2>
>>>>>>> Stashed changes
    <% if (request.getAttribute("error") != null) { %>
    <div class="alert alert-danger"><%= request.getAttribute("error") %></div>
    <% } %>

<<<<<<< Updated upstream
    <%
        // Get the account number if passed from "Bill" button
        String selectedAccount = request.getParameter("accountNumber");
    %>

    <form action="<%= request.getContextPath() %>/purchase" method="post">
        <div>
            <label for="accountNumber" class="form-label">Customer</label>
            <select class="form-control" id="accountNumber" name="accountNumber" required>
                <option value="">-- Select Customer --</option>
                <% for (Customer customer : CustomerServlet.getAllCustomers()) {
                    String acc = customer.getAccountNumber();
                    String selected = (selectedAccount != null && selectedAccount.equals(acc)) ? "selected" : "";
                %>
                <option value="<%= acc %>" <%= selected %>>
                    <%= customer.getName() %> (<%= acc %>)
                </option>
                <% } %>
            </select>
        </div>

        <div>
            <label for="itemId" class="form-label">Item</label>
            <select class="form-control" id="itemId" name="itemId" required>
                <% for (Item item : ItemServlet.getAllItems()) { %>
                <option value="<%= item.getItemId() %>"><%= item.getName() %> (LKR <%= item.getPrice() %>)</option>
                <% } %>
            </select>
        </div>

        <div>
            <label for="quantity" class="form-label">Quantity Purchased</label>
            <input type="number" class="form-control" id="quantity" name="quantity" required min="1">
        </div>

        <button type="submit" class="btn btn-primary">Add Purchase</button>
        <a href="dashboard.jsp" class="btn btn-secondary">Back</a>
    </form>
</div>
</body>
</html>
=======
    <%-- Handle Add Purchase POST --%>
    <%
        String postAction = request.getParameter("addAction");
        if ("add".equals(postAction)) {
            String accountNumber = request.getParameter("accountNumber");
            String itemId = request.getParameter("itemId");
            int quantity = Integer.parseInt(request.getParameter("quantity"));
            try (Connection conn = DBConnection.getConnection()) {
                PreparedStatement stmt = conn.prepareStatement(
                        "INSERT INTO purchases (accountNumber, itemId, quantity) VALUES (?, ?, ?)"
                );
                stmt.setString(1, accountNumber);
                stmt.setString(2, itemId);
                stmt.setInt(3, quantity);
                stmt.executeUpdate();
                response.sendRedirect("addPurchase.jsp?accountNumber=" + accountNumber);
                return;
            } catch (Exception e) {
                request.setAttribute("error", "Database error: " + e.getMessage());
            }
        }
    %>

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
    <br>

    <%-- Add Purchase Form --%>
    <% if (selectedAccount != null) { %>
    <form action="addPurchase.jsp" method="post">
        <input type="hidden" name="addAction" value="add">
        <input type="hidden" name="accountNumber" value="<%= selectedAccount %>">
        <div>
            <label for="itemId">Item:</label>
            <select name="itemId" id="itemId" required>
                <% for (Item i : ItemServlet.getAllItems()) { %>
                <option value="<%= i.getItemId() %>"><%= i.getName() %> (LKR <%= i.getPrice() %>)</option>
                <% } %>
            </select>
        </div>
        <div>
            <label for="quantity">Quantity:</label>
            <input type="number" name="quantity" id="quantity" min="1" required>
        </div>
        <button type="submit" class="btn btn-primary">Add Purchase</button>
    </form>
    <% } %>

    <br>

    <%-- Fetch Purchases --%>
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
            } catch (Exception e) { e.printStackTrace(); }
        }
    %>

    <%-- Display Purchases --%>
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
                <form method="post" style="display:inline;">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="purchaseId" value="<%= purchaseId %>">
                    <input type="hidden" name="accountNumber" value="<%= selectedAccount %>">
                    <input type="number" name="quantity" value="<%= quantity %>" min="1" required>
                    <button type="submit" class="btn btn-sm btn-primary">Update</button>
                </form>
            </td>
            <td><%= price %></td>
            <td><%= total %></td>
            <td>
                <form method="post" style="display:inline;">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="purchaseId" value="<%= purchaseId %>">
                    <input type="hidden" name="accountNumber" value="<%= selectedAccount %>">
                    <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                </form>
            </td>
        </tr>
        <% } %>
        <tr class="total-row">
            <td ><h4>Total Bill: LKR <%= totalBill %></h4></td>
            <td >
                <!-- Generate & Print Bill Button -->
                <button onclick="printBill()" class="btn btn-success">Generate & Print Bill</button>
            </td>
        </tr>
        </tbody>
    </table>
    <% } else if (selectedAccount != null) { %>
    <p>No purchases found for this customer.</p>
    <% } %>

    <%-- Handle Update/Delete POST --%>
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
            } catch (Exception e) { e.printStackTrace(); }
            response.sendRedirect("addPurchase.jsp?accountNumber=" + accountNumber);
            return;
        }
    %>

</div>
</body>
</html>
>>>>>>> Stashed changes
>>>>>>> Stashed changes
