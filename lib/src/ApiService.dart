
import 'dart:convert';

import 'package:http/http.dart'as http;
import 'package:http/http.dart';
import 'package:weatherapp/src/model/WeatherModel.dart';






import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';


class ApiService {

  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<WeatherModel> fetchWeather(String cityName) async {
    final response = await http.get(Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=65ed9464d7ed14105d536bfe3b0077cb'));

    if (response.statusCode == 200) {
      return WeatherModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load weather data');
    }
  }

  Future<void> saveWeather(WeatherModel weather) async {
    await firestore.collection('weather').add(weather.toJson());
  }
}
