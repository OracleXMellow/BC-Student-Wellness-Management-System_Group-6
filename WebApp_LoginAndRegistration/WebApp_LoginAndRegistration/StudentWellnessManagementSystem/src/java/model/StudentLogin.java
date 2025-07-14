package model;

import java.sql.*;
import util.DBUtil;
import util.PasswordUtil;

public class StudentLogin {
    ///// Check if the email and password exists /////
    public static boolean validate(String email, String password) {
        boolean isValid = false;

        ///// Hash the password before comparing it with the database /////
        String hashedPassword = PasswordUtil.hashPassword(password);

        String sql = "SELECT * FROM users WHERE email = ? AND password = ?";

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            ///// Set SQL parameters /////
            stmt.setString(1, email);
            stmt.setString(2, hashedPassword);

            ResultSet rs = stmt.executeQuery(); // Run the query
            
            if (rs.next()) {
                isValid = true;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return isValid;
    }
}
