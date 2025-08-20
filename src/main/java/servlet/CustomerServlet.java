package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import model.Customer;
import util.DBConnection;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/customer")
public class CustomerServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        try {
            if ("add".equals(action)) {
                addCustomer(request, response);
            } else if ("update".equals(action)) {
                updateCustomer(request, response);
            } else if ("delete".equals(action)) {
                deleteCustomer(request, response);
            } else {
                response.sendRedirect("viewCustomers.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Error: " + e.getMessage());
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }



    private void addCustomer(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String accountNumber = request.getParameter("accountNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "INSERT INTO customers (accountNumber, name, address, phone) VALUES (?, ?, ?, ?)";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, accountNumber);
                stmt.setString(2, name);
                stmt.setString(3, address);
                stmt.setString(4, phone);
                stmt.executeUpdate();
            }
        }

        response.sendRedirect("viewCustomers.jsp");
    }

    private void updateCustomer(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String accountNumber = request.getParameter("accountNumber");
        String name = request.getParameter("name");
        String address = request.getParameter("address");
        String phone = request.getParameter("phone");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "UPDATE customers SET name=?, address=?, phone=? WHERE accountNumber=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, name);
                stmt.setString(2, address);
                stmt.setString(3, phone);
                stmt.setString(4, accountNumber);
                stmt.executeUpdate();
            }
        }

        response.sendRedirect("viewCustomers.jsp");
    }

    private void deleteCustomer(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String accountNumber = request.getParameter("accountNumber");

        try (Connection conn = DBConnection.getConnection()) {
            String sql = "DELETE FROM customers WHERE accountNumber=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, accountNumber);
                stmt.executeUpdate();
            }
        }

        response.sendRedirect("viewCustomers.jsp");
    }


    public static List<Customer> getAllCustomers() {
        List<Customer> customers = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery("SELECT * FROM customers")) {

            while (rs.next()) {
                customers.add(new Customer(
                        rs.getString("accountNumber"),
                        rs.getString("name"),
                        rs.getString("address"),
                        rs.getString("phone")
                ));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return customers;
    }

    public static Customer getCustomerById(String accountNumber) {
        Customer customer = null;
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM customers WHERE accountNumber=?";
            try (PreparedStatement stmt = conn.prepareStatement(sql)) {
                stmt.setString(1, accountNumber);
                try (ResultSet rs = stmt.executeQuery()) {
                    if (rs.next()) {
                        customer = new Customer(
                                rs.getString("accountNumber"),
                                rs.getString("name"),
                                rs.getString("address"),
                                rs.getString("phone")
                        );
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return customer;
    }
}
