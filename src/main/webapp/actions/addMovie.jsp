<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 06.04.2025
  Time: 17:21
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%--<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>--%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add New Movie</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Font Awesome -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <style>
        body {
            background-color: #f8f9fa;
            padding-top: 20px;
        }
        .movie-form {
            max-width: 600px;
            margin: 0 auto;
            background: white;
            padding: 30px;
            border-radius: 10px;
            box-shadow: 0 0 20px rgba(0,0,0,0.1);
        }
        .form-title {
            text-align: center;
            margin-bottom: 30px;
            color: #343a40;
        }
        .preview-image {
            max-width: 200px;
            max-height: 200px;
            display: block;
            margin: 10px auto;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="movie-form">
        <h2 class="form-title">Add New Movie</h2>

        <form action="/addMovie" method="post" enctype="multipart/form-data">
            <!-- Name Field -->
            <div class="mb-3">
                <label for="name" class="form-label">Movie Name</label>
                <input type="text" class="form-control" id="name" name="name" required>
            </div>

            <!-- Photo Field -->
            <div class="mb-3">
                <label for="photo" class="form-label">Movie Poster</label>
                <input type="file" class="form-control" id="photo" name="photo" accept="image/*" required>
                <div id="imagePreview" class="mt-2"></div>
            </div>

            <!-- Duration Field -->
            <div class="mb-3">
                <label for="duration" class="form-label">Duration (minutes)</label>
                <input type="number" class="form-control" id="duration" name="duration" min="1" required>
            </div>

            <!-- Submit Button -->
            <div class="d-grid gap-2">
                <button type="submit" class="btn btn-primary">
                    <i class="fas fa-save me-2"></i>Add Movie
                </button>
                <a href="/admin.jsp" class="btn btn-secondary">
                    <i class="fas fa-arrow-left me-2"></i>Cancel
                </a>
            </div>
        </form>
    </div>
</div>

<!-- Bootstrap JS Bundle with Popper -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>

<!-- Image Preview Script -->
<script>
    document.getElementById('photo').addEventListener('change', function(event) {
        const file = event.target.files[0];
        const preview = document.getElementById('imagePreview');

        if (file) {
            const reader = new FileReader();

            reader.onload = function(e) {
                preview.innerHTML = '<img src="' + e.target.result + '" class="preview-image img-thumbnail" alt="Preview">';
            }

            reader.readAsDataURL(file);
        } else {
            preview.innerHTML = '';
        }
    });
</script>
</body>
</html>