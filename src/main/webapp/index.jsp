<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Login - PahanaEdu</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f6f8;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .login-box {
            background: white;
            padding: 20px 30px;
            border-radius: 10px;
            box-shadow: 0 3px 8px rgba(0,0,0,0.2);
            width: 300px;
        }
        h2 {
            text-align: center;
        }
        input {
            width: 100%;
            padding: 8px;
            margin-top: 6px;
            margin-bottom: 12px;
        }
        .error {
            color: red;
            font-size: 0.9em;
            margin-bottom: 10px;
            text-align: center;
        }
        button {
            width: 100%;
            background: #4CAF50;
            color: white;
            padding: 10px;
            border: none;
            cursor: pointer;
            border-radius: 4px;
        }
        button:hover {
            background: #45a049;
        }
    </style>
</head>
<body>

<div class="login-box">
    <h2>Login</h2>

    <form action="${pageContext.request.contextPath}/login" method="post">
        <% if (request.getAttribute("error") != null) { %>
        <div class="error"><%= request.getAttribute("error") %></div>
        <% } %>

        <label>Username</label>
        <input type="text" name="username" placeholder="Enter username" required>

        <label>Password</label>
        <input type="password" name="password" placeholder="Enter password" required>

        <button type="submit">Login</button>
    </form>
</div>

</body>
</html>
