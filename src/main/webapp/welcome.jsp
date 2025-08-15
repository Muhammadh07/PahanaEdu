<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.User" %>
<%
  User loggedUser = (User) session.getAttribute("user");
  if (loggedUser == null) {
    response.sendRedirect(request.getContextPath() + "/login");
    return;
  }
%>
<!DOCTYPE html>
<html>
<head>
  <title>Welcome - PahanaEdu</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background-color: #eef2f3;
      padding: 20px;
    }
    .header {
      background: #4CAF50;
      color: white;
      padding: 15px;
      text-align: center;
    }
    .content {
      margin-top: 20px;
      text-align: center;
    }
    .logout {
      margin-top: 20px;
      background: #f44336;
      color: white;
      padding: 8px 12px;
      text-decoration: none;
      border-radius: 5px;
    }
    .logout:hover {
      background: #d32f2f;
    }
  </style>
</head>
<body>

<div class="header">
  <h1>Welcome to PahanaEdu</h1>
</div>

<div class="content">
  <h2>Hello, <%= loggedUser.getFullName() != null ? loggedUser.getFullName() : loggedUser.getUsername() %>!</h2>
  <p>You have successfully logged in.</p>

  <a class="logout" href="<%= request.getContextPath() %>/logout">Logout</a>
</div>

</body>
</html>
