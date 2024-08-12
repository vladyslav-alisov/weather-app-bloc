import 'dart:convert';

class WeatherModel {
  final num currentTemp;
  final String currentSky;
  final num currentPressure;
  final num currentWindSpeed;
  final num currentHumidity;
  final List<HourlyForecast> hourlyForecast;

  WeatherModel({
    required this.currentTemp,
    required this.currentSky,
    required this.currentPressure,
    required this.currentWindSpeed,
    required this.currentHumidity,
    required this.hourlyForecast,
  });

  factory WeatherModel.fromMap(Map<String, dynamic> map) {
    final currentWeatherData = map['list'][0];

    final List<HourlyForecast> hourlyForecastList = [];

    for (int index = 0; index < 5; index++) {
      final hourlyForecast = map['list'][index + 1];
      var result = HourlyForecast.fromMap(hourlyForecast);
      hourlyForecastList.add(result);
    }

    return WeatherModel(
      currentTemp: currentWeatherData['main']['temp'],
      currentSky: currentWeatherData['weather'][0]['main'],
      currentPressure: currentWeatherData['main']['pressure'],
      currentWindSpeed: currentWeatherData['wind']['speed'],
      currentHumidity: currentWeatherData['main']['humidity'],
      hourlyForecast: hourlyForecastList,
    );
  }

  factory WeatherModel.fromJson(String source) => WeatherModel.fromMap(jsonDecode(source) as Map<String, dynamic>);
}

class HourlyForecast {
  final String hourlySky;
  final String hourlyTemp;
  final DateTime time;

  HourlyForecast(this.hourlySky, this.hourlyTemp, this.time);

  factory HourlyForecast.fromMap(Map<String, dynamic> map) {
    final hourlySky = map['weather'][0]['main'];
    final hourlyTemp = map['main']['temp'].toString();
    final time = DateTime.parse(map['dt_txt']);

    return HourlyForecast(
      hourlySky,
      hourlyTemp,
      time,
    );
  }
}
