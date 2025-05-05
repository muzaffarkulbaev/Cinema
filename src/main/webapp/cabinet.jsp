<%@ page import="static com.example.examproject.config.MyListener.sessionService" %>
<%@ page import="com.example.examproject.entity.Session" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.examproject.entity.User" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="jakarta.persistence.EntityManager" %>
<%@ page import="static com.example.examproject.config.MyListener.EMF" %>
<%@ page import="java.util.Objects" %>
<%@ page import="com.example.examproject.entity.Movie" %>
<%@ page import="jakarta.persistence.TypedQuery" %>
<%@ page import="com.example.examproject.dto.SessionTotalPage" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>User Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .profile-container {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 80px;
        }
        .profile-container img {
            width: 70px;
            height: 70px;
            object-fit: cover;
            border-radius: 50%;
            margin-right: 10px;
        }
        .card img {
            width: 100%;
            height: 200px;
            object-fit: cover;
        }
        .card:hover {
            transform: scale(1.05);
            transition: transform 0.3s ease;
        }
        .pagination-container {
            display: flex;
            justify-content: center;
            margin-top: 20px;
        }
        .pagination-container a {
            margin: 0 5px;
        }

        /* Reduced height for navbar */
        .navbar {
            padding-top: 0.5rem;
            padding-bottom: 0.5rem;
        }
        .navbar-brand {
            font-size: 1.1rem;
            padding: 0.25rem 0;
        }
        .dropdown-toggle {
            font-size: 1rem;
        }
        .btn-outline-light {
            font-size: 0.9rem;
        }
        /* Ensure all navbar items align in one line */
        .navbar-content {
            display: flex;
            align-items: center;
            width: 100%;
        }
        .navbar-content > * {
            margin-right: 10px;
            white-space: nowrap;
        }
        .ms-auto {
            margin-left: auto !important;
        }
    </style>
</head>
<body class="bg-light">

<%
    User user = (User) request.getSession().getAttribute("user");

    Integer currentPage = 0;
    String search = "";
    Integer min = 0;
    Integer max = 100000000;
    long totalPage = 0;

    try {
        currentPage = Integer.parseInt(Objects.requireNonNullElse(request.getParameter("page"), "1"));
        search = Objects.requireNonNullElse(request.getParameter("search"),"");
        min = Integer.parseInt(Objects.requireNonNullElse(request.getParameter("min"), "0"));
        max = Integer.parseInt(
                Objects.requireNonNullElse(request.getParameter("max"), String.valueOf(100000000))
        );
    } catch (Exception e) {
        e.printStackTrace();
    }

    SessionTotalPage sessionTotalPage = sessionService.getByFilter(search, min, max, currentPage);
    List<Session> sessions = sessionTotalPage.sessions();
    totalPage = sessionTotalPage.totalPage();
%>

<!-- Navbar -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid navbar-content">
        <a class="navbar-brand" href="#">User Dashboard</a>
        <div class="dropdown">
            <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                Switch Role
            </button>
            <ul class="dropdown-menu">
                <li><a class="dropdown-item" href="/cabinet.jsp">User</a></li>
                <li><a class="dropdown-item" href="/admin.jsp">Admin</a></li>
                <li><a class="dropdown-item" href="/superAdmin.jsp">Super Admin</a></li>
            </ul>
        </div>
        <a class="btn btn-primary" href="/myTickets.jsp">My tickets</a>
        <!-- Profile Block -->
        <div class="bg-dark text-white p-3">
            <div class="container">
                <div class="profile-container">
                    <img src="/file/<%=user.getAttachment().getId()%>" alt="User Photo">
                    <span class="fw-bold fs-5"><%= user.getFullName() %></span>
                </div>
            </div>
        </div>
        <form action="/logout" method="post" class="ms-auto">
            <button type="submit" class="btn btn-outline-light">Logout</button>
        </form>
    </div>
</nav>



<!-- Search and Filter Form -->
<form action="?" class="container my-4">
    <div class="row g-3 align-items-end">
        <div class="col-md-4">
            <label for="search" class="form-label">Movie Name</label>
            <input placeholder="Enter movie name" value="<%=search%>" type="text" name="search" id="search" class="form-control">
        </div>
        <div class="col-md-3">
            <label for="min" class="form-label">Min Price</label>
            <input placeholder="Min price" value="<%=min%>" type="number" name="min" id="min" class="form-control">
        </div>
        <div class="col-md-3">
            <label for="max" class="form-label">Max Price</label>
            <input placeholder="Max price" value="<%=max%>" type="number" name="max" id="max" class="form-control">
        </div>
        <div class="col-md-2 d-grid">
            <button type="submit" class="btn btn-primary">Filter</button>
        </div>
    </div>
</form>

<!-- Cinema Sessions -->
<div class="container mt-5">
    <h2 class="mb-4 text-center">Select Cinema Session</h2>
    <div class="row">
        <%
            if (sessions != null && !sessions.isEmpty()) {
                for (Session cinemaSession : sessions) {
        %>
        <div class="col-md-4">
            <div class="card mb-4 shadow-sm">
                <img src="/file/<%= cinemaSession.getMovie().getAttachment().getId()%>" alt="Cinema Photo">
                <div class="card-body text-center">
                    <h5 class="card-title">Movie name: <%= cinemaSession.getMovie().getName() %></h5>
                    <p class="card-text">Time: <%= cinemaSession.getTime() %></p>
                    <p class="card-text">Duration: <%= cinemaSession.getMovie().getDuration() %> minutes</p>
                    <p class="card-text">Price: <%= cinemaSession.getPrice() %></p>
                    <a href="/bookSeat.jsp?sessionId=<%= cinemaSession.getId() %>" class="btn btn-primary">Buy ticket</a>
                </div>
            </div>
        </div>
        <% }
        } else { %>
        <div class="col-12 text-center">
            <p>No cinema sessions available.</p>
        </div>
        <% } %>
    </div>
</div>

<!-- Pagination -->
<div class="pagination-container">
    <% for (int i = 1; i <= totalPage; i++) { %>
    <a class="btn btn-<%=currentPage == i ? "success" : "dark"%> m-1" href="?page=<%=i%><%=search!="" ? "&search=" + search : ""%><%= "&min=" + min %><%= "&max=" + max %>">
        <%=i%>
    </a>
    <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
