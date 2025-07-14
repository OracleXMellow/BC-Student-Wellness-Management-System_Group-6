package util;

import java.security.MessageDigest;

public class PasswordUtil {
    ///// Hashes password uring SHA-256 /////
    public static String hashPassword(String password) {
        try {
            MessageDigest md = MessageDigest.getInstance("SHA-256");
            byte[] hash = md.digest(password.getBytes());

            // Convert byte array to hex string
            StringBuilder hexString = new StringBuilder();
            for (byte b : hash) {
                hexString.append(String.format("%02x", b));
            }
            return hexString.toString(); // Return final hash string for database storage

        } catch (Exception e) {
            throw new RuntimeException("Error hashing password", e); //Throw exception if hashing fails
        }
    }
}
