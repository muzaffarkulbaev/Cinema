<%@ page import="static com.example.examproject.config.MyListener.ticketService" %>
<%@ page import="com.example.examproject.entity.Ticket" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.examproject.entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>User Dashboard</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .ticket-table tbody tr:hover {
            background-color: #f1f1f1;
        }
        .card-header {
            background-color: #007bff;
            color: white;
        }
        .btn-custom {
            background-color: #dc3545;
            color: white;
        }
        .btn-custom:hover {
            background-color: #c82333;
        }
    </style>
</head>
<body>

<%
    User user = (User)request.getSession().getAttribute("user");
    List<Ticket> tickets = ticketService.getAll(Ticket.class);
    tickets.removeIf(Ticket::getIsDeleted);
    tickets.removeIf(ticket -> ticket.getUser().getId() != user.getId());
%>

<div class="container mt-5">
    <h2 class="mb-4">My Ticket List</h2>

    <div class="row">
        <% for (Ticket ticket : tickets) { %>
        <div class="col-md-4 mb-4">
            <div class="card">
                <div class="card-header">
                    <h5><%=ticket.getSession().getMovie().getName()%></h5>
                </div>
                <div class="card-body">
                    <p><strong>Time:</strong> <%=ticket.getSession().getTime()%></p>
                    <p><strong>Price:</strong> $<%=ticket.getSession().getPrice()%></p>
                    <p><strong>Seat Number:</strong> <%=ticket.getSeat().getId()%></p>
                </div>
                <div class="card-footer text-center">
                    <form action="/deleteTicket" method="post">
                        <input type="hidden" name="ticket" value="<%= ticket.getId() %>">
                        <button class="btn btn-custom">Delete</button>
                    </form>
                </div>
            </div>
        </div>
        <% } %>
    </div>

    <div class="mt-4">
        <a href="/cabinet.jsp" class="btn btn-secondary">Back</a>
    </div>
</div>

</body>
</html>
