import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:weatherapp/src/ApiService.dart';
import '../bloc_state.dart';
import 'bloc_event.dart';


class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  /// Api servoce
  final ApiService apiservice;

  WeatherBloc(this.apiservice) : super(WeatherInitial()) {

    /// fetch data
    on<FetchWeather>((event, emit) async {
      emit(WeatherLoading());
      try {
        final weather = await apiservice.fetchWeather(event.cityName);
        emit(WeatherLoaded(weather: weather));
      } catch (e) {
        emit(WeatherError(message: e.toString()));
      }
    });
/// save data
    on<SaveWeather>((event, emit) async {
      try {
        await apiservice.saveWeather(event.weather);
        emit(WeatherSaved());
      } catch (e) {
        emit(WeatherError(message: e.toString()));
      }
    });
  }
}

















/*
import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weatherapp/src/ApiService.dart';

import '../bloc_state.dart';
import '../model/WeatherModel.dart';
import 'bloc_event.dart';



class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final ApiService _apiService = ApiService();

  WeatherBloc() : super(WeatherInitialState()) {
    on<FetchWeatherEvent>((event, emit) => _fetchWeatherData(event, emit));
  }

  Future<void> _fetchWeatherData(
      FetchWeatherEvent event, Emitter<WeatherState> emit) async {
    try {
      emit(WeatherLoadingState());
      final response = await _apiService.getWeatherData(event.location);
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        WeatherModel weatherModel =
        WeatherModel.fromJson(jsonDecode(response.body));
        emit(WeatherLoadedState(weatherModel));
     */
/*   WeatherModel weather= WeatherModel.fromJson(data);
        emit(WeatherLoadedState(saveWeatherData()));*//*

      } else if (response.statusCode == 404) {
        final data = jsonDecode(response.body);
        emit(WeatherLoadingFailureState(data['message']));
      } else {
        emit(
            WeatherLoadingFailureState('Unknown error ${response.statusCode}'));
      }
    } catch (error) {
      emit(WeatherLoadingFailureState('Unable to fetch weather data'));
      debugPrint('_fetchWeatherDataError: $error');
    }
  }
  }
  */
/*aveWeatherData(Map<String, dynamic> weatherData) async {
    await FirebaseFirestore.instance.collection('weather').add(weatherData);
  }*//*

  saveWeatherData( WeatherModel weatherModel) async {
     await FirebaseFirestore.instance.collection('weather').add(weatherModel.toJson());

  }




*/
