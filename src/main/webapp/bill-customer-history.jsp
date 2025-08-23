<%@ page import="com.pahanaedu.model.Bill" %>
<%@ page import="com.pahanaedu.model.BillItem" %>
<%@ page import="com.pahanaedu.model.Items" %>
<%@ page import="java.text.NumberFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.dao.ItemDAO" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  // Safely fetch objects from request scope
  Object custObj = request.getAttribute("customer");
  Object billsObj = request.getAttribute("bills");
  NumberFormat nf = NumberFormat.getInstance();

  com.pahanaedu.model.Customer customer = (custObj != null) ? (com.pahanaedu.model.Customer) custObj : null;
  List<Bill> bills = (billsObj != null) ? (List<Bill>) billsObj : null;
%>
<html>
<head>
  <title>Customer Bill History</title>
  <link rel="stylesheet" href="assets/styles.css">
  <style>
    body {
      font-family: 'Inter', sans-serif;
      background: #f3f4f6;
      padding: 20px;
    }
    h2, h3 {
      color: #1e3a8a;
    }
    table {
      width: 100%;
      border-collapse: collapse;
      margin-bottom: 25px;
      background: #fff;
      border-radius: 8px;
      overflow: hidden;
      box-shadow: 0 4px 12px rgba(0,0,0,0.05);
    }
    table th {
      background: #2563eb;
      color: #fff;
      text-transform: uppercase;
      font-size: 0.85rem;
      letter-spacing: 0.05em;
      padding: 10px;
    }
    table td {
      padding: 10px;
      text-align: center;
      border-bottom: 1px solid #e5e7eb;
    }
    table tr:nth-child(even) {
      background-color: #f9fafb;
    }
    table tr:hover {
      background-color: #e0f2fe;
    }
    button {
      background: #2563eb;
      color: #fff;
      border: none;
      border-radius: 6px;
      padding: 10px 16px;
      margin: 5px;
      cursor: pointer;
      transition: all 0.2s ease;
    }
    button:hover {
      background: #1d4ed8;
      transform: translateY(-2px);
      box-shadow: 0 4px 12px rgba(0,0,0,0.1);
    }
    .bill-item-image {
      width: 60px;
      height: 60px;
      object-fit: cover;
      border-radius: 6px;
    }
    @media print {
      body * { visibility: hidden; }
      #printableBill, #printableBill * { visibility: visible; }
      #printableBill { position: absolute; left: 0; top: 0; width: 100%; }
      button, a { display: none !important; }
    }
  </style>
</head>
<body>
<div style="text-align:center; margin-bottom:20px;">
  <button type="button" onclick="window.location.href='bill-history.jsp'">Back to Bill History</button>
  <button type="button" onclick="window.location.href='dashboard.jsp'">Go to Dashboard</button>
</div>

<h2>Bill History for <%= (customer != null) ? customer.getFullName() : "Unknown Customer" %></h2>

<div id="printableBill">
  <% if (bills != null && !bills.isEmpty()) { %>
  <% for (Bill bill : bills) { %>
  <h3>Bill No: <%= bill.getBillId() %> | Date: <%= (bill.getBillDate() != null) ? bill.getBillDate() : "N/A" %></h3>
  <table>
    <tr>
      <th>Total Amount</th>
      <td>LKR <%= nf.format(bill.getTotalAmount()) %></td>
    </tr>
    <tr>
      <th>Payment Method</th>
      <td><%= bill.getPaymentMethod() %></td>
    </tr>
  </table>

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
      ItemDAO itemDAO = new ItemDAO(); // Add this line before the loop
      for (BillItem item : bill.getItems()) {
        Items book = itemDAO.getItemById(item.getItemId()); // Fetch Items object by itemId
    %>
    <tr>
      <td>
        <% if (book != null && book.getItemImage() != null) { %>
        <img src="ItemImageServlet?item_id=<%= book.getItem_id() %>"
             alt="Item Image" class="bill-item-image" />
        <% } else { %>
        <span>No Image</span>
        <% } %>
      </td>
      <td><%= (book != null) ? book.getItem_name() : "N/A" %></td>
      <td><%= item.getQuantity() %></td>
      <td>LKR <%= nf.format(item.getUnitPrice()) %></td>
      <td>LKR <%= nf.format(item.getTotalPrice()) %></td>
    </tr>
    <% } %>
    </tbody>
  </table>
  <% } %>
  <% } else { %>
  <h3>No bills found for this customer.</h3>
  <% } %>
</div>

<div style="text-align:center; margin-top:20px;">
  <button onclick="printBill()">Print Bill History</button>
  <button type="button" onclick="window.location.href='bill-history.jsp'">Back to Bill History</button>
  <button type="button" onclick="window.location.href='dashboard.jsp'">Go to Dashboard</button>
</div>

<script>
  function printBill() {
    var printContents = document.getElementById('printableBill').innerHTML;
    var originalContents = document.body.innerHTML;
    document.body.innerHTML = printContents;
    window.print();
    document.body.innerHTML = originalContents;
  }
</script>
</body>
</html>
