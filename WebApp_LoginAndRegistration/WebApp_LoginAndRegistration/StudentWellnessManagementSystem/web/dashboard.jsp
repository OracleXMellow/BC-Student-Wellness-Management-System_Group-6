<%@ page session="true" %>
<%
    String name = (String) session.getAttribute("name");
    if (name == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html>
<head>
    <title>Dashboard</title>
    <link rel="stylesheet" type="text/css" href="styles.css">
</head>
<body>
    <h2>Welcome, <%= name %></h2>
    <form method="post" action="LogoutServlet">
        <input type="submit" value="Logout">
    </form>
</body>
</html>