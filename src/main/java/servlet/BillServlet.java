package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customer;
import util.DBConnection;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/bill")
public class BillServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String accountNumber = request.getParameter("accountNumber");

        try (Connection conn = DBConnection.getConnection()) {
            // Get customer details
            PreparedStatement customerStmt = conn.prepareStatement("SELECT * FROM customers WHERE accountNumber = ?");
            customerStmt.setString(1, accountNumber);
            ResultSet customerRs = customerStmt.executeQuery();
            if (!customerRs.next()) {
                request.setAttribute("error", "Customer not found");
                request.getRequestDispatcher("/generateBill.jsp").forward(request, response);
                return;
            }
            Customer customer = new Customer(customerRs.getString("accountNumber"), customerRs.getString("name"),
                    customerRs.getString("address"), customerRs.getString("phone"));

            // Get purchases and calculate total bill
            PreparedStatement purchaseStmt = conn.prepareStatement(
                    "SELECT p.quantity, i.name, i.price FROM purchases p JOIN items i ON p.itemId = i.itemId WHERE p.accountNumber = ?");
            purchaseStmt.setString(1, accountNumber);
            ResultSet purchaseRs = purchaseStmt.executeQuery();
            List<String> purchaseDetails = new ArrayList<>();
            double totalBill = 0.0;
            while (purchaseRs.next()) {
                int quantity = purchaseRs.getInt("quantity");
                String itemName = purchaseRs.getString("name");
                double price = purchaseRs.getDouble("price");
                double itemTotal = quantity * price;
                totalBill += itemTotal;
                purchaseDetails.add(String.format("%s: %d items x LKR %.2f = LKR %.2f", itemName, quantity, price, itemTotal));
            }

            request.setAttribute("customer", customer);
            request.setAttribute("totalBill", totalBill);
            request.setAttribute("purchaseDetails", purchaseDetails);
            request.getRequestDispatcher("/generateBill.jsp").forward(request, response);
        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error. Please try again.");
            request.getRequestDispatcher("/generateBill.jsp").forward(request, response);
        }
    }
}