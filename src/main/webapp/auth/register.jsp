<%@ page import="java.util.List" %>
<%@ page import="com.example.examproject.dto.ValidationError" %>
<%@ page import="com.example.examproject.service.ValidationService" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="com.example.examproject.entity.User" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<%
    Object object = request.getAttribute("errors");
    List<ValidationError> errors = new ArrayList<>();
    Object errorPassword = request.getAttribute("errorPassword");
    if (errorPassword == null) {
        errorPassword = "";
    }else errorPassword = errorPassword.toString();

    User oldData = (User) request.getAttribute("oldData");
    if (oldData == null) {
        oldData = new User(request);
    }

    if (object != null) {
        errors = (List<ValidationError>) object;
    }
    Object email = request.getAttribute("sameEmail");
    if (email == null){
        email = "";
    }
%>

<div class="container py-5">
    <div class="row justify-content-center">
        <div class="col-md-8 col-lg-6">
            <div class="card shadow-sm">
                <div class="card-header bg-white text-center py-3">
                    <h4 class="mb-0">Register</h4>
                </div>
                <div class="card-body p-4">
                    <form enctype="multipart/form-data" action="/register" method="post">
                        <div class="text-center mb-4">
                            <label for="photo">
                                <img id="previewImage" style="cursor: pointer; width: 100px; height: 100px;"
                                     class="rounded-circle object-fit-cover border"
                                     src="profile.png" alt="Profile picture">
                            </label>
                            <input name="photo" id="photo" type="file" class="d-none" accept="image/*">
                        </div>

                        <div class="mb-3">
                            <label for="firstName" class="form-label">First Name</label>
                            <input value="<%=oldData.getFirstName()%>" type="text" class="form-control" id="firstName" name="firstName">
                            <div class="form-text text-danger"><%=ValidationService.getErrorMessage(errors,"firstName")%></div>
                        </div>

                        <div class="mb-3">
                            <label for="lastName" class="form-label">Last Name</label>
                            <input value="<%=oldData.getLastName()%>" type="text" class="form-control" id="lastName" name="lastName">
                            <div class="form-text text-danger"><%=ValidationService.getErrorMessage(errors,"lastName")%></div>
                        </div>

                        <div class="mb-3">
                            <label for="phone" class="form-label">Phone Number</label>
                            <input value="<%=oldData.getPhoneNumber()%>" type="number" class="form-control" id="phone" name="phone">
                            <div class="form-text text-danger"><%=ValidationService.getErrorMessage(errors,"phoneNumber")%></div>
                        </div>

                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input value="<%=oldData.getEmail()%>" type="email" class="form-control" id="email" name="email">
                            <div class="form-text text-danger"><%=ValidationService.getErrorMessage(errors,"email")  + " " + email%></div>
                        </div>

                        <div class="mb-3">
                            <label for="password" class="form-label">Password</label>
                            <input value="<%=oldData.getPassword()%>" type="password" class="form-control" id="password" name="password">
                            <div class="form-text text-danger"><%=ValidationService.getErrorMessage(errors,"password")%></div>
                        </div>

                        <div class="mb-4">
                            <label for="password_repeat" class="form-label">Password Repeat</label>
                            <input type="password" class="form-control" id="password_repeat" name="passwordRepeat">
                            <div class="form-text text-danger"><%=errorPassword%></div>
                        </div>

                        <div class="d-grid gap-2 d-md-flex justify-content-md-between">
                            <button type="submit" class="btn btn-primary flex-grow-1">Register</button>
                            <a href="/auth/login.jsp" class="btn btn-success flex-grow-1">Login</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>

<script>
    document.getElementById("photo").addEventListener("change", function (event) {
        const file = event.target.files[0];
        if (file) {
            const reader = new FileReader();
            reader.onload = function (e) {
                document.getElementById("previewImage").src = e.target.result;
            };
            reader.readAsDataURL(file);
        }
    });
</script>
</body>
</html>