package servlet;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import jakarta.servlet.annotation.*;
import java.io.IOException;
import java.sql.*;
import util.DBConnection;

@WebServlet("/PurchaseServlet")
public class PurchaseServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        String accountNumber = request.getParameter("accountNumber");

        Connection conn = null;
        PreparedStatement ps = null;

        try {
            conn = DBConnection.getConnection();

            if ("add".equals(action)) {
                int itemId = Integer.parseInt(request.getParameter("itemId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                String sql = "INSERT INTO purchases (accountNumber, itemId, quantity) VALUES (?, ?, ?)";
                ps = conn.prepareStatement(sql);
                ps.setString(1, accountNumber);
                ps.setInt(2, itemId);
                ps.setInt(3, quantity);
                ps.executeUpdate();

            } else if ("update".equals(action)) {
                int purchaseId = Integer.parseInt(request.getParameter("purchaseId"));
                int quantity = Integer.parseInt(request.getParameter("quantity"));

                String sql = "UPDATE purchases SET quantity = ? WHERE purchaseId = ?";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, quantity);
                ps.setInt(2, purchaseId);
                ps.executeUpdate();

            } else if ("delete".equals(action)) {
                int purchaseId = Integer.parseInt(request.getParameter("purchaseId"));

                String sql = "DELETE FROM purchases WHERE purchaseId = ?";
                ps = conn.prepareStatement(sql);
                ps.setInt(1, purchaseId);
                ps.executeUpdate();
            }

        } catch (Exception e) {
            e.printStackTrace();
            throw new ServletException(e);
        } finally {
            try {
                if (ps != null) ps.close();
                if (conn != null) conn.close();
            } catch (Exception ignored) {}
        }

<<<<<<< HEAD
        // Redirect back to addPurchase.jsp with the same accountNumber
=======
>>>>>>> 583dd582f8d1f1ac0b07a71509227deaf3147174
        response.sendRedirect("addPurchase.jsp?accountNumber=" + accountNumber);
    }
}
