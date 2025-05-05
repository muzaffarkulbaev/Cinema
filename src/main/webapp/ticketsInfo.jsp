<%@ page import="com.example.examproject.entity.Ticket" %>
<%@ page import="java.util.List" %>
<%@ page import="static com.example.examproject.config.MyListener.ticketService" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Мои билеты</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<%
//    User user = (User)request.getSession().getAttribute("user");
    List<Ticket> tickets = ticketService.getAll(Ticket.class);
%>

<h2>Tickets</h2>
<table class="table table-striped">
    <thead>
    <tr>
        <th>Ticket Id</th>
        <th>User Email</th>
        <th>Time of purchase</th>
        <th>Time of return</th>
    </tr>
    </thead>
    <tbody>
    <%-- Здесь будет динамическое отображение списка админов --%>
    <%-- Пример: --%>
    <% for (Ticket ticket : tickets) { %>
    <tr>
        <td><%=ticket.getId()%></td>
        <td><%=ticket.getUser().getEmail()%></td>
        <td><%=ticket.getCreateTime()%></td>
        <td>
            <%= ticket.getIsDeleted() ? ticket.getUpdateTime() : "---------" %>
        </td>

    </tr>
    <% } %>
    </tbody>
</table>
<a href="/admin.jsp" class="btn btn-success">Back</a>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
