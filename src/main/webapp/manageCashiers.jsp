<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="model.Cashier, util.DBConnection, java.sql.*, java.util.ArrayList, java.util.List" %>
<html>
<head>
    <title>Manage Cashiers - Pahana Edu Bookshop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
    <style>
        .main-container {
            max-width: 800px;
            margin: 20px auto;
            padding: 20px;
            font-family: Arial, sans-serif;
        }
        .form-group {
            margin-bottom: 15px;
        }
        .form-label {
            display: block;
            margin-bottom: 5px;
            font-weight: bold;
        }
        .form-input {
            width: 100%;
            padding: 8px;
            border: 1px solid #ddd;
            border-radius: 4px;
        }
        .btn {
            padding: 10px 20px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
            margin-right: 10px;
        }
        .btn-primary {
            background-color: #007bff;
            color: white;
        }
        .btn-danger {
            background-color: #dc3545;
            color: white;
        }
        .btn-sm {
            padding: 5px 10px;
            font-size: 0.9em;
        }
        .table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }
        .table th, .table td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }
        .table th {
            background-color: #007bff;
            color: white;
        }
        .alert {
            padding: 10px;
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
            border-radius: 4px;
            margin-bottom: 20px;
        }
        .inline-form {
            display: inline;
        }
    </style>
</head>
<body>
<div class="main-container">
    <h2>Manage Cashiers</h2>
    <%
        String userRole = (String) session.getAttribute("userRole");
        if (!"cashier".equals(userRole)) {
    %>
    <div class="alert">Access denied. Admin privileges required.</div>
    <a href="dashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
    <% } else { %>
    <%
        String error = null;
        String action = request.getParameter("action");
        if (action != null) {
            try (Connection conn = DBConnection.getConnection()) {
                if ("add".equals(action)) {
                    String username = request.getParameter("username");
                    String password = request.getParameter("password");
                    // Check if username exists
                    String checkSql = "SELECT username FROM cashiers WHERE username = ?";
                    PreparedStatement checkStmt = conn.prepareStatement(checkSql);
                    checkStmt.setString(1, username);
                    ResultSet rs = checkStmt.executeQuery();
                    if (rs.next()) {
                        error = "Username already exists.";
                    } else {
                        String sql = "INSERT INTO cashiers (username, password) VALUES (?, ?)";
                        PreparedStatement stmt = conn.prepareStatement(sql);
                        stmt.setString(1, username);
                        stmt.setString(2, password);
                        stmt.executeUpdate();
                    }
                } else if ("update".equals(action)) {
                    String cashierId = request.getParameter("cashierId");
                    String password = request.getParameter("password");
                    String sql = "UPDATE cashiers SET password = ? WHERE cashierId = ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setString(1, password);
                    stmt.setString(2, cashierId);
                    int rows = stmt.executeUpdate();
                    if (rows == 0) {
                        error = "Cashier not found.";
                    }
                } else if ("delete".equals(action)) {
                    String cashierId = request.getParameter("cashierId");
                    String sql = "DELETE FROM cashiers WHERE cashierId = ?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setString(1, cashierId);
                    int rows = stmt.executeUpdate();
                    if (rows == 0) {
                        error = "Cashier not found.";
                    }
                }
            } catch (SQLException e) {
                error = "Database error: " + e.getMessage();
            }
        }
    %>
    <% if (error != null) { %>
    <div class="alert"><%= error %></div>
    <% } %>

    <!-- Add Cashier Form -->
    <form action="manageCashiers.jsp" method="post">
        <input type="hidden" name="action" value="add">
        <div class="form-group">
            <label for="username" class="form-label">Username</label>
            <input type="text" class="form-input" id="username" name="username" required>
        </div>
        <div class="form-group">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-input" id="password" name="password" required>
        </div>
        <button type="submit" class="btn btn-primary">Add Cashier</button>
    </form>

    <!-- Cashier List -->
    <h3>Cashier List</h3>
    <%
        List<Cashier> cashiers = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT cashierId, username, password FROM cashiers";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                cashiers.add(new Cashier(
                        rs.getInt("cashierId"),
                        rs.getString("username"),
                        rs.getString("password")
                ));
            }
        } catch (SQLException e) {
            error = "Error fetching cashiers: " + e.getMessage();
        }
    %>
    <table class="table">
        <thead>
        <tr>
            <th>Cashier ID</th>
            <th>Username</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% if (cashiers.isEmpty()) { %>
        <tr>
            <td colspan="3">No cashiers found.</td>
        </tr>
        <% } else { %>
        <% for (Cashier cashier : cashiers) { %>
        <tr>
            <td><%= cashier.getCashierId() %></td>
            <td><%= cashier.getUsername() %></td>
            <td>
                <!-- Update Form -->
                <form action="manageCashiers.jsp" method="post" class="inline-form">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="cashierId" value="<%= cashier.getCashierId() %>">
                    <input type="password" class="form-input" name="password" placeholder="New Password" required>
                    <button type="submit" class="btn btn-sm btn-primary">Update</button>
                </form>
                <!-- Delete Form -->
                <form action="manageCashiers.jsp" method="post" class="inline-form">
                    <input type="hidden" name="action" value="delete">
                    <input type="hidden" name="cashierId" value="<%= cashier.getCashierId() %>">
                    <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                </form>
            </td>
        </tr>
        <% } %>
        <% } %>
        </tbody>
    </table>
    <a href="dashboard.jsp" class="btn btn-primary">Back to Dashboard</a>
    <% } %>
</div>
</body>
</html>