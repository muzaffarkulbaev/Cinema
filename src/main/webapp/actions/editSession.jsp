<%@ page import="com.example.examproject.entity.User" %>
<%@ page import="com.example.examproject.entity.enums.Role" %>
<%@ page import="com.example.examproject.entity.Hall" %>
<%@ page import="java.util.List" %>
<%@ page import="static com.example.examproject.config.MyListener.hallService" %>
<%@ page import="com.example.examproject.entity.Session" %>
<%@ page import="static com.example.examproject.config.MyListener.sessionService" %>
<%@ page import="static com.example.examproject.config.MyListener.*" %>
<%@ page import="com.example.examproject.entity.Movie" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 06.04.2025
  Time: 16:43
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Edit Session</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

</head>
<body>

<%
    User user = (User)request.getSession().getAttribute("user");
    if (user.getRole() == Role.USER){
        response.sendRedirect("/cabinet.jsp");
    }
    int sessionId = 1;
    Session foundSession = new Session();
    try {
        sessionId = Integer.parseInt(request.getParameter("sessionId"));
        foundSession = sessionService.getById(Session.class, sessionId);
        if (foundSession == null) {
            response.sendRedirect("/admin.jsp");
        }
    } catch (NumberFormatException e) {
        System.out.println("Session Id = " + request.getParameter("sessionId"));
        e.printStackTrace();
    }

    foundSession.getHall().setIsAvailable(true);
    hallService.save(foundSession.getHall());
    List<Hall> allHalls = hallService.getAll(Hall.class);
    allHalls.removeIf(hall -> !hall.getIsAvailable());
    List<Movie> movies = movieService.getAll(Movie.class);
%>

<div class="container mt-5">
    <h2>Edit current Session</h2>
    <form enctype="multipart/form-data" action="/editSession?sessionId=<%=sessionId%>" method="post" class="p-4 bg-white shadow rounded">
        <div class="mb-3">
            <label for="movieId" class="form-label">Select Movie</label>
            <select class="form-select" id="movieId" name="movieId" required>
                <option value="" disabled selected><%=foundSession.getMovie().getName()%></option>
                <% for (Movie movie : movies) { %>
                <option value="<%= movie.getId() %>"><%= movie.getName()%></option>
                <% } %>
            </select>
        </div>
        <div class="mb-3">
            <label for="description" class="form-label">Session Time</label>
            <input value="<%=foundSession.getTime()%>" type="text" class="form-control" id="description" name="time" required></input>
        </div>
        <div class="mb-3">
            <label for="description" class="form-label">Price</label>
            <input value="<%=foundSession.getPrice()%>" type="number" class="form-control" id="price" name="price" required></input>
        </div>
        <div class="mb-3">
            <label for="hallId" class="form-label">Select Hall</label>
            <select class="form-select" id="hallId" name="hall" required>
                <option value=""><%=foundSession.getHall().getId()%></option>
                <%
                    for (Hall hall : allHalls) {
                %>
                <option value="<%= hall.getId() %>"><%= hall.getId()%></option>
                <%
                    }
                %>
            </select>
        </div>
        <button type="submit" class="btn btn-primary w-100">Add Session</button>
    </form>

    <a href="/actions/sessionList.jsp" class="btn btn-secondary">Back</a>

</div>

</body>
</html>
