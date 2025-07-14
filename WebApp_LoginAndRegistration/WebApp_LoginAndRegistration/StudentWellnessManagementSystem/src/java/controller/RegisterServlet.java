package controller;

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import model.StudentSave;

public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html");
        PrintWriter out = response.getWriter();

        ///// Get input values from the form /////
        String name = request.getParameter("name");
        String surname = request.getParameter("surname");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String password = request.getParameter("password");
        String studentNumber = request.getParameter("student_number");

        ///// Input validation /////
        if (!isValidEmail(email)) {
            out.println("<h3 style='color:red;'>Invalid email format.</h3>");
            return;
        }

        if (!isValidPassword(password)) {
            out.println("<h3 style='color:red;'>Password must be at least 6 characters.</h3>");
            return;
        }

        if (!isValidPhone(phone)) {
            out.println("<h3 style='color:red;'>Phone number must be 10 digits.</h3>");
            return;
        }

        ///// Check if the email already exists /////
        if (StudentSave.emailExists(email)) {
            out.println("<h3 style='color:red;'>Email already exists. Please use a different one.</h3>");
            return;
        }

        ///// Save the student in the database /////
        boolean success = StudentSave.registerStudent(studentNumber, name, surname, email, phone, password);

        ///// Feedback whether registration is successful or not /////
        if (success) {
            out.println("<h3 style='color:green;'>Registration successful.</h3>");
        } else {
            out.println("<h3 style='color:red;'>Registration failed. Please try again.</h3>");
        }
    }

    ///// Validate email using regex /////
    private boolean isValidEmail(String email) {
        return email != null && email.matches("^[\\w.-]+@[\\w.-]+\\.[A-Za-z]{2,}$");
    }
    
    ///// Validate password length /////
    private boolean isValidPassword(String password) {
        return password != null && password.length() >= 6;
    }
    
    ///// Validate phone number /////
    private boolean isValidPhone(String phone) {
        return phone != null && phone.matches("\\d{10}");
    }
}
