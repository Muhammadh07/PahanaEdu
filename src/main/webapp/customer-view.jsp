<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%
  Customer cust = (Customer) request.getAttribute("customer");
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <title>Customer View</title>
  <link href="https://cdn.jsdelivr.net/npm/tailwindcss@3.3.2/dist/tailwind.min.css" rel="stylesheet">
</head>
<body class="bg-gray-100 min-h-screen flex items-center justify-center">
  <div class="w-full max-w-md bg-white rounded-lg shadow p-6">
    <h1 class="text-2xl font-bold text-center text-blue-700 mb-4">Customer Details</h1>
    <div class="mb-6 text-center text-gray-600">
      Account overview for
      <span class="font-semibold text-blue-600">
        <%= cust != null ? cust.getFullName() : "N/A" %>
      </span>
    </div>
    <div class="space-y-4">
      <div class="flex justify-between border-b pb-2">
        <span class="text-gray-500">Account Number:</span>
        <span class="font-medium text-gray-800"><%= cust != null ? cust.getAccountNumber() : "N/A" %></span>
      </div>
      <div class="flex justify-between border-b pb-2">
        <span class="text-gray-500">Customer ID:</span>
        <span class="font-medium text-gray-800"><%= cust != null ? cust.getCustomerId() : "N/A" %></span>
      </div>
      <div class="flex justify-between border-b pb-2">
        <span class="text-gray-500">Address:</span>
        <span class="font-medium text-gray-800"><%= cust != null ? cust.getAddress() : "N/A" %></span>
      </div>
      <div class="flex justify-between border-b pb-2">
        <span class="text-gray-500">Contact No:</span>
        <span class="font-medium text-gray-800"><%= cust != null ? cust.getContactNo() : "N/A" %></span>
      </div>
      <div class="flex justify-between">
        <span class="text-gray-500">Unit Consumed:</span>
        <span class="font-medium text-gray-800"><%= cust != null ? cust.getUnitConsumed() : "N/A" %></span>
      </div>
    </div>
    <div class="mt-6 flex justify-between">
      <a href="dashboard.jsp" class="px-4 py-2 rounded bg-gray-200 text-gray-700 hover:bg-gray-300 text-sm">← Back to List</a>
      <a href="editCustomer?id=<%= cust != null ? cust.getCustomerId() : 0 %>" class="px-4 py-2 rounded bg-blue-600 text-white hover:bg-blue-700 text-sm">Edit Details</a>
    </div>
  </div>
  <div class="overflow-x-auto mt-8">
    <table class="min-w-full bg-white border border-gray-200 rounded-lg">
      <thead class="bg-blue-600 text-white">
        <tr>
          <th class="py-2 px-4 border-b">Customer ID</th>
          <th class="py-2 px-4 border-b">Full Name</th>
          <th class="py-2 px-4 border-b">Account Number</th>
          <th class="py-2 px-4 border-b">Address</th>
          <th class="py-2 px-4 border-b">Contact No</th>
          <th class="py-2 px-4 border-b">Unit Consumed</th>
        </tr>
      </thead>
      <tbody>
        <tr class="hover:bg-gray-50">
          <td class="py-2 px-4 border-b text-center"><%= cust != null ? cust.getCustomerId() : "N/A" %></td>
          <td class="py-2 px-4 border-b text-center"><%= cust != null ? cust.getFullName() : "N/A" %></td>
          <td class="py-2 px-4 border-b text-center"><%= cust != null ? cust.getAccountNumber() : "N/A" %></td>
          <td class="py-2 px-4 border-b text-center"><%= cust != null ? cust.getAddress() : "N/A" %></td>
          <td class="py-2 px-4 border-b text-center"><%= cust != null ? cust.getContactNo() : "N/A" %></td>
          <td class="py-2 px-4 border-b text-center"><%= cust != null ? cust.getUnitConsumed() : "N/A" %></td>
        </tr>
      </tbody>
    </table>
  </div>
</body>
</html>
