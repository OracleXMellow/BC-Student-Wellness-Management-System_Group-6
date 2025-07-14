<!DOCTYPE html>
    <head>
        <title>Register</title>
        <link rel="stylesheet" type="text/css" href="styles.css">
    </head>
    <body>
        <h2>Student Registration</h2>
        <form method="post" action="RegisterServlet">
            <input type="text" name="name" placeholder="Name" required><br><br>
            <input type="text" name="surname" placeholder="Surname" required><br><br>
            <input type="email" name="email" placeholder="Email" required><br><br>
            <input type="text" name="phone" placeholder="Phone (e.g. 0712345678)" pattern="0[0-9]{9}" required><br><br>
            <input type="password" name="password" placeholder="Password (min 6 chars)" minlength="6" required><br><br>
            <input type="text" name="student_number" placeholder="Student Number" required><br><br>
            <input type="submit" value="Register">
        </form>
    </body>
</html>