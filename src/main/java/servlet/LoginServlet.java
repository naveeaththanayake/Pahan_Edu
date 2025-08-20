package servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBConnection;
import model.Cashier;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {


            String sqlUser = "SELECT * FROM users WHERE username=? AND password=?";
            try (PreparedStatement ps = conn.prepareStatement(sqlUser)) {
                ps.setString(1, username);
                ps.setString(2, password);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        HttpSession session = request.getSession();
                        session.setAttribute("username", rs.getString("username"));
                        session.setAttribute("role", "admin");
                        response.sendRedirect("dashboard.jsp");
                        return;
                    }
                }
            }

            // 2. Check cashier (cashiers table)
            String sqlCashier = "SELECT * FROM cashiers WHERE username=? AND password=?";
            try (PreparedStatement ps = conn.prepareStatement(sqlCashier)) {
                ps.setString(1, username);
                ps.setString(2, password);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        Cashier cashier = new Cashier(
                                rs.getInt("cashierId"),
                                rs.getString("username"),
                                rs.getString("password")
                        );

                        HttpSession session = request.getSession();
                        session.setAttribute("cashier", cashier);
                        session.setAttribute("role", "cashier"); // ✅ mark role
                        response.sendRedirect("dashboard.jsp");
                        return;
                    }
                }
            }

            // If no match → back to login
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
