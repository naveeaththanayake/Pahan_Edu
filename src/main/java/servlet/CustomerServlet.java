package com.pahanedu;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/addCustomer")
public class AddCustomerServlet extends HttpServlet {
    private CustomerDAO dao = new CustomerDAO();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String name = req.getParameter("name");
        String email = req.getParameter("email");
        String phone = req.getParameter("phone");
        String address = req.getParameter("address");

        Customer c = new Customer();
        c.setName(name);
        c.setEmail(email);
        c.setPhone(phone);
        c.setAddress(address);

        boolean ok = dao.addCustomer(c);
        if (ok) {
            resp.sendRedirect(req.getContextPath() + "/dashboard.jsp?msg=Customer+added");
        } else {
            req.setAttribute("error", "Unable to add customer");
            req.getRequestDispatcher("addCustomer.jsp").forward(req, resp);
        }
    }
}