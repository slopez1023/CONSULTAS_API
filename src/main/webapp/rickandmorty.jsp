<%@ page import="com.example.consultas_api.ApiService" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="jakarta.json.Json"%>
<%@ page import="jakarta.json.JsonObject"%>
<%@ page import="jakarta.json.JsonArray"%>
<%@ page import="jakarta.json.JsonReader"%>
<%@ page import="java.io.StringReader"%>

<%
  ApiService apiService = new ApiService();
  String rickAndMortyResponse = apiService.getRickAndMortyCharacters();
  JsonObject rickAndMortyData = null;
  JsonArray charactersArray = null;

  if (rickAndMortyResponse != null && !rickAndMortyResponse.contains("\"error\"")) {
    try (JsonReader jsonReader = Json.createReader(new StringReader(rickAndMortyResponse))) {
      rickAndMortyData = jsonReader.readObject();
      charactersArray = rickAndMortyData.getJsonArray("results");
    }
  }
%>
<html>
<head>
  <title>Personajes de Rick and Morty</title>
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
          <a class="nav-link" href="clima.jsp">Consultar Clima</a>
        </li>
        <li class="nav-item">
          <a class="nav-link active" href="rickandmorty.jsp">Rick y Morty</a>
        </li>
      </ul>
    </div>
  </div>
</nav>

<div class="container">
  <h1 class="text-center mb-4">Personajes de Rick and Morty</h1>

  <% if (rickAndMortyResponse != null) { %>
  <div class="row">
    <div class="col-md-6 mb-3">
      <div class="card p-3 bg-light card-custom fade-in">
        <h5 class="card-title">Respuesta en JSON</h5>
        <pre class="card-text"><%= rickAndMortyResponse %></pre>
      </div>
    </div>

    <% if (charactersArray != null && charactersArray.size() > 0) { %>
    <div class="col-md-6 mb-3">
      <div class="card p-3 card-custom fade-in">
        <h5 class="card-title">Información de Personajes</h5>
        <div class="list-group">
          <% for (int i = 0; i < charactersArray.size(); i++) {
            JsonObject character = charactersArray.getJsonObject(i);
            String characterName = character.getString("name");
            String characterStatus = character.getString("status");
            String characterSpecies = character.getString("species");
            String characterGender = character.getString("gender");
            String characterImage = character.getString("image");
          %>
          <div class="list-group-item mb-3 fade-in">
            <h5><strong>Nombre:</strong> <%= characterName %></h5>
            <p><strong>Estado:</strong> <%= characterStatus %></p>
            <p><strong>Especie:</strong> <%= characterSpecies %></p>
            <p><strong>Género:</strong> <%= characterGender %></p>
            <img src="<%= characterImage %>" alt="Imagen de <%= characterName %>" class="img-fluid rounded">
          </div>
          <% } %>
        </div>
      </div>
    </div>
    <% } %>
  </div>
  <% } %>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>