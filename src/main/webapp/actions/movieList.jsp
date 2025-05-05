<%@ page import="com.example.examproject.entity.User" %>
<%@ page import="com.example.examproject.entity.enums.Role" %>
<%@ page import="java.util.Objects" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.examproject.entity.Movie" %>
<%@ page import="jakarta.persistence.EntityManager" %>
<%@ page import="static com.example.examproject.config.MyListener.EMF" %>
<%@ page import="jakarta.persistence.TypedQuery" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 07.04.2025
  Time: 14:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>List of sessions</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>

<%
    User currentUser = (User)request.getSession().getAttribute("user");
    if (currentUser.getRole() == Role.USER){
        response.sendRedirect("/cabinet.jsp");
    }
    List<Movie> movies = new ArrayList<>();

    Integer currentPage = 0;
    String search = Objects.requireNonNullElse(request.getParameter("search"),"");
    currentPage = Integer.parseInt(Objects.requireNonNullElse(request.getParameter("page"), "1"));
    long totalPage = 0;
    try (
            EntityManager entityManager = EMF.createEntityManager()
    ){
        TypedQuery<Movie> typedQuery = entityManager.createQuery("select m from Movie m where (lower(m.name) like lower(concat(:search, '%')))", Movie.class);
        typedQuery.setParameter("search", search);
        typedQuery.setFirstResult((currentPage-1)*3);
        typedQuery.setMaxResults(3);
        movies = typedQuery.getResultList();
        TypedQuery<Long> typedQuery1 = entityManager.createQuery("select count (m) from Movie m where (lower(m.name) like lower(concat(:search, '%')))", Long.class);
        typedQuery1.setParameter("search", search);
        totalPage = (typedQuery1.getSingleResult() + 2) / 3;
    }
%>

<form action="?" class="container my-4">
    <div class="row g-3 align-items-end">
        <div class="col-md-4">
            <label for="search" class="form-label">Movie Name</label>
            <input placeholder="Enter movie name" value="<%=search%>" type="text" name="search" id="search" class="form-control">
        </div>
        <div class="col-md-2 d-grid">
            <button type="submit" class="btn btn-primary">Filter</button>
        </div>
    </div>
</form>

<!-- Сеансы кино -->
<div class="container mt-5">
    <h2 class="mb-4 text-center">Select Cinema Session</h2>
    <div class="row">
        <%
            if (movies != null && !movies.isEmpty()) {
                for (Movie movie : movies) {
        %>
        <div class="col-md-4">
            <div class="card mb-4 shadow-sm">
                <img src="/file/<%= movie.getAttachment().getId()%>" alt="Cinema Photo">
                <div class="card-body text-center">
                    <h5 class="card-title">Movie name: <%= movie.getName() %></h5>
                    <p class="card-text">Duration: <%= movie.getDuration() %></p>
<%--                    <div class="btn-group" role="group">--%>
<%--                        <a href="/deleteMovie?movieId=<%= movie.getId() %>" class="btn btn-danger">Delete</a>--%>
<%--                    </div>--%>
                </div>
            </div>
        </div>
        <%      }
        } else { %>
        <div class="col-12 text-center">
            <p>No movies available.</p>
        </div>
        <% } %>
    </div>
</div>

<% for (int i = 1; i <= totalPage; i++) { %>
<a class="btn btn-<%=currentPage==i?"success":"dark"%> m-1" href="?page=<%=i%><%=search!=""?"&search="+search:""%>"><%=i%></a>
<% } %>
<a href="/admin.jsp" class="btn btn-secondary">Back</a>
</body>
</html>
