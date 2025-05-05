<%@ page import="static com.example.examproject.config.MyListener.userService" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.examproject.entity.User" %>
<%@ page import="com.example.examproject.entity.enums.Role" %>
<%@ page import="java.util.Objects" %>
<%@ page import="jakarta.persistence.EntityManager" %>
<%@ page import="static com.example.examproject.config.MyListener.EMF" %>
<%@ page import="jakarta.persistence.TypedQuery" %>
<%@ page import="java.util.ArrayList" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Super Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">


    <style>
        .profile-container {
            display: flex;
            align-items: center;
            justify-content: center;
            height: 100px;
        }
        .profile-container img {
            width: 100px;
            height: 100px;
            object-fit: cover;
            border-radius: 20%;
            margin-right: 10px;
        }
    </style>


</head>
<body class="bg-light">

<%
    User currentUser = (User)request.getSession().getAttribute("user");
    if (currentUser.getRole() != Role.SUPER_ADMIN){
        response.sendRedirect("/cabinet.jsp");
    }
    List<User> users = new ArrayList<>();

    Integer currentPage = 0;
    String search = Objects.requireNonNullElse(request.getParameter("search"),"");
    currentPage = Integer.parseInt(Objects.requireNonNullElse(request.getParameter("page"), "1"));
    long totalPage = 0;
    try (
            EntityManager entityManager = EMF.createEntityManager()
    ){
        TypedQuery<User> typedQuery = entityManager.createQuery("select m from User m where m.role = :role and (lower(m.firstName) like lower(concat(:search, '%')) or lower(m.lastName) like lower(concat(:search, '%')))", User.class);
        typedQuery.setParameter("search", search);
        typedQuery.setParameter("role",Role.USER);
        typedQuery.setFirstResult((currentPage-1)*8);
        typedQuery.setMaxResults(8);
        users = typedQuery.getResultList();
        TypedQuery<Long> typedQuery1 = entityManager.createQuery("select count(m) from User m where m.role = :role and (lower(m.firstName) like lower(concat(:search, '%')) or lower(m.lastName) like lower(concat(:search, '%')))", Long.class);
        typedQuery1.setParameter("search", search);
        typedQuery1.setParameter("role",Role.USER);
        totalPage = (typedQuery1.getSingleResult() + 7) / 8;
    }
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
    <div class="container-fluid d-flex align-items-center">
        <!-- Бренд и переключение ролей -->
        <div class="d-flex align-items-center">
            <a class="navbar-brand me-3" href="#">Super Admin Panel</a>
            <div class="dropdown me-2">
                <button class="btn btn-secondary dropdown-toggle" type="button" data-bs-toggle="dropdown" aria-expanded="false">
                    Switch Role
                </button>
                <ul class="dropdown-menu">
                    <li><a class="dropdown-item" href="cabinet.jsp">User</a></li>
                    <li><a class="dropdown-item" href="admin.jsp">Admin</a></li>
                    <li><a class="dropdown-item" href="superAdmin.jsp">Super Admin</a></li>
                </ul>
            </div>

            <!-- Новая кнопка для перехода -->
            <a href="/adminsList.jsp" class="btn btn-primary me-2">
                <i class="fas fa-external-link-alt me-1"></i> List of Admins
            </a>
        </div>

        <!-- Профиль пользователя и кнопка выхода -->
        <div class="d-flex align-items-center ms-auto">
            <div class="profile-container me-3">
                <img src="/file/<%=currentUser.getAttachment().getId()%>" alt="User Photo" class="me-2" style="width: 40px; height: 40px; border-radius: 50%;">
                <span class="fw-bold fs-6 text-white"><%= currentUser.getFullName() %></span>
            </div>

            <form action="/logout" method="post">
                <button type="submit" class="btn btn-outline-light">Logout</button>
            </form>
        </div>
    </div>
</nav>

<div class="container mt-5">

    <form action="?" class="container my-4">
        <div class="row g-3 align-items-end">
            <div class="col-md-4">
                <label for="search" class="form-label">User Name</label>
                <input placeholder="Enter admin name" value="<%=search%>" type="text" name="search" id="search" class="form-control">
            </div>
            <div class="col-md-2 d-grid">
                <button type="submit" class="btn btn-primary">Filter</button>
            </div>
        </div>
    </form>

    <h2>Add New Admin</h2>
    <table class="table table-striped">
        <thead>
        <tr>
            <th>Email</th>
            <th>Full Name</th>
            <th>Action</th>
        </tr>
        </thead>
        <tbody>
        <%-- Здесь будет динамическое отображение списка админов --%>
        <%-- Пример: --%>
        <% for (User user : users) { %>
            <tr>
                <td><%=user.getEmail()%></td>
                <td><%=user.getFullName()%></td>
                <td>
                    <form action="/addAdminServlet" method="post">
                        <input type="hidden" name="userId" value="<%= user.getId() %>">
                        <button class="btn btn-success">Do admin</button>
                    </form>
                </td>
            </tr>
         <% } %>
        </tbody>
    </table>
</div>

<% for (int i = 1; i <= totalPage; i++) { %>
<a class="btn btn-<%=currentPage==i?"success":"dark"%> m-1" href="?page=<%=i%><%=search!=""?"&search="+search:""%>"><%=i%></a>
<% } %>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
