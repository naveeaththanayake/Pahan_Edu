package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import util.DBConnection;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/purchase")
public class PurchaseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNumber = request.getParameter("accountNumber");
        String itemId = request.getParameter("itemId");
        String quantityStr = request.getParameter("quantity");

        if (accountNumber == null || itemId == null || quantityStr == null || quantityStr.isEmpty()) {
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/addPurchase.jsp").forward(request, response);
            return;
        }

        int quantity = Integer.parseInt(quantityStr);

        try (Connection conn = DBConnection.getConnection()) {
            PreparedStatement stmt = conn.prepareStatement(
                    "INSERT INTO purchases (accountNumber, itemId, quantity) VALUES (?, ?, ?)"
            );
            stmt.setString(1, accountNumber);
            stmt.setString(2, itemId);
            stmt.setInt(3, quantity);
            stmt.executeUpdate();

            // Stay on the addPurchase.jsp page with the same customer selected
            response.sendRedirect(request.getContextPath() + "/addPurchase.jsp?accountNumber=" + accountNumber);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error. Please try again.");
            request.getRequestDispatcher("/addPurchase.jsp").forward(request, response);
        }
    }

    public static List<Map<String, Object>> getPurchasesByCustomer(String accountNumber) {
        List<Map<String, Object>> purchases = new ArrayList<>();
        String sql = "SELECT p.itemId, i.name AS itemName, p.quantity, i.price " +
                "FROM purchases p JOIN items i ON p.itemId = i.itemId " +
                "WHERE p.accountNumber = ?";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, accountNumber);
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("itemId", rs.getString("itemId"));
                row.put("itemName", rs.getString("itemName"));
                row.put("quantity", rs.getInt("quantity"));
                row.put("price", rs.getDouble("price"));
                purchases.add(row);
            }

        } catch (SQLException e) {
            e.printStackTrace();
        }

        return purchases;
    }
}
