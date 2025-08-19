package com.pahanaedu.dao;

import com.pahanaedu.model.User;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    public static boolean validateUser(String username, String password) {
        boolean isValid = false;
        String sql = "SELECT COUNT(*) FROM users WHERE username = ? AND password = ?";

        try (Connection conn = com.pahanaedu.util.DBConnection.getConnection();
             PreparedStatement stmt = conn.prepareStatement(sql)) {

            stmt.setString(1, username);
            stmt.setString(2, password);

            try (ResultSet rs = stmt.executeQuery()) {
                if (rs.next() && rs.getInt(1) > 0) {
                    isValid = true;
                }
            }
        } catch (SQLException e) {
            System.err.println("Database connection or query error: " + e.getMessage());
            e.printStackTrace();
        }
        return isValid;
    }
}
