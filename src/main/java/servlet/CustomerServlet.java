package servlet;

import model.Customer;
import util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/customer")
public class CustomerServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String accountNumber = request.getParameter("accountNumber");
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");

            try (Connection conn = DBConnection.getConnection()) {
                String sql = "INSERT INTO customers (accountNumber, name, address, phone) VALUES (?, ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, accountNumber);
                stmt.setString(2, name);
                stmt.setString(3, address);
                stmt.setString(4, phone);
                stmt.executeUpdate();
                response.sendRedirect("viewCustomers.jsp");
            } catch (SQLException e) {
                request.setAttribute("error", "Error adding customer: " + e.getMessage());
                request.getRequestDispatcher("addCustomer.jsp").forward(request, response);
            }
        } else if ("edit".equals(action)) {
            String accountNumber = request.getParameter("accountNumber");
            String name = request.getParameter("name");
            String address = request.getParameter("address");
            String phone = request.getParameter("phone");

            try (Connection conn = DBConnection.getConnection()) {
                String sql = "UPDATE customers SET name = ?, address = ?, phone = ? WHERE accountNumber = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, name);
                stmt.setString(2, address);
                stmt.setString(3, phone);
                stmt.setString(4, accountNumber);
                stmt.executeUpdate();
                response.sendRedirect("viewCustomers.jsp");
            } catch (SQLException e) {
                request.setAttribute("error", "Error updating customer: " + e.getMessage());
                request.getRequestDispatcher("editCustomer.jsp?accountNumber=" + accountNumber).forward(request, response);
            }
        } else if ("delete".equals(action)) {
            String accountNumber = request.getParameter("accountNumber");

            try (Connection conn = DBConnection.getConnection()) {
                // Delete related purchases first
                String deletePurchasesSql = "DELETE FROM purchases WHERE accountNumber = ?";
                PreparedStatement deletePurchasesStmt = conn.prepareStatement(deletePurchasesSql);
                deletePurchasesStmt.setString(1, accountNumber);
                deletePurchasesStmt.executeUpdate();

                // Delete customer
                String deleteCustomerSql = "DELETE FROM customers WHERE accountNumber = ?";
                PreparedStatement deleteCustomerStmt = conn.prepareStatement(deleteCustomerSql);
                deleteCustomerStmt.setString(1, accountNumber);
                deleteCustomerStmt.executeUpdate();
                response.sendRedirect("viewCustomers.jsp");
            } catch (SQLException e) {
                request.setAttribute("error", "Error deleting customer: " + e.getMessage());
                request.getRequestDispatcher("viewCustomers.jsp").forward(request, response);
            }
        }
    }

    public static Customer getCustomerById(String accountNumber) {
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM customers WHERE accountNumber = ?";
            PreparedStatement stmt = conn.prepareStatement(sql);
            stmt.setString(1, accountNumber);
            ResultSet rs = stmt.executeQuery(); // Fixed: Changed executeResultSet to executeQuery
            if (rs.next()) {
                return new Customer(rs.getString("accountNumber"), rs.getString("name"), rs.getString("address"), rs.getString("phone"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public static List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM customers";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery(); // Fixed: Changed executeResultSet to executeQuery
            while (rs.next()) {
                customers.add(new Customer(rs.getString("accountNumber"), rs.getString("name"), rs.getString("address"), rs.getString("phone")));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return customers;
    }
}