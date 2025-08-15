package com.pahanaedu.dao;

import com.pahanaedu.model.User;


import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDAO {
    private static final String GET_USER_BY_USERNAME =
            "SELECT id, username, password_hash, full_name, role FROM users WHERE username = ?";

    public User findByUsername(String username) throws SQLException, ClassNotFoundException {
        try (Connection conn = com.pahana.util.DBConnection.getInstance().getConnection();
             PreparedStatement ps = conn.prepareStatement(GET_USER_BY_USERNAME)) {

            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    User user = new User();
                    user.setId(rs.getInt("id"));
                    user.setUsername(rs.getString("username"));
                    user.setPasswordHash(rs.getString("password_hash"));
                    user.setFullName(rs.getString("full_name"));
                    user.setRole(rs.getString("role"));
                    return user;
                } else {
                    return null;
                }
            }
        }
    }
}
