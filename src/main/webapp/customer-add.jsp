<%@ page import="com.pahanaedu.model.Customer" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 21/08/2025
  Time: 06:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Customer Form</title>
  <meta name="viewport" content="width=device-width, initial-scale=1.0">

  <!-- Tailwind CSS CDN -->
  <script src="https://cdn.tailwindcss.com"></script>
  <script>
    tailwind.config = {
      theme: {
        extend: {
          colors: {
            primary: "#e50914", // Netflix-like red
            secondary: "#2563eb", // Tailwind blue
            accent: "#facc15" // Yellow highlight
          }
        }
      }
    }
  </script>

  <style>
    :root {
      --primary: #e50914;
      --secondary: #2563eb;
      --accent: #facc15;
    }

    @keyframes float {
      0% { transform: translateY(0px); }
      50% { transform: translateY(-6px); }
      100% { transform: translateY(0px); }
    }

    .icon-float { animation: float 3s ease-in-out infinite; }

    @keyframes pulse-slow {
      0%, 100% { transform: scale(1); opacity: 1; }
      50% { transform: scale(1.05); opacity: .95; }
    }

    .pulse-slow { animation: pulse-slow 3s infinite; }

    .glass-card {
      background: rgba(255, 255, 255, 0.75);
      backdrop-filter: blur(14px);
      border: 1px solid rgba(255,255,255,0.2);
    }
  </style>
</head>

<body class="min-h-screen bg-gradient-to-br from-gray-50 via-white to-gray-100 flex items-center justify-center p-4">

<%
  Customer customer = (Customer) request.getAttribute("customer");
  boolean isEdit = (customer != null);
%>

<div class="w-full max-w-3xl">
  <!-- Header -->
  <div class="flex items-center gap-4 mb-8">
    <div class="w-14 h-14 rounded-2xl flex items-center justify-center shadow-md bg-white icon-float">
      <svg width="28" height="28" viewBox="0 0 24 24" fill="none">
        <path d="M3 6.5C3 5.7 3.7 5 4.5 5H20" stroke="var(--primary)" stroke-width="1.5"
              stroke-linecap="round" stroke-linejoin="round"/>
        <path d="M20 19.5C20 20.3 19.3 21 18.5 21H4" stroke="var(--secondary)" stroke-width="1.5"
              stroke-linecap="round" stroke-linejoin="round"/>
        <path d="M4 5v14" stroke="var(--accent)" stroke-width="1.5" stroke-linecap="round"
              stroke-linejoin="round"/>
        <path d="M12 8.5v7" stroke="var(--primary)" stroke-width="1.6" stroke-linecap="round"
              stroke-linejoin="round"/>
      </svg>
    </div>
    <div>
      <h1 class="text-3xl font-bold text-gray-800 tracking-tight">
        <%= isEdit ? "Edit Customer" : "Add Customer" %>
      </h1>
      <p class="text-sm text-gray-500">Manage customer details for your bookstore.</p>
    </div>
  </div>

  <!-- Card -->
  <div class="glass-card rounded-2xl shadow-xl p-6 sm:p-8">
    <form action="CustomerServlet" method="get" class="space-y-6">
      <input type="hidden" name="action" value="<%= isEdit ? "UPDATE" : "INSERT" %>"/>
      <% if (isEdit) { %>
      <input type="hidden" name="customer_id" value="<%= customer.getCustomerId() %>"/>
      <% } %>

      <!-- Inputs -->
      <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
        <!-- Account -->
        <div>
          <label class="block text-sm font-semibold text-gray-700 mb-1">Account Number *</label>
          <input type="text" name="account_number" required pattern="ACC[0-9]{3}" placeholder="ACC001"
                 value="<%= isEdit ? customer.getAccountNumber() : "" %>"
                 class="w-full rounded-xl border-gray-200 focus:ring-2 focus:ring-primary/40 focus:border-primary px-4 py-2.5 shadow-sm transition"/>
          <p class="text-xs text-gray-400 mt-1">Format: ACC followed by 3 digits</p>
        </div>

        <!-- Full Name -->
        <div>
          <label class="block text-sm font-semibold text-gray-700 mb-1">Full Name *</label>
          <input type="text" name="full_name" required placeholder="John Wick"
                 value="<%= isEdit ? customer.getFullName() : "" %>"
                 class="w-full rounded-xl border-gray-200 focus:ring-2 focus:ring-secondary/40 focus:border-secondary px-4 py-2.5 shadow-sm transition"/>
        </div>

        <!-- Address -->
        <div class="md:col-span-2">
          <label class="block text-sm font-semibold text-gray-700 mb-1">Address *</label>
          <input type="text" name="address" required placeholder="1234 Main St"
                 value="<%= isEdit ? customer.getAddress() : "" %>"
                 class="w-full rounded-xl border-gray-200 focus:ring-2 focus:ring-accent/40 focus:border-accent px-4 py-2.5 shadow-sm transition"/>
        </div>

        <!-- Contact -->
        <div>
          <label class="block text-sm font-semibold text-gray-700 mb-1">Contact No *</label>
          <input type="tel" name="contact_no" required pattern="[0]{1}[7]{1}[0-9]{8}" placeholder="07XXXXXXXX"
                 value="<%= isEdit ? customer.getContactNo() : "" %>"
                 class="w-full rounded-xl border-gray-200 focus:ring-2 focus:ring-primary/40 focus:border-primary px-4 py-2.5 shadow-sm transition"/>
        </div>
      </div>

      <!-- Actions -->
      <div class="flex flex-col sm:flex-row items-center justify-between gap-4 pt-4">
        <button type="submit"
                class="w-full sm:w-auto flex items-center justify-center gap-2 px-6 py-3 rounded-xl text-white font-medium shadow-lg bg-gradient-to-r from-primary to-secondary pulse-slow hover:opacity-90 transition">
          <svg class="w-5 h-5" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M5 12h14M12 5l7 7-7 7"/>
          </svg>
          <%= isEdit ? "Update" : "Save" %>
        </button>

        <a href="dashboard.jsp"
           class="inline-flex items-center gap-2 px-5 py-2.5 rounded-xl text-white font-medium shadow-md bg-secondary hover:bg-blue-700 transition">
          <i class="fa-solid fa-gauge"></i> Dashboard
        </a>

        <a href="customer-list.jsp"
           class="w-full sm:w-auto inline-flex items-center justify-center gap-2 text-sm text-gray-600 px-5 py-2.5 rounded-xl border border-gray-200 hover:bg-gray-100 transition">
          <svg class="w-4 h-4" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
            <path stroke-linecap="round" stroke-linejoin="round" d="M15 18l-6-6 6-6"/>
          </svg>
          Back to List
        </a>
      </div>
    </form>
  </div>
</div>

</body>
</html>
