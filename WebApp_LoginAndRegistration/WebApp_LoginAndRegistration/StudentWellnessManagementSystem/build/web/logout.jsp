<%@ page import="jakarta.servlet.http.HttpSession" %>
<%
    session.invalidate();  // Invalidate the current session
    
    response.sendRedirect("login.jsp");  // Redirect to login page
%>
