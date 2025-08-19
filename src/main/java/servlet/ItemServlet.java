package servlet;

import model.Item;
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

@WebServlet("/item")
public class ItemServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("add".equals(action)) {
            String itemId = request.getParameter("itemId");
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock")); // Parse stock

            try (Connection conn = DBConnection.getConnection()) {
                String sql = "INSERT INTO items (itemId, name, price, stock) VALUES (?, ?, ?, ?)";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, itemId);
                stmt.setString(2, name);
                stmt.setDouble(3, price);
                stmt.setInt(4, stock);
                stmt.executeUpdate();
                response.sendRedirect("manageItems.jsp");
            } catch (SQLException e) {
                request.setAttribute("error", "Error adding item: " + e.getMessage());
                request.getRequestDispatcher("manageItems.jsp").forward(request, response);
            }

        } else if ("update".equals(action)) {
            String itemId = request.getParameter("itemId");
            String name = request.getParameter("name");
            double price = Double.parseDouble(request.getParameter("price"));
            int stock = Integer.parseInt(request.getParameter("stock")); // Parse stock

            try (Connection conn = DBConnection.getConnection()) {
                String sql = "UPDATE items SET name = ?, price = ?, stock = ? WHERE itemId = ?";
                PreparedStatement stmt = conn.prepareStatement(sql);
                stmt.setString(1, name);
                stmt.setDouble(2, price);
                stmt.setInt(3, stock); // Set stock
                stmt.setString(4, itemId);
                stmt.executeUpdate();
                response.sendRedirect("manageItems.jsp");
            } catch (SQLException e) {
                request.setAttribute("error", "Error updating item: " + e.getMessage());
                request.getRequestDispatcher("manageItems.jsp").forward(request, response);
            }

        } else if ("delete".equals(action)) {
            String itemId = request.getParameter("itemId");

            try (Connection conn = DBConnection.getConnection()) {
                // Delete related purchases first
                String deletePurchasesSql = "DELETE FROM purchases WHERE itemId = ?";
                PreparedStatement deletePurchasesStmt = conn.prepareStatement(deletePurchasesSql);
                deletePurchasesStmt.setString(1, itemId);
                deletePurchasesStmt.executeUpdate();

                // Delete item
                String deleteItemSql = "DELETE FROM items WHERE itemId = ?";
                PreparedStatement deleteItemStmt = conn.prepareStatement(deleteItemSql);
                deleteItemStmt.setString(1, itemId);
                deleteItemStmt.executeUpdate();
                response.sendRedirect("manageItems.jsp");
            } catch (SQLException e) {
                request.setAttribute("error", "Error deleting item: " + e.getMessage());
                request.getRequestDispatcher("manageItems.jsp").forward(request, response);
            }
        }
    }

    public static List<Item> getAllItems() {
        List<Item> items = new ArrayList<>();
        try (Connection conn = DBConnection.getConnection()) {
            String sql = "SELECT * FROM items";
            PreparedStatement stmt = conn.prepareStatement(sql);
            ResultSet rs = stmt.executeQuery();
            while (rs.next()) {
                items.add(new Item(
                        rs.getString("itemId"),
                        rs.getString("name"),
                        rs.getDouble("price"),
                        rs.getInt("stock") // Include stock
                ));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }
}
