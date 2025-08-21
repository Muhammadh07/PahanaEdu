<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.dao.CustomerDAO" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="com.pahanaedu.dao.ItemDAO" %>
<%@ page import="com.pahanaedu.model.Items" %>

<html>
<head>
  <title>Bill Details</title>
  <style>
    body {
      font-family: Arial, sans-serif;
      background: #f9f9f9;
      padding: 20px;
    }
    table {
      border-collapse: collapse;
      width: 50%;
      margin-bottom: 20px;
    }
    td {
      padding: 8px;
    }
    select, input, button {
      padding: 8px;
      border-radius: 5px;
      border: 1px solid #ccc;
    }
    button {
      background: #007bff;
      color: white;
      cursor: pointer;
    }
    button:hover {
      background: #0056b3;
    }
  </style>
</head>
<body>

<h2>Create Bill</h2>

<form action="BillServlet" method="post">

  <table>
    <tr>
      <td><strong>Customer:</strong></td>
      <td>
        <select name="customerId" required>
          <%
            CustomerDAO customerDAO = new CustomerDAO();
            List<Customer> customers = customerDAO.getAllCustomers();
            for(Customer c : customers){
          %>
          <option value="<%= c.getCustomerId() %>"><%= c.getFullName() %></option>
          <% } %>
        </select>
      </td>
    </tr>
  </table>

  <h3>Items</h3>
  <div id="itemTemplate">
    <select name="itemId">
      <%
        ItemDAO itemDAO = new ItemDAO();
        List<Items> items = itemDAO.getAllItems();
        for(Items i : items){
          int stk = i.getStock_quantity();
          String label = i.getItem_name() + (stk==0 ? " (Out of Stock)" : "");
      %>
      <option value="<%= i.getItem_id() %>"><%= label %></option>
      <% } %>
    </select>
    <input type="number" name="quantity" placeholder="Qty" min="1">
  </div>

  <br>
  <button type="submit">Save Bill</button>

</form>

</body>
</html>
