package servlet;

import model.Cashier;
import util.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
<<<<<<< HEAD
=======
import jakarta.servlet.http.HttpSession;
>>>>>>> 583dd582f8d1f1ac0b07a71509227deaf3147174

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import util.DBConnection;
import model.Cashier;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
<<<<<<< HEAD
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.getRequestDispatcher("login.jsp").forward(request, response);
    }

    @Override
=======
>>>>>>> 583dd582f8d1f1ac0b07a71509227deaf3147174
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        try (Connection conn = DBConnection.getConnection()) {

<<<<<<< HEAD
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
=======

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
>>>>>>> 583dd582f8d1f1ac0b07a71509227deaf3147174
            request.getRequestDispatcher("login.jsp").forward(request, response);

        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
