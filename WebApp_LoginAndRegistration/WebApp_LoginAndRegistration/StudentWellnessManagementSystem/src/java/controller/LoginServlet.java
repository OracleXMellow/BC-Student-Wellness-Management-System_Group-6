package controller;

import model.StudentLogin;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;

public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        ///// Get login form input /////
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        ///// Validate info with what is saved in the database /////
        boolean isValid = StudentLogin.validate(email, password);

        if (isValid) {
            HttpSession session = request.getSession(); //Store user's email
            session.setAttribute("name", email);

            response.sendRedirect("dashboard.jsp"); // Redirect to dashboard
        } else {
            response.setContentType("text/html"); //Error message if login failed
            PrintWriter out = response.getWriter();
            out.println("<h2 style='color:red;'>Invalid credentials. Try again.</h2>");
        }
    }
}
