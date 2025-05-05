<%@ page import="java.util.Objects" %>
<%@ page import="com.example.examproject.dto.SessionTotalPage" %>
<%@ page import="static com.example.examproject.config.MyListener.sessionService" %>
<%@ page import="com.example.examproject.entity.Session" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.examproject.entity.User" %>
<%@ page import="com.example.examproject.entity.enums.Role" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 06.04.2025
  Time: 16:22
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
    User user = (User) request.getSession().getAttribute("user");
    if (user.getRole() == Role.USER){
        response.sendRedirect("/cabinet.jsp");
    }
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
    }catch (Exception e){
        e.printStackTrace();
    }
    SessionTotalPage sessionTotalPage = sessionService.getByFilter(search, min, max, currentPage);
    List<Session> sessions = sessionTotalPage.sessions();
    totalPage = sessionTotalPage.totalPage();
%>

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

<!-- Сеансы кино -->
<div class="container mt-5">
    <h2 class="mb-4 text-center">Cinema Sessions</h2>
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
                    <p class="card-text">Price: <%= cinemaSession.getPrice() %></p>
<%--                    <div class="btn-group" role="group">--%>
<%--                        <a href="/actions/editSession.jsp?sessionId=<%= cinemaSession.getId() %>" class="btn btn-primary">Edit</a>--%>
<%--                        <a href="/deleteSession?sessionId=<%= cinemaSession.getId() %>" class="btn btn-danger">Delete</a>--%>
                    </div>
                </div>
            </div>
        </div>
        <%      }
        } else { %>
        <div class="col-12 text-center">
            <p>No cinema sessions available.</p>
        </div>
        <% } %>
    </div>
</div>

<% for (int i = 1; i <= totalPage; i++) { %>
<a class="btn btn-<%=currentPage==i?"success":"dark"%> m-1" href="?page=<%=i%><%=search!=""?"&search="+search:""%><%="&min="+min%><%="&max="+max%>"><%=i%></a>
<% } %>

<a href="/admin.jsp" class="btn btn-secondary">Back</a>

</body>
</html>
