package com.pahanaedu.servlet;

import com.pahanaedu.dao.UserDAO;
import com.pahanaedu.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;


//@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Forward to login page
        req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Basic validation
        String username = req.getParameter("username");
        String password = req.getParameter("password");

        if (username == null || username.trim().isEmpty()
                || password == null || password.trim().isEmpty()) {
            req.setAttribute("error", "Username and Password are required.");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
            return;
        }

        try {
            User user = userDAO.findByUsername(username.trim());
            if (user == null) {
                req.setAttribute("error", "Invalid username or password.");
                req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
                return;
            }

            String storedHash = user.getPasswordHash();
            if (storedHash == null || !BCrypt.checkpw(password, storedHash)) {
                // Wrong password
                req.setAttribute("error", "Invalid username or password.");
                req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
                return;
            }

            // Successful login: create session
            HttpSession session = req.getSession(true);
            session.setAttribute("user", user);
            session.setMaxInactiveInterval(30 * 60); // 30 minutes

            // Set secure cookie example (if using HTTPS)
            Cookie loginCookie = new Cookie("PahanaUser", username);
            loginCookie.setHttpOnly(true);
            // loginCookie.setSecure(true); // enable when using HTTPS
            loginCookie.setMaxAge(30 * 60);
            resp.addCookie(loginCookie);

            resp.sendRedirect(req.getContextPath() + "/welcome");

        } catch (Exception e) {
            e.printStackTrace();
            req.setAttribute("error", "An internal error occurred. Please try again later.");
            req.getRequestDispatcher("/WEB-INF/views/login.jsp").forward(req, resp);
        }
    }
}
