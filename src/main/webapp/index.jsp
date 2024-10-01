<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Inicio</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa;
        }
        .card-custom {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s, box-shadow 0.3s;
        }
        .card-custom:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3);
        }
        .fade-in {
            opacity: 0;
            animation: fadeIn 1s forwards;
        }
        @keyframes fadeIn {
            to {
                opacity: 1;
            }
        }
    </style>
</head>
<body class="fade-in">
<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Consultas API</a>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link active" href="index.jsp">Inicio</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="trm.jsp">Consultar TRM</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="clima.jsp">Consultar Clima</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="rickandmorty.jsp">Rick y Morty</a>
                </li>
            </ul>
        </div>
    </div>
</nav>

<div class="container">
    <h1 class="text-center mb-4">Bienvenido a Consultas API</h1>

    <div class="row">
        <div class="col-md-4 mb-3 fade-in">
            <div class="card card-custom">
                <div class="card-body">
                    <h5 class="card-title">Consultar TRM</h5>
                    <p class="card-text">Consulta la Tasa Representativa del Mercado para una fecha específica.</p>
                    <a href="trm.jsp" class="btn btn-primary w-100">Ir a TRM</a>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3 fade-in">
            <div class="card card-custom">
                <div class="card-body">
                    <h5 class="card-title">Consultar Clima</h5>
                    <p class="card-text">Obtén información sobre el clima en diferentes ciudades.</p>
                    <a href="clima.jsp" class="btn btn-primary w-100">Ir a Clima</a>
                </div>
            </div>
        </div>
        <div class="col-md-4 mb-3 fade-in">
            <div class="card card-custom">
                <div class="card-body">
                    <h5 class="card-title">Rick y Morty</h5>
                    <p class="card-text">Explora los personajes de la serie Rick y Morty.</p>
                    <a href="rickandmorty.jsp" class="btn btn-primary w-100">Ver Personajes</a>
                </div>
            </div>
        </div>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
