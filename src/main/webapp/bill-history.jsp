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
<%@ page import="java.util.*, com.pahanaedu.model.Customer, com.pahanaedu.model.Bill, com.pahanaedu.dao.BillDAO" %>

<html>
<head>
  <title>Bill History</title>
  <style>
    body {
      font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
      background-color: #f4f6f8;
      color: #333;
      margin: 0;
      padding: 20px;
    }

    h2 {
      text-align: center;
      margin-bottom: 30px;
      color: #1e3a8a;
      font-size: 2rem;
    }

    table {
      width: 100%;
      border-collapse: collapse;
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
      border-radius: 10px;
      overflow: hidden;
      background-color: #fff;
    }

    thead {
      background-color: #1e3a8a;
      color: #fff;
    }

    th, td {
      padding: 15px 20px;
      text-align: left;
    }

    tbody tr {
      border-bottom: 1px solid #e2e8f0;
      transition: background 0.3s;
    }

    tbody tr:hover {
      background-color: #e0f2fe;
    }

    td:last-child {
      font-weight: bold;
      color: #0f172a;
    }

    @media screen and (max-width: 768px) {
      table, thead, tbody, th, td, tr {
        display: block;
      }

      thead tr {
        display: none;
      }

      tbody tr {
        margin-bottom: 20px;
        border-radius: 10px;
        background-color: #fff;
        padding: 15px;
        box-shadow: 0 2px 8px rgba(0,0,0,0.1);
      }

      td {
        display: flex;
        justify-content: space-between;
        padding: 10px 0;
        border: none;
      }

      td::before {
        content: attr(data-label);
        font-weight: 600;
        color: #1e3a8a;
      }
    }
  </style>
</head>
<body>

<h2>Bill History</h2>

<table>
  <thead>
  <tr>
    <th>Customer Name</th>
    <th>Total Amount</th>
  </tr>
  </thead>
  <tbody>
  <%
    java.text.NumberFormat nf = java.text.NumberFormat.getInstance();
    List<Customer> customers = (List<Customer>) request.getAttribute("customers");

    if(customers != null) {
      for (Customer customer : customers) {
        List<Bill> bills = BillDAO.getBillsByCustomer(customer.getCustomerId());
        double totalAmount = 0.0;

        if (bills != null && !bills.isEmpty()) {
          for (Bill bill : bills) {
            totalAmount += bill.getTotalAmount();
          }
        }
  %>
  <tr>
    <td data-label="Customer Name"><%= customer.getFullName() %></td>
    <td data-label="Total Amount"><%= nf.format(totalAmount) %></td>
  </tr>
  <%
    }
  } else {
  %>
  <tr>
    <td colspan="2" style="text-align:center;">No customers found.</td>
  </tr>
  <% } %>
  </tbody>
</table>

</body>
</html>
