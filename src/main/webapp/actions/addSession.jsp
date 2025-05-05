<%@ page import="com.example.examproject.entity.Hall" %>
<%@ page import="com.example.examproject.entity.User" %>
<%@ page import="com.example.examproject.entity.enums.Role" %>
<%@ page import="java.util.List" %>
<%@ page import="static com.example.examproject.config.MyListener.hallService" %>
<%@ page import="static com.example.examproject.config.MyListener.movieService" %>
<%@ page import="com.example.examproject.entity.Movie" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 06.04.2025
  Time: 16:19
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Add Cinema Session</title>
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
<body>

<%
    User user = (User)request.getSession().getAttribute("user");
    List<Hall> allHalls = hallService.getAll(Hall.class);
    allHalls.removeIf(hall -> !hall.getIsAvailable());
    List<Movie> allMovies = movieService.getAll(Movie.class);
    if (user.getRole() == Role.USER){
        response.sendRedirect("/cabinet.jsp");
    }
%>

<div class="container mt-5">
    <h2>Add New Cinema Session</h2>
    <form action="/addSessionServlet" method="post" class="p-4 bg-white shadow rounded">
        <div class="mb-3">
            <label for="movieId" class="form-label">Select Movie</label>
            <select class="form-select" id="movieId" name="movieId" required>
                <option value="" disabled selected>-- Choose Movie --</option>
                <% for (Movie movie : allMovies) { %>
                <option value="<%= movie.getId() %>"><%= movie.getName()%></option>
                <% } %>
            </select>
        </div>
        <div class="mb-3">
            <label for="time" class="form-label">Session Time</label>
            <input type="text" class="form-control" id="time" name="time" required>
        </div>
        <div class="mb-3">
            <label for="price" class="form-label">Price</label>
            <input type="number" step="0.01" min="0" class="form-control" id="price" name="price" required>
        </div>
        <div class="mb-3">
            <label for="hallId" class="form-label">Select Hall</label>
            <select class="form-select" id="hallId" name="hallId" required>
                <option value="" disabled selected>-- Choose Hall --</option>
                <% for (Hall hall : allHalls) { %>
                <option value="<%= hall.getId() %>">Hall <%= hall.getId() %></option>
                <% } %>
            </select>
        </div>

        <button type="submit" class="btn btn-primary w-100">Add Session</button>
    </form>
    <a href="/admin.jsp" class="btn btn-secondary">Back</a>
</div>

</body>
</html>
