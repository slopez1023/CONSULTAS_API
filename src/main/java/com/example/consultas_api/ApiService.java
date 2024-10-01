package com.example.consultas_api;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import jakarta.json.Json;
import jakarta.json.JsonObject;

public class ApiService {

    // Método para consumir la API de TRM
    public String getTrm(String date) {
        String urlString = "https://trm-colombia.vercel.app/?date=" + date;
        return makeApiRequest(urlString);
    }

    // Método para consumir la API del clima
    public String getWeather(String location) {
        // Reemplaza "YOUR_API_KEY" por la clave API que obtuviste
        String apiKey = "6efe0178ef386b151e623303b6f20181";
        String urlString = "http://api.weatherstack.com/current?access_key=" + apiKey + "&query=" + location;
        return makeApiRequest(urlString);
    }


    // Método para consumir la API de Rick and Morty
    public String getRickAndMortyCharacters() {
        String urlString = "https://rickandmortyapi.com/api/character";
        return makeApiRequest(urlString);
    }

    // Método genérico para hacer una solicitud HTTP GET
    private String makeApiRequest(String urlString) {
        try {
            URL url = new URL(urlString);
            HttpURLConnection con = (HttpURLConnection) url.openConnection();
            con.setRequestMethod("GET");
            BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
            String inputLine;
            StringBuilder content = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                content.append(inputLine);
            }
            in.close();
            con.disconnect();
            return content.toString();
        } catch (Exception e) {
            e.printStackTrace();
            return "Error al obtener datos de la API";
        }
    }

}