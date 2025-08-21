<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.sql.*, java.util.*, java.text.SimpleDateFormat" %>
<html>
<head>
    <title>Sales Report - Pahana Edu Bookshop</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css?v=<%= System.currentTimeMillis() %>">
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        .main-container { max-width: 900px; margin: 20px auto; padding: 20px; font-family: Arial, sans-serif; }
        .filter-form { margin-bottom: 20px; }
        .btn { padding: 5px 10px; text-decoration: none; border-radius: 4px; }
        .btn-primary { background-color: #007bff; color: white; border: none; cursor: pointer; }
        .btn-secondary { background-color: #6c757d; color: white; border: none; cursor: pointer; }
        .total-revenue { margin-top: 20px; font-size: 18px; font-weight: bold; }
    </style>
</head>
<br>
<h1 >PAHANA EDU BOOKSHOP</h1>
<div class ="nav"><ul>
    <li><a href="addCustomer.jsp" >Add New Customer</a></li>
    <li><a href="viewCustomers.jsp" >View Customers</a></li>
    <li><a href="manageItems.jsp" >Manage Items</a></li>
    <li><a href="addPurchase.jsp" >Add Purchase</a></li>
    <li><a href="billHistory.jsp" >Bill History</a></li>
    <li><a href="saleReport.jsp" >Sale Report</a></li>
    <li><a href="help.jsp" >Help</a></li>
    <li><a href="login.jsp" >Exit</a></li>
</ul>
</div>
<br></br>
<body>
<div class="main-container">
    <h2>Sales Report</h2>

<<<<<<< HEAD
    <!-- Filter Form -->
=======

>>>>>>> 364f54e723446adc100a91643b59d04f8bfae46f
    <form method="get" class="filter-form">
        <label for="day">Select Day:</label>
        <input type="date" name="day" id="day" value="<%= request.getParameter("day") != null ? request.getParameter("day") : "" %>">

        <label for="month">Select Month:</label>
        <input type="month" name="month" id="month" value="<%= request.getParameter("month") != null ? request.getParameter("month") : "" %>">

        <button type="submit" class="btn btn-primary">Filter</button>
        <a href="saleReport.jsp" class="btn btn-secondary">Reset</a>
    </form>

    <canvas id="salesChart" width="800" height="400"></canvas>

    <%
        Map<String, Double> dailySales = new LinkedHashMap<>();
        double totalRevenue = 0;
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/pahana_edu", "root", "");

            String sql = "SELECT DATE(createdAt) AS saleDate, SUM(totalAmount) AS total FROM bills WHERE 1=1";
            String dayParam = request.getParameter("day");
            String monthParam = request.getParameter("month");

            if(dayParam != null && !dayParam.isEmpty()) {
                sql += " AND DATE(createdAt) = ?";
            } else if(monthParam != null && !monthParam.isEmpty()) {
                sql += " AND DATE_FORMAT(createdAt, '%Y-%m') = ?";
            }

            sql += " GROUP BY DATE(createdAt) ORDER BY DATE(createdAt) ASC";

            PreparedStatement stmt = conn.prepareStatement(sql);

            if(dayParam != null && !dayParam.isEmpty()) {
                stmt.setString(1, dayParam);
            } else if(monthParam != null && !monthParam.isEmpty()) {
                stmt.setString(1, monthParam);
            }

            ResultSet rs = stmt.executeQuery();
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            while(rs.next()) {
                java.sql.Date saleDate = rs.getDate("saleDate");
                String dateStr = sdf.format(saleDate);
                dailySales.put(dateStr, rs.getDouble("total"));
                totalRevenue += rs.getDouble("total");
            }

            rs.close();
            stmt.close();
            conn.close();
        } catch(Exception e) {
<<<<<<< HEAD
            out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }

        // Convert map to JS arrays properly
=======
            System.out.println("<p style='color:red;'>Error: " + e.getMessage() + "</p>");
        }


>>>>>>> 364f54e723446adc100a91643b59d04f8bfae46f
        StringBuilder labelsBuilder = new StringBuilder("[");
        StringBuilder dataBuilder = new StringBuilder("[");
        for(Map.Entry<String, Double> entry : dailySales.entrySet()) {
            labelsBuilder.append("'").append(entry.getKey()).append("',");
            dataBuilder.append(entry.getValue()).append(",");
        }
        if(labelsBuilder.length() > 1) labelsBuilder.setLength(labelsBuilder.length() - 1);
        if(dataBuilder.length() > 1) dataBuilder.setLength(dataBuilder.length() - 1);
        labelsBuilder.append("]");
        dataBuilder.append("]");
    %>

    <script>
        const ctx = document.getElementById('salesChart').getContext('2d');
        const chart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: <%= labelsBuilder.toString() %>,
                datasets: [{
                    label: 'Daily Sales (LKR)',
                    data: <%= dataBuilder.toString() %>,
                    backgroundColor: 'rgba(54, 162, 235, 0.7)',
                    borderColor: 'rgba(54, 162, 235, 1)',
                    borderWidth: 1
                }]
            },
            options: {
                responsive: true,
                plugins: {
                    tooltip: { enabled: true },
                    legend: { display: false },
                    title: { display: true, text: 'Sales Report' }
                },
                scales: {
                    y: {
                        beginAtZero: true,
                        title: { display: true, text: 'Sales Amount (LKR)' }
                    },
                    x: {
                        title: { display: true, text: 'Date' }
                    }
                }
            }
        });
    </script>

    <div class="total-revenue">
        Total Revenue: LKR <%= String.format("%.2f", totalRevenue) %>
    </div>

</div>
</body>
</html>
