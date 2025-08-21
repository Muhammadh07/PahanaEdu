<%@ page import="com.pahanaedu.dao.CustomerDAO" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.dao.ItemDAO" %>
<%@ page import="com.pahanaedu.model.Items" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 21/08/2025
  Time: 06:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Create Bill</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.2/dist/tailwind.min.css" rel="stylesheet">
  <script>
    function addRow() {
      let table = document.getElementById("itemsTable").getElementsByTagName('tbody')[0];
      let row = table.insertRow();

      let itemCell = row.insertCell(0);
      let qtyCell = row.insertCell(1);
      let priceCell = row.insertCell(2);
      let totalCell = row.insertCell(3);
      let actionCell = row.insertCell(4);

      itemCell.innerHTML = document.getElementById("itemTemplate").innerHTML;
      qtyCell.innerHTML = "<input type='number' name='quantity' value='1' min='1' oninput='updateRowTotal(this)'/>";
      priceCell.innerHTML = "<input type='number' name='unitPrice' value='0' step='0.01' readonly/>";
      totalCell.innerHTML = "<input type='text' name='rowTotal' value='0' readonly/>";
      actionCell.innerHTML = "<button type='button' onclick='removeRow(this)'>Remove</button>";

      // Add event listener for item selection
      let itemSelect = itemCell.querySelector("select[name='itemId']");
      itemSelect.addEventListener('change', function() {
        fetchUnitPriceAndUpdateRow(itemSelect);
      });
      // Trigger price fetch for initial selection
      fetchUnitPriceAndUpdateRow(itemSelect);
    }

    function fetchUnitPriceAndUpdateRow(itemSelect) {
      let row = itemSelect.parentNode.parentNode;
      let itemId = itemSelect.value;
      let priceInput = row.querySelector("input[name='unitPrice']");
      if (!itemId) {
        priceInput.value = 0;
        updateRowTotal(priceInput);
        return;
      }
      // AJAX request to get price
      var xhr = new XMLHttpRequest();
      xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
          try {
            var resp = JSON.parse(xhr.responseText);
            priceInput.value = resp.price;
            updateRowTotal(priceInput);
          } catch (e) {
            priceInput.value = 0;
            updateRowTotal(priceInput);
          }
        }
      };
      xhr.open('GET', 'getItemPrice?itemId=' + encodeURIComponent(itemId), true);
      xhr.send();
    }

    function removeRow(btn) {
      let row = btn.parentNode.parentNode;
      row.parentNode.removeChild(row);
      updateTotal();
    }

    function updateRowTotal(input) {
      let row = input.parentNode.parentNode;
      let qty = row.querySelector("input[name='quantity']").value;
      let price = row.querySelector("input[name='unitPrice']").value;
      let total = qty * price;
      row.querySelector("input[name='rowTotal']").value = total.toFixed(2);
      updateTotal();
    }

    function updateTotal() {
      let totals = document.getElementsByName("rowTotal");
      let sum = 0;
      for (let i = 0; i < totals.length; i++) {
        sum += parseFloat(totals[i].value || 0);
      }
      document.getElementById("totalAmount").value = sum.toFixed(2);
    }

    function showCustomerModal() {
      document.getElementById('customerModal').classList.remove('hidden');
    }

    function closeCustomerModal() {
      document.getElementById('customerModal').classList.add('hidden');
    }

    function addCustomerAJAX() {
      var name = document.getElementById('newCustomerName').value;
      var contact = document.getElementById('newCustomerContact').value;
      var account = document.getElementById('newCustomerAccount').value;
      var address = document.getElementById('newCustomerAddress').value;
      var unit = document.getElementById('newCustomerUnit').value;
      if (!name || !account) { alert('Name and Account Number are required'); return; }
      var xhr = new XMLHttpRequest();
      xhr.onreadystatechange = function() {
        if (xhr.readyState === 4 && xhr.status === 200) {
          try {
            var resp = JSON.parse(xhr.responseText);
            if (resp.success) {
              var select = document.getElementsByName('customerId')[0];
              var opt = document.createElement('option');
              opt.value = resp.id;
              opt.text = resp.name;
              select.appendChild(opt);
              select.value = resp.id;
              closeCustomerModal();
            } else {
              alert('Failed to add customer');
            }
          } catch (e) { alert('Error adding customer'); }
        }
      };
      xhr.open('POST', 'AddCustomerServlet', true);
      xhr.setRequestHeader('Content-Type', 'application/x-www-form-urlencoded');
      xhr.send('name=' + encodeURIComponent(name) + '&contact=' + encodeURIComponent(contact) + '&account=' + encodeURIComponent(account) + '&address=' + encodeURIComponent(address) + '&unit=' + encodeURIComponent(unit));
    }

    function resetForm() {
      let table = document.getElementById("itemsTable").getElementsByTagName('tbody')[0];
      // Remove all rows except the first
      while (table.rows.length > 1) {
        table.deleteRow(1);
      }
      // Reset first row inputs
      let firstRow = table.rows[0];
      if (firstRow) {
        firstRow.querySelector("select[name='itemId']").selectedIndex = 0;
        firstRow.querySelector("input[name='quantity']").value = 1;
        firstRow.querySelector("input[name='unitPrice']").value = 0;
        firstRow.querySelector("input[name='rowTotal']").value = 0;
      }
      updateTotal();
    }
  </script>
</head>
<body class="bg-gray-100 min-h-screen py-8">
<div class="max-w-3xl mx-auto bg-white rounded-lg shadow p-6">
  <div class="flex justify-between mb-6">
    <button type="button" onclick="window.location.href='dashboard.jsp'" class="px-4 py-2 bg-gray-200 text-gray-700 rounded hover:bg-gray-300">Back to Dashboard</button>
    <button type="button" onclick="resetForm()" class="px-4 py-2 bg-red-100 text-red-700 rounded hover:bg-red-200">Reset</button>
  </div>
  <h2 class="text-2xl font-bold text-center text-blue-700 mb-6">Create New Bill</h2>
  <form action="addBill" method="post" class="space-y-6">
    <div class="grid grid-cols-1 md:grid-cols-2 gap-4">
      <div>
        <label class="block text-gray-700 font-medium mb-1">Customer</label>
        <div class="flex gap-2">
          <select name="customerId" required class="w-full px-3 py-2 border rounded">
            <% CustomerDAO customerDAO = new CustomerDAO(); List<Customer> customers = customerDAO.getAllCustomers(); for(Customer c : customers){ %>
            <option value="<%= c.getCustomerId() %>"><%= c.getFullName() %></option>
            <% } %>
          </select>
          <button type="button" onclick="showCustomerModal()" class="px-3 py-2 bg-blue-100 text-blue-700 rounded hover:bg-blue-200">Add</button>
        </div>
      </div>
      <div>
        <label class="block text-gray-700 font-medium mb-1">User ID</label>
        <input type="number" name="userId" required class="w-full px-3 py-2 border rounded"/>
      </div>
      <div>
        <label class="block text-gray-700 font-medium mb-1">Payment Method</label>
        <select name="paymentMethod" required class="w-full px-3 py-2 border rounded">
          <option value="Cash">Cash</option>
          <option value="Card">Card</option>
          <option value="Online">Online</option>
        </select>
      </div>
    </div>
    <div>
      <h3 class="text-lg font-semibold text-blue-600 mb-2 text-center">Bill Items</h3>
      <div class="overflow-x-auto">
        <table id="itemsTable" class="min-w-full bg-white border border-gray-200 rounded-lg">
          <thead class="bg-blue-600 text-white">
          <tr>
            <th class="py-2 px-4 border-b">Item</th>
            <th class="py-2 px-4 border-b">Quantity</th>
            <th class="py-2 px-4 border-b">Unit Price</th>
            <th class="py-2 px-4 border-b">Total</th>
            <th class="py-2 px-4 border-b">Action</th>
          </tr>
          </thead>
          <tbody></tbody>
        </table>
      </div>
      <div class="flex justify-center mt-2">
        <button type="button" onclick="addRow()" class="px-4 py-2 bg-green-100 text-green-700 rounded hover:bg-green-200">+ Add Item</button>
      </div>
    </div>
    <div class="flex justify-end items-center gap-4">
      <label class="text-gray-700 font-medium">Total Amount:</label>
      <input type="text" id="totalAmount" name="totalAmount" readonly class="w-32 px-3 py-2 border rounded bg-gray-50"/>
    </div>
    <div class="flex justify-center">
      <button type="submit" class="px-6 py-2 bg-blue-600 text-white rounded hover:bg-blue-700 font-semibold">Save Bill</button>
    </div>
  </form>
</div>
<!-- Hidden item dropdown template -->
<div id="itemTemplate" style="display:none;">
  <select name="itemId" class="w-full px-2 py-1 border rounded">
    <% ItemDAO itemDAO = new ItemDAO(); List<Items> items = itemDAO.getAllItems(); for(Items i : items){ %>
    <option value="<%= i.getItem_id() %>"><%= i.getItem_name() %></option>
    <% } %>
  </select>
</div>
<!-- Customer Modal -->
<div id="customerModal" class="fixed inset-0 flex items-center justify-center bg-black bg-opacity-40 z-50 hidden">
  <div class="bg-white rounded-lg shadow-lg p-6 w-full max-w-sm relative">
    <button type="button" onclick="closeCustomerModal()" class="absolute top-2 right-2 text-gray-400 hover:text-gray-700 text-xl">&times;</button>
    <h3 class="text-lg font-bold mb-4 text-blue-700">Add New Customer</h3>
    <div class="space-y-2">
      <label class="block text-gray-700">Account Number</label>
      <input type="text" id="newCustomerAccount" required class="w-full px-3 py-2 border rounded">
      <label class="block text-gray-700">Name</label>
      <input type="text" id="newCustomerName" required class="w-full px-3 py-2 border rounded">
      <label class="block text-gray-700">Address</label>
      <input type="text" id="newCustomerAddress" class="w-full px-3 py-2 border rounded">
      <label class="block text-gray-700">Contact</label>
      <input type="text" id="newCustomerContact" class="w-full px-3 py-2 border rounded">
      <label class="block text-gray-700">Unit Consumed</label>
      <input type="number" id="newCustomerUnit" value="0" class="w-full px-3 py-2 border rounded">
    </div>
    <div class="mt-4 flex justify-end">
      <button type="button" onclick="addCustomerAJAX()" class="px-4 py-2 bg-blue-600 text-white rounded hover:bg-blue-700">Add Customer</button>
    </div>
  </div>
</div>
<script>
  // Modal show/hide logic for Tailwind
  function showCustomerModal() {
    document.getElementById('customerModal').classList.remove('hidden');
  }
  function closeCustomerModal() {
    document.getElementById('customerModal').classList.add('hidden');
  }
</script>
</body>
</html>