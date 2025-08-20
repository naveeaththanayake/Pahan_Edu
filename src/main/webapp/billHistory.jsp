<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*" %>
<html>
<head>
    <title>Bill History - Pahana Edu Bookshop</title>
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

<div class="main-container">
    <h2>Bill History</h2>

    <!-- Filter Form -->
    <form method="get" class="filter-form">
        <label for="day">Filter by Day:</label>
        <input type="date" name="day" id="day" value="<%= request.getParameter("day") != null ? request.getParameter("day") : "" %>">

        <label for="month">Filter by Month:</label>
        <input type="month" name="month" id="month" value="<%= request.getParameter("month") != null ? request.getParameter("month") : "" %>">

        <button type="submit" class="btn btn-primary">Filter</button>
        <a href="billHistory.jsp" class="btn btn-secondary">Reset</a>
    </form>

    <br/>

    <table class="table">
        <thead>
        <tr>
            <th>ID</th>
            <th>Account Number</th>
            <th>Details</th>
            <th>Total Amount</th>
            <th>Created At</th>
            <% if ("user".equals(session.getAttribute("loginType"))) { %>
            <th>Actions</th>
            <% } %>
        </tr>
        </thead>
        <tbody>
        <%
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahana_edu", "root", "");

                // Build query
                String query = "SELECT * FROM bills WHERE 1=1";
                String dayParam = request.getParameter("day");
                String monthParam = request.getParameter("month");

                if(dayParam != null && !dayParam.trim().isEmpty()) {
                    query += " AND DATE(createdAt) = ?";
                } else if(monthParam != null && !monthParam.trim().isEmpty()) {
                    query += " AND DATE_FORMAT(createdAt, '%Y-%m') = ?";
                }

                query += " ORDER BY createdAt DESC";

                PreparedStatement stmt = conn.prepareStatement(query);

                if(dayParam != null && !dayParam.trim().isEmpty()) {
                    stmt.setString(1, dayParam);
                } else if(monthParam != null && !monthParam.trim().isEmpty()) {
                    stmt.setString(1, monthParam);
                }

                ResultSet rs = stmt.executeQuery();
                boolean hasData = false;
                double totalRevenue = 0;

                while(rs.next()) {
                    hasData = true;
                    totalRevenue += rs.getDouble("totalAmount");
        %>
        <tr>
            <td><%= rs.getInt("id") %></td>
            <td><%= rs.getString("accountNumber") %></td>
            <td><%= rs.getString("details") %></td>
            <td>LKR <%= String.format("%.2f", rs.getDouble("totalAmount")) %></td>
            <td><%= rs.getTimestamp("createdAt") %></td>
            <% if ("user".equals(session.getAttribute("loginType"))) { %>
            <td>
                <form method="post" action="billHistory.jsp"
                      onsubmit="return confirm('Are you sure you want to delete this bill?');">
                    <input type="hidden" name="billId" value="<%= rs.getInt("id") %>">
                    <button type="submit" class="btn btn-danger">Delete</button>
                </form>
            </td>
            <% } %>
        </tr>
        <%  }
            if(!hasData) { %>
        <tr>
            <td colspan="6">No bills found for this filter.</td>
        </tr>
        <% } %>
        </tbody>
    </table>

    <% if(hasData) { %>
    <h3>Total Revenue: LKR <%= String.format("%.2f", totalRevenue) %></h3>
    <% } %>

    <br/>
    <a href="dashboard.jsp" class="btn btn-primary">Back to Dashboard</a>

    <%
            String billIdStr = request.getParameter("billId");
            if(billIdStr != null && "user".equals(session.getAttribute("loginType"))) {
                try (PreparedStatement deleteStmt = conn.prepareStatement("DELETE FROM bills WHERE id=?")) {
                    deleteStmt.setInt(1, Integer.parseInt(billIdStr));
                    deleteStmt.executeUpdate();
                    response.sendRedirect("billHistory.jsp");
                    return;
                } catch(Exception delEx) {
                    System.out.println("<p style='color:red;'>Delete Error: " + delEx.getMessage() + "</p>");
                }
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch(Exception e) {
            System.out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }
    %>
</div>
</body>
</html>
