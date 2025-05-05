<%@ page import="com.example.examproject.entity.User" %>
<%@ page import="com.example.examproject.entity.enums.Role" %><%--
  Created by IntelliJ IDEA.
  User: user
  Date: 07.04.2025
  Time: 15:05
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Admin Panel</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
<%
    User user = (User)request.getSession().getAttribute("user");
    if (user.getRole() == Role.USER){
        response.sendRedirect("/cabinet.jsp");
    }

%>
</body>
</html>
