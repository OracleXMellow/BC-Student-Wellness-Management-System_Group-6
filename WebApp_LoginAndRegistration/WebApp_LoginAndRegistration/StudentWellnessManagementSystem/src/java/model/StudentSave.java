package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import util.DBUtil;
import util.PasswordUtil;

public class StudentSave {
    /////Check if email already exists in the users table /////
    public static boolean emailExists(String email) {
        boolean exists = false;
        String sql = "SELECT 1 FROM users WHERE email = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, email);
            ResultSet rs = stmt.executeQuery();

            if (rs.next()) {
                exists = true; // Email already exists if a row is returned
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return exists;
    }

    ///// Insert a new student and log it in user_audit table /////
    public static boolean registerStudent(String studentNumber, String name, String surname,
                                          String email, String phone, String password) {
        boolean success = false;

        ///// Hash the password before saving /////
        String hashedPassword = PasswordUtil.hashPassword(password);
        ///// Insert query for users table /////
        String userInsert = "INSERT INTO users (student_number, name, surname, email, phone, password) VALUES (?, ?, ?, ?, ?, ?)";
        ///// Insert query for user_audit table /////
        String auditInsert = "INSERT INTO user_audit (email, action) VALUES (?, 'REGISTER')";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt1 = conn.prepareStatement(userInsert);
             PreparedStatement stmt2 = conn.prepareStatement(auditInsert)) {

            ///// Insert into users table /////
            stmt1.setString(1, studentNumber);
            stmt1.setString(2, name);
            stmt1.setString(3, surname);
            stmt1.setString(4, email);
            stmt1.setString(5, phone);
            stmt1.setString(6, hashedPassword);

            ///// Insert into user_audit table /////
            stmt2.setString(1, email);

            int rows1 = stmt1.executeUpdate(); // Execute both queries
            int rows2 = stmt2.executeUpdate();

            if (rows1 > 0 && rows2 > 0) { // Both must succeed for it to work
                success = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return success;
    }
}
