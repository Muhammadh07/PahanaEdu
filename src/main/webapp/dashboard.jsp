<%@ page import="com.pahanaedu.model.Items" %>
<%@ page import="com.pahanaedu.dao.CustomerDAO" %>
<%@ page import="com.pahanaedu.model.Customer" %>
<%@ page import="java.util.List" %>
<%@ page import="com.pahanaedu.dao.ItemDAO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.pahanaedu.model.BillItem" %>
<%@ page import="com.pahanaedu.dao.BillDAO" %>
<%@ page import="com.pahanaedu.model.Bill" %><%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 21/08/2025
  Time: 04:58
  To change this template use File | Settings | File Templates.
--%>
<%--<%--%>
<%--  String username = (String) session.getAttribute("user");--%>
<%--  if (username == null) {--%>
<%--    response.sendRedirect("login.jsp");--%>
<%--    return;--%>
<%--  }--%>
<%--%>--%>
<%--<html>--%>
<%--<head><title>Dashboard</title></head>--%>
<%--<body>--%>
<%--<h2>Welcome, <%= username %>!</h2>--%>
<%--<a href="index.jsp">Logout</a>--%>
<%--</body>--%>
<%--</html>--%>

<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
  <title>Pahana-Edu Dashboard</title>
</head>
<style>
  /* ==== Global Colors ==== */
  :root {
    --red: #e50914;   /* Bright Netflix-style red */
    --dark: #1a1a1a;  /* Dark background */
    --white: #ffffff; /* Pure white */
  }

  /* ==== Sidebar & Header ==== */
  #sidebarMenu, .offcanvas-header {
    background: var(--dark);
    color: var(--white);
    padding: 12px;
    border-bottom: 2px solid var(--red);
  }

  /* ==== Images inside sidebar ==== */
  img {
    background-color: var(--white);
    padding: 6px;
    border-radius: 8px;
    margin: 0;
    border: 2px solid var(--red);
    transition: transform 0.3s ease, box-shadow 0.3s ease;
  }

  img:hover {
    transform: scale(1.05);
    box-shadow: 0 0 10px rgba(229, 9, 20, 0.6);
  }

  /* ==== Base Button ==== */
  .btn-exit {
    background-color: var(--dark);
    color: var(--red);
    border: 2px solid var(--red);
    border-radius: 8px;
    padding: 10px 20px;
    font-weight: bold;
    cursor: pointer;
    letter-spacing: 0.5px;
    transition: all 0.3s ease;
  }

  .btn-exit:hover {
    background-color: var(--red);
    color: var(--white);
    transform: translateY(-2px);
    box-shadow: 0 4px 10px rgba(229, 9, 20, 0.5);
  }

  /* ==== Variants (if needed) ==== */
  .exit1 { }
  .exit2 { }
</style>


<body>
<nav class="navbar navbar-expand-lg navbar-dark bg-primary">
  <div class="container-fluid">
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavDropdown" aria-controls="navbarNavDropdown" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
      <a class="navbar-brand py-3 " href="#" style="font-size: 1.5rem;">Phana Edu Bookstore</a>
    </button>
    <!-- User Info (right side) -->
    <div class="d-flex align-items-center ms-auto">
                <span class="me-2 position-relative">
                    <i class="bi bi-bell fs-5"></i>
                    <span class="position-absolute top-0 start-100 translate-middle p-1 bg-danger border border-light rounded-circle"></span>
                </span>
      <span class="d-flex align-items-center">
                    <span class="rounded-circle bg-info text-white fw-bold d-flex justify-content-center align-items-center" style="width: 40px; height: 40px;">AU</span>
                    <span class="ms-2 text-white fw-semibold">Admin User</span>
                </span>
    </div>
  </div>
</nav>

<!-- Responsive Sidebar -->
<nav id="sidebarMenu" class="d-lg-block d-none text-white vh-100 flex-shrink-0 p-3" style="width: 250px; position: fixed; top: 0; left: 0; z-index: 1030;">
  <img src="assets/logo.png" width="150" class="m-0" alt="logo Logo">
  <a href="#" class="d-flex align-items-center mb-3 mb-md-0 me-md-auto text-white text-decoration-none">
    <span class="fs-4"> Bookstore Billing</span>
  </a>
  <hr>
  <ul class="nav nav-pills flex-column mb-auto">
    <li>
      <a href="#customerMenu" data-bs-toggle="collapse" class="nav-link text-white d-flex align-items-center">
        <i class="bi bi-person"></i>
        <span class="ms-2">Customer</span>
        <i class="bi bi-caret-down ms-auto"></i>
      </a>
      <div class="collapse" id="customerMenu">
        <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small ms-4">
          <li><a href="customer-add.jsp" class="nav-link text-white"><i class="bi bi-person-plus"></i> Add Customer</a></li>
          <li><a href="customer-view.jsp" class="nav-link text-white"><i class="bi bi-person-lines-fill"></i> View Customer Details</a></li>
        </ul>
      </div>
    </li>
    <li>
      <a href="#itemsMenu" data-bs-toggle="collapse" class="nav-link text-white d-flex align-items-center">
        <i class="bi bi-box"></i>
        <span class="ms-2">Items</span>
        <i class="bi bi-caret-down ms-auto"></i>
      </a>
      <div class="collapse" id="itemsMenu">
        <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small ms-4">
          <li><a href="add-item.jsp" class="nav-link text-white"><i class="bi bi-plus-square"></i> Add Item</a></li>
          <li><a href="customer-list.jsp" class="nav-link text-white"><i class="bi bi-pencil"></i> Manage Items</a></li>
        </ul>
      </div>
    </li>
    <li>
      <a href="customer-view.jsp" class="nav-link text-white d-flex align-items-center">
        <i class="bi bi-person-badge"></i>
        <span class="ms-2">Display Account Details</span>
      </a>
    </li>
    <li>
      <a href="billForm.jsp" class="nav-link text-white d-flex align-items-center">
        <i class="bi bi-printer"></i>
        <span class="ms-2">Calculate & Print Bills</span>
      </a>
    </li>
    <li>
      <a href="bill-history.jsp" class="nav-link text-white d-flex align-items-center">
        <i class="bi bi-clock-history"></i>
        <span class="ms-2">Bill History</span>
      </a>
    </li>
    <li>
      <a href="#" class="nav-link text-white d-flex align-items-center">
        <i class="bi bi-question-circle"></i>
        <span class="ms-2">Help</span>
      </a>
    </li>
    <li>
      <a href="index.jsp" class="exit2 nav-link text-danger d-flex align-items-center">
        <i class="bi bi-box-arrow-right"></i>
        <span class="ms-2">Exit System</span>
      </a>
    </li>
  </ul>
</nav>
<!-- Sidebar Toggle Button for small screens -->
<button class="btn btn-primary d-lg-none position-fixed" type="button" style="top: 10px; left: 10px; z-index: 1040;" data-bs-toggle="offcanvas" data-bs-target="#offcanvasSidebar" aria-controls="offcanvasSidebar">
  <i class="bi bi-list"></i>
</button>
<!-- Offcanvas Sidebar for small screens -->
<div class="offcanvas offcanvas-start bg-primary text-white" tabindex="-1" id="offcanvasSidebar" aria-labelledby="offcanvasSidebarLabel">
  <div class="offcanvas-header">
    <img src="assets/Phana.png" width="150" class="m-0" alt="Phana Logo">
    <h5 class="offcanvas-title ms-3" id="offcanvasSidebarLabel">Bookstore Billing</h5>
    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="offcanvas" aria-label="Close"></button>
  </div>
  <div class="offcanvas-body p-3">
    <ul class="nav nav-pills flex-column mb-auto">
      <li>
        <a href="#customerMenuMobile" data-bs-toggle="collapse" class="nav-link text-white d-flex align-items-center">
          <i class="bi bi-person"></i>
          <span class="ms-2">Customer</span>
          <i class="bi bi-caret-down ms-auto"></i>
        </a>
        <div class="collapse" id="customerMenuMobile">
          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small ms-4">
            <li><a href="customer-add.jsp" class="nav-link text-white"><i class="bi bi-person-plus"></i> Add Customer</a></li>
            <li><a href="customer-view.jsp" class="nav-link text-white"><i class="bi bi-person-lines-fill"></i> View Customer Details</a></li>
          </ul>
        </div>
      </li>
      <li>
        <a href="#itemsMenuMobile" data-bs-toggle="collapse" class="nav-link text-white d-flex align-items-center">
          <i class="bi bi-box"></i>
          <span class="ms-2">Items</span>
          <i class="bi bi-caret-down ms-auto"></i>
        </a>
        <div class="collapse" id="itemsMenuMobile">
          <ul class="btn-toggle-nav list-unstyled fw-normal pb-1 small ms-4">
            <li><a href="add-item.jsp" class="nav-link text-white"><i class="bi bi-plus-square"></i> Add Item</a></li>
            <li><a href="item-list.jsp" class="nav-link text-white"><i class="bi bi-pencil"></i> Manage Items</a></li>
          </ul>
        </div>
      </li>
      <li>
        <a href="view-customer-list.jsp" class="nav-link text-white d-flex align-items-center">
          <i class="bi bi-person-badge"></i>
          <span class="ms-2">Display Account Details</span>
        </a>
      </li>
      <li>
        <a href="billForm.jsp" class="nav-link text-white d-flex align-items-center">
          <i class="bi bi-printer"></i>
          <span class="ms-2">Calculate & Print Bills</span>
        </a>
      </li>
      <li>
        <a href="bill-customer-history.jsp" class="exit2 nav-link text-white d-flex align-items-center">
          <i class="bi bi-clock-history"></i>
          <span class="ms-2">Bill History</span>
        </a>
      </li>
      <li>
        <a href="#" class="exit2 nav-link text-white d-flex align-items-center">
          <i class="bi bi-question-circle"></i>
          <span class="ms-2">Help</span>
        </a>
      </li>
      <li>
        <a href="index.jsp" class="exit1 nav-link d-flex align-items-center">
          <i class="bi bi-box-arrow-right"></i>
          <span class="ms-2">Exit System</span>
        </a>
      </li>
    </ul>
  </div>
</div>
<style>
  @media (max-width: 991.98px) {
    #sidebarMenu {
      display: none !important;
    }
  }
</style>
<link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.css">
<style>
  body {
    margin-left: 250px;
  }
  @media (max-width: 991.98px) {
    .vh-100 {
      height: auto !important;
    }
    body {
      margin-left: 0;
    }
  }
</style>
</div>
</nav>

<div class="container-fluid mt-lg-4"></div>
<div class="row g-3 mx-xl-2">
  <!-- Total Customers -->
  <div class="col-md-3">
    <div class="card border-primary h-100">
      <div class="card-body">
        <h6 class="card-subtitle mb-2 text-muted">Total Customers</h6>
        <%
          CustomerDAO customerDAO = new CustomerDAO();
          List<Customer> customers = customerDAO.getAllCustomers();
          int totalCustomers = customers.size();
        %>
        <h3><%= totalCustomers %>
        </h3>
        <span class="text-secondary">Current total customers</span>
        <div class="mt-2 text-success small">+12.5% from last month</div>
        <span class="position-absolute top-0 end-0 m-3"><i class="bi bi-people fs-4"></i></span>
      </div>
    </div>
  </div>
  <!-- Today's Sales -->
  <div class="col-md-3">
    <div class="card border-success h-100">
      <div class="card-body">
        <h6 class="card-subtitle mb-2 text-muted">Today's Sales</h6>
        <div class="mt-2 text-success small">+8.3% from yesterday</div>
        <span class="position-absolute top-0 end-0 m-3"><strong>LKR</strong></span>
      </div>
    </div>
  </div>
  <!-- Inventory Items -->
  <div class="col-md-3">
    <div class="card border-danger h-100">
      <div class="card-body">
        <h6 class="card-subtitle mb-2 text-muted">Inventory Items</h6>
        <%
          ItemDAO itemDAO = new ItemDAO();
          int totalStock = itemDAO.getTotalStockQuantity();
        %>
        <h3><%= totalStock %></h3>
        <span class="text-danger">Total stock quantity</span>
        <div class="mt-2 text-danger small">-3.2% from last week</div>
        <span class="position-absolute top-0 end-0 m-3"><i class="bi bi-box-seam fs-4"></i></span>
      </div>
    </div>
  </div>
  <!-- Pending Orders -->
  <div class="col-md-3">
    <div class="card border-warning h-100">
      <div class="card-body">
        <h6 class="card-subtitle mb-2 text-muted">Pending Orders</h6>
        <h3>24</h3>
        <div class="mt-2 text-success small">-5.6% from yesterday</div>
        <span class="position-absolute top-0 end-0 m-3"><i class="bi bi-lock fs-4"></i></span>
      </div>
    </div>
  </div>
</div>

<!-- Quick Actions -->
<div class="mt-4 mx-xl-2">
  <h6 class="fw-bold">Quick Actions</h6>
  <div class="row g-3">
    <div class="col-md-4">
      <a href="customer-add.jsp" class="text-decoration-none">
        <div class="card h-100">
          <div class="card-body d-flex align-items-center">
            <i class="bi bi-person-plus fs-2 text-primary me-3"></i>
            <div>
              <div class="fw-bold">Add New Customer</div>
              <div class="text-muted small">Register a new customer in the system</div>
            </div>
          </div>
        </div>
      </a>


    </div>
    <div class="col-md-4">
      <a href="#" class="text-decoration-none">
        <div class="card h-100">
          <div class="card-body d-flex align-items-center">
            <i class="bi bi-calculator fs-2 text-success me-3"></i>
            <div>
              <div class="fw-bold">Calculate Bill</div>
              <div class="text-muted small">Generate billing details and print invoice</div>
            </div>
          </div>
        </div>
      </a>
    </div>
    <div class="col-md-4">
      <a href="item-list.jsp" class="text-decoration-none">
        <div class="card h-100">
          <div class="card-body d-flex align-items-center">
            <i class="bi bi-box-seam fs-2 text-info me-3"></i>
            <div>
              <div class="fw-bold">Manage Inventory</div>
              <div class="text-muted small">Add, update or delete item records</div>
            </div>
          </div>
        </div>
      </a>
    </div>
  </div>
</div>

<!-- Recent Activity -->
<%--<div class="mt-4 mx-xl-2">--%>
<%--    <h6 class="fw-bold">Recent Activity</h6>--%>
<%--    <div class="card">--%>
<%--        <ul class="list-group list-group-flush">--%>
<%--            <li class="list-group-item d-flex align-items-center">--%>
<%--                <i class="bi bi-person-plus text-primary me-2"></i>--%>
<%--                <div>--%>
<%--                    <div class="fw-bold">New customer registered</div>--%>
<%--                    <div class="text-muted small">John Doe was added to the system</div>--%>
<%--                </div>--%>
<%--                <span class="ms-auto text-muted small">10 min ago</span>--%>
<%--            </li>--%>
<%--            <li class="list-group-item d-flex align-items-center">--%>
<%--                <i class="bi bi-currency-dollar text-success me-2"></i>--%>
<%--                <div>--%>
<%--                    <div class="fw-bold">Order completed</div>--%>
<%--                    <div class="text-muted small">Invoice #INV-2023-1245 for $2,450</div>--%>
<%--                </div>--%>
<%--                <span class="ms-auto text-muted small">1 hour ago</span>--%>
<%--            </li>--%>
<%--            <li class="list-group-item d-flex align-items-center">--%>
<%--                <i class="bi bi-exclamation-triangle text-warning me-2"></i>--%>
<%--                <div>--%>
<%--                    <div class="fw-bold">Low stock alert</div>--%>
<%--                    <div class="text-muted small">"Advanced Mathematics" is running low (3 remaining)</div>--%>
<%--                </div>--%>
<%--                <span class="ms-auto text-muted small">3 hours ago</span>--%>
<%--            </li>--%>
<%--        </ul>--%>
<%--    </div>--%>
<%--</div>--%>

<%
  // Remove duplicate itemDAO declaration
  // ItemDAO itemDAO = new ItemDAO(); // Already declared earlier
  List<Items> items = itemDAO.getAllItems();
  double inventoryValue = 0.0;
  int lowStockThreshold = 10;
  List<Items> lowStockItems = new ArrayList<>();
  for (Items item : items) {
    inventoryValue += item.getPrice() * item.getStock_quantity();
    if (item.getStock_quantity() < lowStockThreshold) {
      lowStockItems.add(item);
    }
  }
  BillDAO billDAO = new BillDAO();
  List<Bill> allBills = billDAO.getAllBills();
  double totalSales = 0.0;
  int salesCount = allBills != null ? allBills.size() : 0;
  Map<Integer, Integer> itemSalesMap = new HashMap<>(); // itemId -> total quantity sold
  if (allBills != null) {
    for (Bill bill : allBills) {
      totalSales += bill.getTotalAmount();
      for (BillItem billItem : bill.getItems()) {
        int itemId = billItem.getItemId();
        int qty = billItem.getQuantity();
        itemSalesMap.put(itemId, itemSalesMap.getOrDefault(itemId, 0) + qty);
      }
    }
  }
  // Find highest moving item(s)
  int maxQty = 0;
  List<Items> highestMovingItems = new ArrayList<>();
  for (Map.Entry<Integer, Integer> entry : itemSalesMap.entrySet()) {
    if (entry.getValue() > maxQty) {
      maxQty = entry.getValue();
      highestMovingItems.clear();
      highestMovingItems.add(itemDAO.getItemById(entry.getKey()));
    } else if (entry.getValue() == maxQty) {
      highestMovingItems.add(itemDAO.getItemById(entry.getKey()));
    }
  }
  java.text.NumberFormat nf = java.text.NumberFormat.getNumberInstance(java.util.Locale.forLanguageTag("en-LK"));
  nf.setMinimumFractionDigits(2);
  nf.setMaximumFractionDigits(2);

%>

  <!-- Low Stock Alerts -->
  <div class="col-md-3">
    <div class="card border-warning h-100">
      <div class="card-body">
        <h6 class="card-subtitle mb-2 text-muted">Low Stock Alerts</h6>
        <h3><%= lowStockItems.size() %> item(s)</h3>
        <% if (!lowStockItems.isEmpty()) { %>
        <ul style="font-size:small;">
          <% for (Items item : lowStockItems) { %>
          <li><%= item.getItem_name() %> (<%= item.getStock_quantity() %> left)</li>
          <% } %>
        </ul>
        <% } else { %>
        <span class="text-success">No low stock items</span>
        <% } %>
      </div>
    </div>
  </div>
  <!-- Total Sales -->
  <div class="col-md-3">
    <div class="card border-success h-100">
      <div class="card-body">
        <h6 class="card-subtitle mb-2 text-muted">Total Sales</h6>
        <h3>LKR <%= nf.format(totalSales) %></h3>
        <span class="text-success">Number of Sales: <%= salesCount %></span>
      </div>
    </div>
  </div>
  <!-- Highest Moving Item -->
  <div class="col-md-3">
    <div class="card border-primary h-100">
      <div class="card-body">
        <h6 class="card-subtitle mb-2 text-muted">Highest Moving Item(s)</h6>
        <% if (!highestMovingItems.isEmpty()) { %>
        <ul style="font-size:small;">
          <% for (Items item : highestMovingItems) { %>
          <li><%= item.getItem_name() %> (<%= itemSalesMap.get(item.getItem_id()) %> sold)</li>
          <% } %>
        </ul>
        <% } else { %>
        <span class="text-muted">No sales data</span>
        <% } %>
      </div>
    </div>
  </div>
</div>
</div>

</body>
</html>