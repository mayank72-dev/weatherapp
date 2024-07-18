import 'package:weatherapp/src/model/WeatherModel.dart';


abstract class WeatherEvent {}

class FetchWeather extends WeatherEvent {
  final String cityName;

  FetchWeather({required this.cityName});
}

class SaveWeather extends WeatherEvent {
  final WeatherModel weather;

  SaveWeather({required this.weather});
}

