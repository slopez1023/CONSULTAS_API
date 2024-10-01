<%@ page import="com.example.consultas_api.ApiService" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.json.Json"%>
<%@ page import="jakarta.json.JsonObject"%>
<%@ page import="jakarta.json.JsonReader"%>
<%@ page import="java.io.StringReader"%>

<%
    String date = request.getParameter("date");
    ApiService apiService = new ApiService();
    String trmResponse = null;
    JsonObject trmData = null;

    if (date != null && !date.isEmpty()) {
        trmResponse = apiService.getTrm(date);

        // Verificamos si la respuesta es válida y contiene datos
        if (trmResponse != null && trmResponse.contains("\"success\":true")) {
            try (JsonReader jsonReader = Json.createReader(new StringReader(trmResponse))) {
                trmData = jsonReader.readObject();
            }
        }
    }
%>
<html>
<head>
    <title>Consulta de TRM</title>
    <meta charset="UTF-8">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa; /* Fondo claro */
        }
        .card-custom {
            border-radius: 10px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.2);
            transition: transform 0.3s, box-shadow 0.3s; /* Transición para la animación */
        }
        .card-custom:hover {
            transform: translateY(-5px); /* Animación de elevar */
            box-shadow: 0 8px 16px rgba(0, 0, 0, 0.3); /* Cambio de sombra al pasar el mouse */
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
        .navbar {
            margin-bottom: 20px;
        }
    </style>
</head>
<body class="fade-in"> <!-- Agrega la clase fade-in para animación de aparición -->
<!-- Barra de navegación -->
<nav class="navbar navbar-expand-lg navbar-dark bg-primary mb-4">
    <div class="container-fluid">
        <a class="navbar-brand" href="#">Mi Aplicación</a>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav">
                <li class="nav-item">
                    <a class="nav-link" href="index.jsp">Inicio</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link active" href="trm.jsp">Consultar TRM</a>
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
    <h1 class="text-center mb-4">Consulta de TRM</h1>

    <!-- Formulario para ingresar la fecha -->
    <div class="card p-4 mb-4 card-custom fade-in">
        <form onsubmit="return validateForm()" method="get" class="mb-3">
            <div class="mb-3">
                <label for="date" class="form-label">Ingresa la fecha (YYYY-MM-DD):</label>
                <input type="text" class="form-control" id="date" name="date" placeholder="Ej: 2024-06-15">
            </div>
            <button type="submit" class="btn btn-primary w-100">Consultar TRM</button>
        </form>
    </div>

    <% if (trmResponse != null) { %>
    <div class="row">
        <!-- Mostrar el JSON completo -->
        <div class="col-md-6 mb-3">
            <div class="card p-3 bg-light card-custom fade-in">
                <h5 class="card-title">Respuesta en JSON</h5>
                <pre class="card-text"><%= trmResponse %></pre>
            </div>
        </div>

        <% if (trmData != null && trmData.containsKey("data")) {
            JsonObject dataObject = trmData.getJsonObject("data");
            double trmValue = dataObject.getJsonNumber("value").doubleValue();
            String validityFrom = dataObject.getString("validityFrom");
            String validityTo = dataObject.getString("validityTo");
            String unit = dataObject.getString("unit");
        %>
        <!-- Mostrar información organizada y bonita -->
        <div class="col-md-6 mb-3">
            <div class="card p-3 card-custom fade-in">
                <h5 class="card-title">Información de la TRM</h5>
                <ul class="list-group">
                    <li class="list-group-item"><strong>Valor TRM:</strong> $<%= trmValue %> <%= unit %></li>
                    <li class="list-group-item"><strong>Válido desde:</strong> <%= validityFrom %></li>
                    <li class="list-group-item"><strong>Válido hasta:</strong> <%= validityTo %></li>
                </ul>
            </div>
        </div>
        <% } else { %>
        <!-- Mensaje de error si no se encuentran los datos de TRM -->
        <div class="col-md-6 fade-in">
            <div class="alert alert-danger">
                <strong>Error:</strong> No se encontraron datos de TRM para la fecha especificada. Por favor, verifica la fecha ingresada o intenta nuevamente más tarde.
            </div>
        </div>
        <% } %>
    </div>
    <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>