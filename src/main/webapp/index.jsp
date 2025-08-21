<%--
  Created by IntelliJ IDEA.
  User: USER
  Date: 21/08/2025
  Time: 04:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>Pahana Edu Billing Web App</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-LN+7fdVzj6u52u30Kp6M/trliBMCMKTyK833zpbD+pXdCLuTusPj697FH4R/5mcr" crossorigin="anonymous">
  <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.7/dist/js/bootstrap.bundle.min.js" integrity="sha384-ndDqU0Gzau9qJ1lfW4pNLlhNTkCfHzAVBReH9diLvGRem5+R9g2FzA8ZGN954O5Q" crossorigin="anonymous"></script>
</head>
<style>
  /* Reset & Base */
  body {
    margin: 0;
    padding: 0;
    font-family: "Segoe UI", Arial, sans-serif;
    background:bisque;
    color: #333;
    line-height: 1.6;
  }

  /* Navbar */
  nav.navbar {
    background: #ff4d4d;
    padding: 0.8rem 1.5rem;
    box-shadow: 0 2px 8px rgba(0,0,0,0.1);
  }

  .navbar-brand img {
    max-width: 140px;
    height: auto;
  }

  .navbar-nav .nav-link {
    color:black;
    font-weight: 500;
    margin-left: 15px;
    transition: color 0.3s ease;
  }

  .navbar-nav .nav-link:hover,
  .navbar-nav .nav-link.active {
    color:black;
  }

  /* Hero Section */
  .hero {
    text-align: center;
    padding: 80px 20px 50px;
  }

  .hero h2 {
    font-size: 2.5rem;
    font-weight: 700;
    color: #ff4d4d;
    margin-bottom: 20px;
  }

  .hero .subtxt {
    font-size: 1.2rem;
    color: #555;
    max-width: 600px;
    margin: 0 auto;
  }

  /* Button */
  #login {
    background-color: #ff4d4d;
    border: none;
    padding: 14px 32px;
    border-radius: 6px;
    font-size: 1rem;
    font-weight: bold;
    color: #fff;
    cursor: pointer;
    transition: all 0.3s ease;
  }

  #login:hover {
    background-color: #e63939;
    transform: translateY(-2px);
    box-shadow: 0 4px 10px rgba(0,0,0,0.15);
  }
</style>

  <body>

<nav class="navbar navbar-expand-lg bg-body-tertiary justify-content-center">
  <div class="container-fluid justify-content-center">
    <a class="navbar-brand mx-auto ms-3" href="#">
      <img src="assets/logo.png" alt="" srcset="" width="150">
    </a>
    <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNavAltMarkup" aria-controls="navbarNavAltMarkup" aria-expanded="false" aria-label="Toggle navigation">
      <span class="navbar-toggler-icon"></span>
    </button>
    <div class="collapse navbar-collapse justify-content-end gap-0" id="navbarNavAltMarkup">
      <div class="navbar-nav gap-xl-5">
        <div class="ms-lg-1 d-flex gap-xl-3">
          <a class="nav-link active" aria-current="page" href="login.jsp" title="Login">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-box-arrow-in-right" viewBox="0 0 16 16">
              <path fill-rule="evenodd" d="M6 3a1 1 0 0 1 1-1h6a1 1 0 0 1 1 1v10a1 1 0 0 1-1 1H7a1 1 0 0 1-1-1v-2a.5.5 0 0 1 1 0v2h6V3H7v2a.5.5 0 0 1-1 0V3z"/>
              <path fill-rule="evenodd" d="M.146 8.354a.5.5 0 0 1 0-.708l3-3a.5.5 0 1 1 .708.708L1.707 7.5H10.5a.5.5 0 0 1 0 1H1.707l2.147 2.146a.5.5 0 0 1-.708.708l-3-3z"/>
            </svg>
          </a>
          <a class="nav-link" href="register.jsp" title="Register">
            <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" fill="currentColor" class="bi bi-person-plus" viewBox="0 0 16 16">
              <path d="M8 8a3 3 0 1 0 0-6 3 3 0 0 0 0 6z"/>
              <path d="M14 8a.5.5 0 0 1 .5.5v1.5H16a.5.5 0 0 1 0 1h-1.5V13a.5.5 0 0 1-1 0v-2H12a.5.5 0 0 1 0-1h1.5V8.5A.5.5 0 0 1 14 8zm-6 5c-3.314 0-6 1.343-6 3v1h12v-1c0-1.657-2.686-3-6-3z"/>
            </svg>
          </a>
        </div>
      </div>
    </div>
  </div>
</nav>
<div class="hero">
  <h2>Welcome to <br> Pahana Edu Billing System</h2>
  <p class="subtxt">Manage customers, items, and billing efficiently with our online system.</p>
</div>
<div class="hero col-lg-6 mx-auto mt-2">
  <%--    <p class="lead mb-4">Pahana Edu is a leading bookshop in Colombo, now powered by our new online billing system.--%>
  <%--        Manage customer accounts, item inventory, and billing with speed, accuracy, and security all in one place.--%>
  <%--    </p>--%>
  <div class="d-grid gap-2 d-sm-flex justify-content-sm-center">
    <button type="button" class="btn btn-primary btn-lg px-4 gap-3" id="login" onclick="window.location.href='login.jsp'">GET STARTED</button>
  </div>
</div>

<!-- <h2>Welcome to Pahana Edu Billing System</h2>
<p>Manage customers, items, and billing efficiently with our online system.</p>
<button id="login" onclick="window.location.href='login.jsp'">Login</button> -->

</body>
</html>