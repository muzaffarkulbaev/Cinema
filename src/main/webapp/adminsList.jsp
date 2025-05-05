<%@ page import="com.example.examproject.entity.User" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="static com.example.examproject.config.MyListener.userService" %>
<%@ page import="java.util.Objects" %>
<%@ page import="jakarta.persistence.EntityManager" %>
<%@ page import="static com.example.examproject.config.MyListener.EMF" %>
<%@ page import="jakarta.persistence.TypedQuery" %>
<%@ page import="com.example.examproject.entity.enums.Role" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 06.04.2025
  Time: 23:18
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1">
  <title>List of Admins</title>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%
  User currentUser = (User)request.getSession().getAttribute("user");
  if (currentUser.getRole() != Role.SUPER_ADMIN){
    response.sendRedirect("/cabinet.jsp");
  }
  List<User> admins = new ArrayList<>(); //= userService.getAdmins();

  Integer currentPage = 0;
  String search = Objects.requireNonNullElse(request.getParameter("search"),"");
  currentPage = Integer.parseInt(Objects.requireNonNullElse(request.getParameter("page"), "1"));
  long totalPage = 0;
  try (
          EntityManager entityManager = EMF.createEntityManager()
  ){
    TypedQuery<User> typedQuery = entityManager.createQuery("select m from User m where m.role = :role and (m.firstName ilike concat(:search,'%') or m.lastName ilike concat(:search,'%'))", User.class);
    typedQuery.setParameter("search", search);
    typedQuery.setParameter("role", Role.ADMIN);
    typedQuery.setFirstResult((currentPage-1)*8);
    typedQuery.setMaxResults(8);
    admins = typedQuery.getResultList();
    TypedQuery<Long> typedQuery1 = entityManager.createQuery("select count(m) from User m where m.role = :role and (m.firstName ilike concat(:search,'%') or m.lastName ilike concat(:search,'%'))", Long.class);
    typedQuery1.setParameter("search", search);
    typedQuery1.setParameter("role",Role.ADMIN);
    totalPage = (typedQuery1.getSingleResult() + 7) / 8;
  }
%>

<nav class="navbar navbar-expand-lg navbar-dark bg-dark">
  <div class="container-fluid d-flex align-items-center">
    List of Admins
  </div>
  <a href="/superAdmin.jsp" class="btn btn-success">Back</a>
</nav>

<div class="container mt-5">

  <form action="?" class="container my-4">
    <div class="row g-3 align-items-end">
      <div class="col-md-4">
        <label for="search" class="form-label">Admin Name</label>
        <input placeholder="Enter admin name" value="<%=search%>" type="text" name="search" id="search" class="form-control">
      </div>
      <div class="col-md-2 d-grid">
        <button type="submit" class="btn btn-primary">Filter</button>
      </div>
    </div>
  </form>

  <h2>Admin List</h2>
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
    <% for (User admin : admins) { %>
    <tr>
      <td><%=admin.getEmail()%></td>
      <td><%=admin.getFullName()%></td>
      <td>
        <form action="/deleteAdmin" method="post">
          <input type="hidden" name="userId" value="<%= admin.getId() %>">
          <button class="btn btn-success">delete</button>
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
