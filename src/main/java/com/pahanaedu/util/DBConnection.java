package com.pahanaedu.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://localhost:3306/pahanaEDU?useSSL=false&serverTimezone=UTC";
    private static final String USER = "root";
    private static final String PASS = "pass123"; // updated password
    private static DBConnection instance;

    private DBConnection() throws ClassNotFoundException {
        // Load driver
        Class.forName("com.mysql.cj.jdbc.Driver");
    }

    public static synchronized DBConnection getInstance() throws ClassNotFoundException {
        if (instance == null) {
            instance = new DBConnection();
        }
        return instance;
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASS);
    }
}
