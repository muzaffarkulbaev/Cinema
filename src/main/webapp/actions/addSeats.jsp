<%@ page import="static com.example.examproject.config.MyListener.hallService" %>
<%@ page import="com.example.examproject.entity.Hall" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 06.04.2025
  Time: 16:22
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Add Seats</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .form-container {
            max-width: 600px;
            margin: 30px auto;
            padding: 20px;
            border: 1px solid #ddd;
            border-radius: 5px;
            background-color: #f9f9f9;
        }
    </style>
</head>
<body>

<%
    List<Hall> halls = hallService.getAll(Hall.class);
%>

<div class="container">
    <div class="form-container">
        <h2 class="text-center mb-4">Add Seats to Hall</h2>

        <form action="/addSeats" method="post">
            <div class="mb-3">
                <label for="hall" class="form-label">Select Hall:</label>
                <select class="form-select" id="hall" name="hall" required>
                    <option value="">-- Choose Hall --</option>
                    <%
                        for (Hall hall : halls) {
                    %>
                    <option value="<%= hall.getId() %>"><%= hall.getId()%></option>
                    <%
                        }
                    %>
                </select>
            </div>

            <div class="mb-3">
                <label for="seatCount" class="form-label">Number of Seats to Add:</label>
                <input type="number" class="form-control" id="seatCount" name="seatCount"
                       min="1" required placeholder="Enter seat quantity">
            </div>
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary">Add Seats</button>
                <a href="/admin.jsp" class="btn btn-secondary">Cancel</a>
            </div>
        </form>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>