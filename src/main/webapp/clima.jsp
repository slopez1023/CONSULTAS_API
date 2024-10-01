<%@ page import="com.example.consultas_api.ApiService" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.json.Json"%>
<%@ page import="jakarta.json.JsonObject"%>
<%@ page import="jakarta.json.JsonReader"%>
<%@ page import="java.io.StringReader"%>

<%
  String location = request.getParameter("location");
  ApiService apiService = new ApiService();
  String weatherResponse = null;
  JsonObject weatherData = null;

  if (location != null && !location.isEmpty()) {
    weatherResponse = apiService.getWeather(location);

    if (weatherResponse != null && !weatherResponse.contains("\"success\":false")) {
      try (JsonReader jsonReader = Json.createReader(new StringReader(weatherResponse))) {
        weatherData = jsonReader.readObject();
      }
    }
  }
%>
<html>
<head>
  <title>Consulta de Clima</title>
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
    <a class="navbar-brand" href="#">Mi Aplicación</a>
    <div class="collapse navbar-collapse" id="navbarNav">
      <ul class="navbar-nav">
        <li class="nav-item">
          <a class="nav-link" href="index.jsp">Inicio</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="trm.jsp">Consultar TRM</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="clima.jsp">Consultar Clima</a>
        </li>
        <li class="nav-item">
          <a class="nav-link" href="rickandmorty.jsp">Rick y Morty</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<div class="container">
  <h1 class="text-center mb-4">Consulta de Clima</h1>

  <div class="card p-4 mb-4 card-custom fade-in">
    <form onsubmit="return validateForm()" method="get" class="mb-3">
      <div class="mb-3">
        <label for="city" class="form-label">Ingresa el nombre de la ciudad:</label>
        <input type="text" class="form-control" id="city" name="location" placeholder="Ej: Bogotá">
      </div>
      <button type="submit" class="btn btn-primary w-100">Consultar Clima</button>
    </form>
  </div>

  <% if (weatherResponse != null) { %>
  <div class="row">
    <div class="col-md-6 mb-3">
      <div class="card p-3 bg-light card-custom fade-in">
        <h5 class="card-title">Respuesta en JSON</h5>
        <pre class="card-text"><%= weatherResponse %></pre>
      </div>
    </div>

    <% if (weatherData != null) {
      String cityName = weatherData.getJsonObject("location").getString("name");
      String country = weatherData.getJsonObject("location").getString("country");
      int temperature = weatherData.getJsonObject("current").getInt("temperature");
      String description = weatherData.getJsonObject("current").getJsonArray("weather_descriptions").getString(0);
      int windSpeed = weatherData.getJsonObject("current").getInt("wind_speed");
      int humidity = weatherData.getJsonObject("current").getInt("humidity");
    %>
    <div class="col-md-6 mb-3">
      <div class="card p-3 card-custom fade-in">
        <h5 class="card-title">Información del Clima</h5>
        <ul class="list-group">
          <li class="list-group-item"><strong>Ciudad:</strong> <%= cityName %></li>
          <li class="list-group-item"><strong>País:</strong> <%= country %></li>
          <li class="list-group-item"><strong>Temperatura:</strong> <%= temperature %> °C</li>
          <li class="list-group-item"><strong>Descripción:</strong> <%= description %></li>
          <li class="list-group-item"><strong>Velocidad del Viento:</strong> <%= windSpeed %> km/h</li>
          <li class="list-group-item"><strong>Humedad:</strong> <%= humidity %>%</li>
        </ul>
      </div>
    </div>
    <% } else { %>
    <div class="col-md-6 fade-in">
      <div class="alert alert-danger">
        <strong>Error:</strong> No se encontraron datos del clima para la ciudad especificada.
      </div>
    </div>
    <% } %>
  </div>
  <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
