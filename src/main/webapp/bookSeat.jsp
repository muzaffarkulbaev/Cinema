<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.examproject.entity.Session" %>
<%@ page import="static com.example.examproject.config.MyListener.sessionService" %>
<%@ page import="com.example.examproject.entity.Seat" %>
<%@ page import="static com.example.examproject.config.MyListener.seatService" %>
<%@ page import="com.example.examproject.entity.User" %>
<!-- замените на ваш пакет -->
<html>
<head>
    <title>Выбери место</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        .seat-checkbox {
            display: none;
        }

        .seat-label {
            width: 40px;
            height: 40px;
            display: inline-block;
            margin: 5px;
            border-radius: 5px;
            line-height: 40px;
            text-align: center;
            cursor: pointer;
            font-weight: bold;
            border: 2px solid transparent;
            transition: all 0.3s ease;
        }

        /* Свободное место (красное) */
        .available {
            background-color: #dc3545; /* красный */
            color: white;
        }

        /* Занятое место (зелёное, неактивное) */
        .taken {
            background-color: #28a745; /* зелёный */
            color: white;
            cursor: not-allowed;
            pointer-events: none;
        }

        /* При выборе — синий */
        .seat-checkbox:checked + .seat-label.available {
            background-color: #0d6efd; /* синий */
            border-color: #0d6efd;
        }
    </style>
</head>
<body class="bg-light">

<%
    User user = (User)request.getSession().getAttribute("user");
    int sessionId = Integer.parseInt(request.getParameter("sessionId"));
    Session sessionById = sessionService.getById(Session.class,sessionId);
    List<Seat> seats = seatService.findSeatsByHall(sessionById.getHall());
//    User user = (User)request.getSession().getAttribute("user");
%>

<div class="container text-center mt-5">
    <h1 class="mb-4">Select place</h1>
    <h1 class="mb-4">Hall : <%=sessionById.getHall().getId()%></h1>

    <form action="/bookPlace?userId=<%=user.getId()%>&sessionId=<%=sessionId%>" method="post">
<%--        <div class="d-flex flex-column align-items-center">--%>
<%--            <%--%>
<%--                int number = 1;--%>
<%--                for (int i = 0; i < seats.size(); i++) {--%>
<%--                    if (i % 10 == 0) { // начинаем новый ряд--%>
<%--            %>--%>
<%--            <div class="d-flex justify-content-center mb-2">--%>
<%--                <%--%>
<%--                    }--%>

<%--                    Seat seat = seats.get(i);--%>
<%--                    boolean taken = seat.getIsBooked();--%>
<%--                %>--%>
<%--                <input--%>
<%--                        type="checkbox"--%>
<%--                        class="seat-checkbox"--%>
<%--                        name="seat"--%>
<%--                        id="seat<%=number%>"--%>
<%--                        value="<%=seat.getId()%>"--%>
<%--                    <%= taken ? "disabled" : "" %>--%>
<%--                >--%>
<%--                <label--%>
<%--                        for="seat<%=number%>"--%>
<%--                        class="seat-label <%= taken ? "taken" : "available" %>">--%>
<%--                    <%=number%>--%>
<%--                </label>--%>
<%--                <%--%>
<%--                    if ((i + 1) % 10 == 0 || i == seats.size() - 1) { // заканчиваем ряд--%>
<%--                %>--%>
<%--            </div>--%>
<%--            <%--%>
<%--                    }--%>
<%--                    number++;--%>
<%--                }--%>
<%--            %>--%>
<%--        </div>--%>

    <div class="d-flex flex-column align-items-center">
        <%
            int seatNumber = 1;
            int totalSeats = seats.size(); // Получаем количество мест
            int rows = (totalSeats / 10) + (totalSeats % 10 > 0 ? 1 : 0); // Количество строк (с учетом остатка)

            for (int row = 0; row < rows; row++) {
        %>
        <div class="d-flex justify-content-center mb-2">
            <%
                for (int col = 0; col < 10; col++) {
                    if (seatNumber <= totalSeats) { // Проверяем, есть ли место для отображения
                        Seat seat = seats.get(seatNumber - 1);
                        boolean taken = seat.getIsBooked();
            %>
            <input
                    type="checkbox"
                    class="seat-checkbox"
                    name="seatIds"
                    id="seat<%= seatNumber %>"
                    value="<%= seat.getId() %>"
                <%= taken ? "disabled" : "" %>
            >
            <label
                    for="seat<%= seatNumber %>"
                    class="seat-label <%= taken ? "taken" : "available" %>">
                <%= seatNumber %>
            </label>
            <%
                        seatNumber++;
                    }
                }
            %>
        </div>
        <% } %>
    </div>

    <button type="submit" class="btn btn-primary mt-4">Book</button>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
