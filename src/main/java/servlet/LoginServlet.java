package servlet;

import model.Cashier;
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

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {

            // Check users table
            String sqlUser = "SELECT username, password FROM users WHERE username = ? AND password = ?";
            PreparedStatement stmtUser = conn.prepareStatement(sqlUser);
            stmtUser.setString(1, username);
            stmtUser.setString(2, password);
            ResultSet rsUser = stmtUser.executeQuery();

            if (rsUser.next()) {
                request.getSession().setAttribute("username", rsUser.getString("username"));
                request.getSession().setAttribute("loginType", "user");
                response.sendRedirect("dashboard.jsp");
                return;
            }

            // Check cashiers table
            String sqlCashier = "SELECT cashierId, username, password FROM cashiers WHERE username = ? AND password = ?";
            PreparedStatement stmtCashier = conn.prepareStatement(sqlCashier);
            stmtCashier.setString(1, username);
            stmtCashier.setString(2, password);
            ResultSet rsCashier = stmtCashier.executeQuery();

            if (rsCashier.next()) {
                Cashier cashier = new Cashier(
                        rsCashier.getInt("cashierId"),
                        rsCashier.getString("username"),
                        rsCashier.getString("password")
                );
                request.getSession().setAttribute("cashier", cashier);
                request.getSession().setAttribute("loginType", "cashier");
                response.sendRedirect("dashboard.jsp");
                return;
            }

            // Invalid login
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } catch (SQLException e) {
            e.printStackTrace();
            request.setAttribute("error", "Database error: " + e.getMessage());
            request.getRequestDispatcher("login.jsp").forward(request, response);
        }
    }
}
