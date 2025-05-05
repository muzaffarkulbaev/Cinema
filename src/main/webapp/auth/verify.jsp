<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>Verify Code</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="d-flex align-items-center justify-content-center vh-100 bg-light">
<div class="card shadow p-4 text-center" style="max-width: 400px;">
    <h3 class="mb-3">Enter Verification Code</h3>
    <form action="/verify" method="post">
        <div class="mb-3">
            <input type="number" name="code" class="form-control text-center" placeholder="4-digit code" required>
        </div>
        <button type="submit" class="btn btn-success w-100">Verify</button>
    </form>
</div>
</body>
</html>
