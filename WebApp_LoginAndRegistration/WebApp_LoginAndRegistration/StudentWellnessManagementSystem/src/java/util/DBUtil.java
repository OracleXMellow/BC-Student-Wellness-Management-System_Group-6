///// Manage databse connection /////
package util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {
    ///// PostgreSQL connection - change portname if needed /////
    private static final String URL = "jdbc:postgresql://localhost:5432/StudentWellnessManagementSystem";
    private static final String USER = "postgres"; // Replace with your username
    private static final String PASSWORD = "user123"; // Replace with your password

    ///// Connection to the PostgreSQL database /////
    public static Connection getConnection() throws SQLException {
        try {
            Class.forName("org.postgresql.Driver"); //Implemented because of errors
        } catch (ClassNotFoundException e) {
            throw new SQLException("PostgreSQL JDBC Driver not found.", e);
        }

        return DriverManager.getConnection(URL, USER, PASSWORD); //Returns live connection object.
    }
}
