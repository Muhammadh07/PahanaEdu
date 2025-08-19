<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="com.pahanaedu.model.Bill" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.dao.BillDAO" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 21/08/2025
  Time: 06:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
  <title>Bill History</title>
  <link rel="stylesheet" href="assets/styles.css">
</head>
<body>
<h2>Bill History</h2>
<table border="1" cellpadding="8" cellspacing="0">
  <thead>
  <tr>
    <th>Customer Name</th>
    <th>Contact Number</th>
    <th>Total Amount</th>
    <th>Action</th>
  </tr>
  </thead>
  <tbody>
  <% java.text.NumberFormat nf = java.text.NumberFormat.getInstance(); %>
  <% for (Customer customer : customers) {
    List<Bill> bills = BillDAO.getBillsByCustomer(customer.getCustomerId());
    double totalAmount = 0.0;
    if (bills != null && !bills.isEmpty()) {
      for (Bill bill : bills) {
        totalAmount += bill.getTotalAmount();
      }
    }
    if (bills != null && !bills.isEmpty()) { %>
  <tr>
    <td><%= customer.getFullName() %></td>
    <td><%= customer.getContactNo() %></td>
    <td>LKR <%= nf.format(totalAmount) %></td>
    <td><a href="bill-customer-history.jsp?customerId=<%= customer.getCustomerId() %>">View</a></td>
  </tr>
  <% } else { %>
  <tr>
    <td><%= customer.getFullName() %></td>
    <td><%= customer.getContactNo() %></td>
    <td colspan="2">No bill</td>
  </tr>
  <% } } %>
  </tbody>
</table>
<br>
<button type="button" onclick="window.location.href='dashboard.jsp'">Back to Dashboard</button>
</body>
</html>
