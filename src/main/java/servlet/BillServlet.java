package servlet;

import util.DBConnection;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/BillServlet")
public class BillServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");

        if ("delete".equals(action)) {
            String billIdStr = request.getParameter("billId");
            if (billIdStr != null && !billIdStr.isEmpty()) {
                int billId = Integer.parseInt(billIdStr);
                try (Connection conn = DBConnection.getConnection()) {
                    String sql = "DELETE FROM bills WHERE id=?";
                    PreparedStatement stmt = conn.prepareStatement(sql);
                    stmt.setInt(1, billId);
                    int rows = stmt.executeUpdate();
                    if (rows > 0) {
                        System.out.println("Bill deleted successfully: " + billId);
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

<<<<<<< HEAD
        // Redirect back to bill history page
=======
>>>>>>> 583dd582f8d1f1ac0b07a71509227deaf3147174
        response.sendRedirect("billHistory.jsp");
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
<<<<<<< HEAD
        // Optionally, you can handle fetching bills for display here
=======

>>>>>>> 583dd582f8d1f1ac0b07a71509227deaf3147174
        doPost(request, response);
    }
}
