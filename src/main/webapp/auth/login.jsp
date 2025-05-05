<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Login</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        .auth-card {
            width: 100%;
            max-width: 350px;
            border-radius: 10px;
            border: none;
            box-shadow: 0 4px 20px rgba(0, 0, 0, 0.08);
        }
        .auth-title {
            color: #495057;
            margin-bottom: 1.5rem;
            font-weight: 600;
        }
        .form-control {
            padding: 10px 15px;
            border-radius: 6px;
            border: 1px solid #e0e0e0;
        }
        .form-control:focus {
            border-color: #86b7fe;
            box-shadow: 0 0 0 0.25rem rgba(13, 110, 253, 0.15);
        }
        .btn-primary {
            background-color: #0d6efd;
            border: none;
            padding: 10px;
            border-radius: 6px;
            font-weight: 500;
        }
        .btn-success {
            background-color: #198754;
            border: none;
            padding: 10px;
            border-radius: 6px;
            font-weight: 500;
            width: 100%;
            margin-top: 10px;
        }
        .auth-footer {
            margin-top: 1.5rem;
            text-align: center;
            color: #6c757d;
        }
    </style>
</head>
<body class="d-flex justify-content-center align-items-center vh-100">
<div class="card p-4 auth-card">
    <h3 class="text-center auth-title">Login</h3>
    <form action="/login" method="post">
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input type="email" class="form-control" id="email" name="email" required>
        </div>
        <div class="mb-3">
            <label for="password" class="form-label">Password</label>
            <input type="password" class="form-control" id="password" name="password" required>
        </div>
        <div class="d-grid gap-2">
            <button type="submit" class="btn btn-primary">Login</button>
            <a href="/auth/register.jsp" class="btn btn-success">Register</a>
        </div>
        <div class="auth-footer">
            <small>Don't have an account? Register now</small>
        </div>
    </form>
</div>
</body>
</html>