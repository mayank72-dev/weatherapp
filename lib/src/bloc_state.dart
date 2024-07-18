import 'model/WeatherModel.dart';

abstract class WeatherState {}

class WeatherInitial extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel weather;

  WeatherLoaded({required this.weather});
}

class WeatherSaved extends WeatherState {}

class WeatherError extends WeatherState {
  final String message;

  WeatherError({required this.message});
}


