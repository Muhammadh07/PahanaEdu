<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 21/08/2025
  Time: 04:37
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>

    <script>
        function togglePassword() {
        const passwordField = document.getElementById("password");
        const eyeIcon = document.getElementById("eyeIcon");
        if (passwordField.type === "password") {
            passwordField.type = "text";
            eyeIcon.innerHTML = "&#128065;"; // Eye open icon
        } else {
            passwordField.type = "password";
            eyeIcon.innerHTML = "&#128064;"; // Eye closed icon
        }
        }
    </script>
</head>
<style>
  body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f9;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
  }

  h2 {
    text-align: center;
    color: #333;
  }

  form {
    background-color: #fff;
    padding: 30px 40px;
    border-radius: 10px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    width: 300px;
  }

  label {
    display: block;
    margin-bottom: 5px;
    color: #555;
  }

  input[type="text"],
  input[type="password"] {
    width: 100%;
    padding: 8px 10px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box;
  }

  input[type="submit"] {
    width: 100%;
    padding: 10px;
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
  }

  input[type="submit"]:hover {
    background-color: #45a049;
  }

  button {
    vertical-align: middle;
    margin-left: 5px;
  }

  #eyeIcon {
    font-size: 18px;
  }

  div[style*="color:green"], div[style*="color:red"] {
    text-align: center;
    margin-top: 10px;
    font-weight: bold;
  }
  /* General body styles */
  body {
    font-family: Arial, sans-serif;
    background-color: #f4f4f9;
    display: flex;
    justify-content: center;
    align-items: center;
    height: 100vh;
    margin: 0;
  }

  /* Form container */
  form {
    background-color: #fff;
    padding: 30px 40px;
    border-radius: 10px;
    box-shadow: 0 4px 15px rgba(0,0,0,0.1);
    width: 300px;
  }

  /* Headings */
  h2 {
    text-align: center;
    color: #333;
    margin-bottom: 20px;
  }

  /* Labels */
  label {
    display: block;
    margin-bottom: 5px;
    color: #555;
  }

  /* Input fields */
  input[type="text"],
  input[type="password"] {
    width: 100%;
    padding: 8px 10px;
    margin-bottom: 15px;
    border: 1px solid #ccc;
    border-radius: 5px;
    box-sizing: border-box;
  }

  /* Submit button */
  input[type="submit"] {
    width: 100%;
    padding: 10px;
    background-color: #4CAF50;
    color: white;
    border: none;
    border-radius: 5px;
    cursor: pointer;
    font-size: 16px;
  }

  input[type="submit"]:hover {
    background-color: #45a049;
  }

  /* Eye icon button */
  button {
    vertical-align: middle;
    margin-left: 5px;
    background: none;
    border: none;
    cursor: pointer;
  }

  #eyeIcon {
    font-size: 18px;
  }

  /* Messages */
  div[style*="color:green"], div[style*="color:red"] {
    text-align: center;
    margin-top: 10px;
    font-weight: bold;
  }


</style>

<body>
<h2></h2>
<form method="post" action="register">
  <label for="username">Username:</label>
  <input type="text" id="username" name="username" required><br>
  <label for="password">Password:</label>
  <input type="password" id="password" name="password" required>
  <button type="button" onclick="togglePassword()" style="background:none;border:none;cursor:pointer;">
    <span id="eyeIcon">&#128065;</span>
  </button><br>

  <label for="fullName">Full Name:</label>
  <input type="text" id="fullName" name="fullName" required><br>
  <input type="submit" value="Register">
</form>
<div style="color:green;">
  <% if (request.getAttribute("message") != null) { %>
  <%= request.getAttribute("message") %>
  <% } %>
</div>
<div style="color:red;">
  <% if (request.getAttribute("error") != null) { %>
  <%= request.getAttribute("error") %>
  <% } %>
</div>
</body>
</html>
