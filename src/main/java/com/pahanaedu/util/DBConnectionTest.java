package com.pahanaedu.util;

import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

public class DBConnectionTest {
    public static void main(String[] args) {
        try {
            // Get connection
            Connection conn = com.pahana.util.DBConnection.getInstance().getConnection();
            System.out.println("✅ Database connected successfully!");

            // Optional: run a simple query to test
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT id, username FROM users LIMIT 5");

            while (rs.next()) {
                int id = rs.getInt("id");
                String username = rs.getString("username");
                System.out.println("User ID: " + id + ", Username: " + username);
            }

            conn.close();
        } catch (Exception e) {
            System.out.println("❌ Database connection failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
