package controller;

import jakarta.servlet.*;
import jakarta.servlet.http.*;
import java.io.IOException;

public class LogoutServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
        throws ServletException, IOException {

        HttpSession session = request.getSession(false); // Get the session if it exists
        if (session != null) {
            session.invalidate(); // End the session
        }
        response.sendRedirect("index.jsp"); // Redirect to the index page
    }
}
