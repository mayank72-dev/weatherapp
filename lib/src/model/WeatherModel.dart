

class WeatherModel {
  final String cityName;
  final double temperature;


  WeatherModel({required this.cityName, required this.temperature,});

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      cityName: json['name'],
      temperature: json['main']['temp'].toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'cityName': cityName,
      'temperature': temperature,

    };
  }
}


