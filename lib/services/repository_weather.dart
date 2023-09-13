import 'dart:convert';

import 'package:weatherapp/commons/constantes.dart';
import 'package:weatherapp/models/weather.dart';
import 'package:http/http.dart' as http;
class WeatherRepository {

  Future<Weather> getWeather(String latitude,String longitude) async {
      String url = 'https://api.weatherapi.com/v1/forecast.json?q=$latitude,$longitude&key=$apiKey';
      print(url);
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = response.body;
       
        return Weather.fromJson(jsonDecode(data));
        
      } else {
        throw Exception('Error al cargar el clima');
      }

  }
}