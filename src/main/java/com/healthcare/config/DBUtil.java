package com.healthcare.config;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class DBUtil {

    private static String URL;
    private static String USER;
    private static String PASS;

    static {
        try {
            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Load database.properties from config folder in resources
            Properties props = new Properties();
            InputStream in = DBUtil.class.getClassLoader().getResourceAsStream("config/database.properties");

            if (in == null) {
                throw new RuntimeException("❌ database.properties not found in classpath under 'config'!");
            }

            props.load(in);

            URL = props.getProperty("db.url");
            USER = props.getProperty("db.user");
            PASS = props.getProperty("db.password");

        } catch (ClassNotFoundException e) {
            System.err.println("❌ MySQL JDBC Driver not found!");
            e.printStackTrace();
        } catch (Exception e) {
            System.err.println("❌ Failed to load database properties!");
            e.printStackTrace();
        }
    }

    // Get database connection
    public static Connection getConnection() {
        try {
            return DriverManager.getConnection(URL, USER, PASS);
        } catch (SQLException e) {
            System.err.println("❌ Database connection failed!");
            e.printStackTrace();
            return null;
        }
    }

    // Close connection safely
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try {
                conn.close();
            } catch (SQLException e) {
                System.err.println("⚠️ Error closing database connection!");
                e.printStackTrace();
            }
        }
    }
}
