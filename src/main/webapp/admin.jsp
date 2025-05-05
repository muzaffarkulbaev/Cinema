<%@ page import="com.example.examproject.entity.User" %>
<%@ page import="com.example.examproject.entity.enums.Role" %>
<%@ page import="static com.example.examproject.config.MyListener.hallService" %>
<%@ page import="com.example.examproject.entity.Hall" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .sidebar {
            min-height: 100vh;
            background-color: #f8f9fa;
        }
        .nav-link {
            color: #333;
        }
        .nav-link:hover {
            color: #0d6efd;
        }
        .card {
            margin-bottom: 20px;
            transition: transform 0.2s;
        }
        .card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0,0,0,0.1);
        }
    </style>

</head>

<body class="bg-light">

<%
    User user = (User)request.getSession().getAttribute("user");
    if (user.getRole() == Role.USER){
        response.sendRedirect("/cabinet.jsp");
    }
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid d-flex align-items-center">
        <a class="navbar-brand" href="#">Admin Panel</a>

        <div class="d-flex align-items-center gap-2">
<%--            <a class="btn btn-outline-light" href="/sessionList.jsp">All Sessions</a>--%>

            <div class="dropdown">
                <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                    Switch Role
                </button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="cabinet.jsp">User</a></li>
                    <li><a class="dropdown-item" href="admin.jsp">Admin</a></li>
                    <li><a class="dropdown-item" href="superAdmin.jsp">Super Admin</a></li>
                </ul>
            </div>
        </div>

        <div class="ms-auto d-flex align-items-center gap-2 text-white">
            <img src="/file/<%= user.getAttachment().getId() %>" alt="User Photo" style="width:40px; height:40px; object-fit:cover; border-radius:50%;">
            <span><%= user.getFullName() %></span>
            <form action="/logout" method="post" class="ms-3">
                <button type="submit" class="btn btn-outline-light btn-sm">Logout</button>
            </form>
        </div>
    </div>
</nav>

<div class="container-fluid">
        <!-- Main content -->
        <main class="col-md-9 ms-sm-auto col-lg-10 px-md-4 py-4">
            <h2 class="h4 mb-4">Management Panel</h2>

            <!-- Sessions Section -->
            <div class="row mb-4" id="sessions">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="card-title mb-0">Sessions</h5>
                            <div>
                                <a href="/actions/addSession.jsp" class="btn btn-primary btn-sm me-2">
                                    <i class="fas fa-plus me-1"></i> Add
                                </a>
                                <a href="/actions/sessionList.jsp" class="btn btn-outline-secondary btn-sm">
                                    <i class="fas fa-list me-1"></i> List
                                </a>
                            </div>
                        </div>
                        <div class="card-body">
                            <!-- Sessions content would go here -->
                            <p class="text-muted">Manage movie sessions and schedules</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Movie Section -->
            <div class="row mb-4" id="movies">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="card-title mb-0">Movies</h5>
                            <div>
                                <a href="/actions/addMovie.jsp" class="btn btn-primary btn-sm me-2">
                                    <i class="fas fa-plus me-1"></i> Add
                                </a>
                                <a href="/actions/movieList.jsp" class="btn btn-outline-secondary btn-sm">
                                    <i class="fas fa-list me-1"></i> List
                                </a>
                            </div>
                        </div>
                        <div class="card-body">
                            <!-- Halls content would go here -->
                            <p class="text-muted">Manage cinema halls and their configurations</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Halls Section -->
            <div class="row mb-4" id="halls">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="card-title mb-0">Halls</h5>
                            <div>
                                <a href="/addHall" class="btn btn-primary btn-sm me-2">
                                    <i class="fas fa-plus me-1"></i> Add
                                </a>
<%--                                <a href="/hallList.jsp" class="btn btn-primary btn-sm me-2">--%>
<%--                                    <i class="fas fa-plus me-1"></i> List--%>
<%--                                </a>--%>
                            </div>
                        </div>
                        <div class="card-body">
                            <!-- Halls content would go here -->
                            <p class="text-muted">Manage cinema halls and their configurations</p>
                        </div>
                    </div>
                </div>
            </div>

            <!-- Seats Section -->
            <div class="row" id="seats">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <h5 class="card-title mb-0">Seats</h5>
                            <div>
                                <a href="/actions/addSeats.jsp" class="btn btn-primary btn-sm">
                                    <i class="fas fa-plus me-1"></i> Add
                                </a>
                            </div>
                        </div>
                        <div class="card-body">
                            <!-- Seats content would go here -->
                            <p class="text-muted">You can add session and delete or edit</p>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row" id="tickets">
                <div class="col-12">
                    <div class="card">
                        <div class="card-header d-flex justify-content-between align-items-center">
                            <div>
                                <a href="/ticketsInfo.jsp" class="btn btn-primary btn-sm">
                                    Tickets
                                </a>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </main>
    </div>
</div>


<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<script>
    document.getElementById("photo").addEventListener("change", function (event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById("previewImage").src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });
</script>

</body>
</html>
