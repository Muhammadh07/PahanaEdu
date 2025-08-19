<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Add New Customer</title>
</head>
<body>
<h2>Add New Customer</h2>

<form action="addCustomer" method="post">
  <label>Account Number:</label>
  <input type="text" name="accountNumber" required><br><br>

  <label>Name:</label>
  <input type="text" name="name" required><br><br>

  <label>Address:</label>
  <input type="text" name="address"><br><br>

  <label>Phone:</label>
  <input type="text" name="phone" required><br><br>

  <label>Units Consumed:</label>
  <input type="text" name="unitsConsumed" required><br><br>

  <button type="submit">Add Customer</button>
</form>

<!-- ✅ Display messages -->
<% if (request.getAttribute("message") != null) { %>
<p style="color:green;"><%= request.getAttribute("message") %></p>
<% } %>

<% if (request.getAttribute("error") != null) { %>
<p style="color:red;"><%= request.getAttribute("error") %></p>
<% } %>

</body>
</html>
