<%@ page import="com.pahanaedu.dao.UserDAO" %>
<%@ page import="com.pahanaedu.dao.CustomerDAO" %>
<%@ page import="com.pahanaedu.dao.ItemDAO" %>
<%@ page import="com.pahanaedu.model.*" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 21/08/2025
  Time: 06:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Bill Summary</title>
  <style>
    body {
      font-family: 'Segoe UI', Arial, sans-serif;
      background: #f7f9fa;
      margin: 0;
      padding: 0;
    }
    header {
      background: #1976d2;
      color: #fff;
      padding: 20px 0 10px 0;
      text-align: center;
      box-shadow: 0 2px 8px rgba(0,0,0,0.04);
    }
    .logo {
      height: 48px;
      vertical-align: middle;
      margin-right: 10px;
    }
    main {
      max-width: 900px;
      margin: 30px auto 0 auto;
      background: #fff;
      border-radius: 12px;
      box-shadow: 0 2px 16px rgba(0,0,0,0.07);
      padding: 32px 24px 24px 24px;
    }
    table {
      border-collapse: separate;
      border-spacing: 0;
      width: 100%;
      margin: 20px 0;
      background: #fafbfc;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 1px 4px rgba(0,0,0,0.03);
    }
    th, td {
      border: none;
      padding: 12px 10px;
      text-align: center;
    }
    th {
      background: #e3eafc;
      color: #1a237e;
      font-weight: 600;
    }
    tr:nth-child(even) td {
      background: #f4f6fb;
    }
    tr:hover td {
      background: #e8f0fe;
    }
    .bill-item-image {
      width: 60px;
      height: 60px;
      object-fit: cover;
      border-radius: 6px;
      border: 1px solid #e0e0e0;
      background: #fff;
    }
    .summary-table td {
      text-align: left;
    }
    .summary-table th {
      text-align: right;
      width: 180px;
    }
    .total-row td {
      font-weight: bold;
      font-size: 1.1em;
      background: #e3eafc;
      color: #1a237e;
    }
    .actions {
      text-align: center;
      margin-top: 28px;
    }
    .btn {
      background: #1976d2;
      color: #fff;
      border: none;
      border-radius: 5px;
      padding: 10px 22px;
      margin: 0 8px 8px 0;
      font-size: 1em;
      cursor: pointer;
      transition: background 0.2s;
      box-shadow: 0 1px 4px rgba(25,118,210,0.08);
    }
    .btn:hover, .btn:focus {
      background: #1251a3;
      outline: none;
    }
    .link {
      color: #1976d2;
      text-decoration: none;
      margin: 0 8px;
      font-weight: 500;
      transition: color 0.2s;
    }
    .link:hover, .link:focus {
      color: #0d357a;
      text-decoration: underline;
    }
    @media (max-width: 700px) {
      main { padding: 10px 2vw; }
      table, th, td { font-size: 0.95em; }
      .summary-table th { width: 110px; }
    }
    @media print {
      body * { visibility: hidden !important; }
      #printableBill, #printableBill * { visibility: visible !important; }
      #printableBill { position: absolute; left: 0; top: 0; width: 100%; background: #fff; }
      .actions, .btn, .link { display: none !important; }
      .bill-item-image { width: 100px !important; height: 100px !important; object-fit: cover !important; }
      header { display: block !important; }
    }
  </style>
</head>
<body>
<header>
  <img src="assets/logo.png" alt="PahanaEdu Logo" class="logo"/>
  <span style="font-size:1.7em;font-weight:600;vertical-align:middle;">PahanaEdu Bill Summary</span>
</header>
<main>
<div class="actions">
  <button type="button" class="btn" onclick="window.location.href='dashboard.jsp'">Back to Dashboard</button>
</div>
<%
  Bill bill = (Bill) request.getAttribute("bill");
  Customer customer = null;
  User user = null;
  if (bill != null) {
    CustomerDAO customerDAO = new CustomerDAO();
    customer = customerDAO.getCustomerById(bill.getCustomerId());
    UserDAO userDAO = new UserDAO();
    user = userDAO.getUserById(bill.getUserId());
  }
  java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance(new java.util.Locale("en", "LK"));
  nf.setMinimumFractionDigits(2);
  nf.setMaximumFractionDigits(2);
%>
<h2 style="color:#1976d2;">Bill Created Successfully!</h2>
<% if (bill != null) { %>
<div id="printableBill">
  <h3 style="color:#1a237e;">Bill Summary</h3>
  <table class="summary-table">
    <tr><th>Bill No</th><td><%= bill.getBillId() %></td></tr>
    <tr><th>Customer</th><td><%= customer != null ? customer.getFullName() : "N/A" %></td></tr>
    <tr><th>User</th><td><%= user != null ? user.getFullName() : "N/A" %></td></tr>
    <tr><th>Date</th><td><%= bill.getBillDate() != null ? bill.getBillDate() : "N/A" %></td></tr>
    <tr><th>Total Amount</th><td><%= "LKR " + nf.format(bill.getTotalAmount()) %></td></tr>
    <tr><th>Payment Method</th><td><%= bill.getPaymentMethod() %></td></tr>
  </table>
  <h3 style="color:#1a237e;">Bill Items</h3>
  <table>
    <thead>
    <tr>
      <th>Item Image</th>
      <th>Item Name</th>
      <th>Quantity</th>
      <th>Unit Price</th>
      <th>Total</th>
    </tr>
    </thead>
    <tbody>
    <%
      ItemDAO itemDAO = new ItemDAO();
      double grossTotal = 0.0;
      for (BillItem item : bill.getItems()) {
        Items book = itemDAO.getItemById(item.getItemId());
        grossTotal += item.getTotalPrice();
    %>
    <tr>
      <td>
        <% if (book != null && book.getItemImage() != null) { %>
        <img src="ItemImageServlet?item_id=<%= book.getItem_id() %>" alt="Item Image" class="bill-item-image" />
        <% } else { %>
        <span style="color:#888;">No Image</span>
        <% } %>
      </td>
      <td><%= book != null ? book.getItem_name() : "N/A" %></td>
      <td><%= item.getQuantity() %></td>
      <td><%= "LKR " + nf.format(item.getUnitPrice()) %></td>
      <td><%= "LKR " + nf.format(item.getTotalPrice()) %></td>
    </tr>
    <% } %>
    </tbody>
    <tfoot>
      <tr class="total-row"><td colspan="4" style="text-align:right;">Gross Total:</td><td>LKR <%= nf.format(grossTotal) %></td></tr>
    </tfoot>
  </table>
</div>
<div class="actions">
  <button class="btn" onclick="printBill()">Print Bill</button>
  <a href="billForm.jsp" class="link">Create Another Bill</a>
  <a href="dashboard.jsp" class="link">Go to Dashboard</a>
</div>
<script>
  function printBill() {
    const before = document.body.innerHTML;
    const printable = document.getElementById('printableBill').outerHTML;
    const header = document.querySelector('header').outerHTML;
    document.body.innerHTML = header + printable;
    window.print();
    document.body.innerHTML = before;
  }
</script>
<% } else { %>
<h3 style="color:red; text-align:center;">No bill data found.</h3>
<% } %>
</main>
</body>
</html>
