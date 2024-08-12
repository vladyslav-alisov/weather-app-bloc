import 'dart:convert';

import 'package:weather_app_bloc/data/data_provider/weather_data_provider.dart';
import 'package:weather_app_bloc/models/weather_model.dart';

class WeatherRepository {
  WeatherRepository(this._weatherDataProvider);

  final WeatherDataProvider _weatherDataProvider;

  Future<WeatherModel> getCurrentWeather() async {
    try {
      const cityName = 'Antalya';
      final weatherData = await _weatherDataProvider.getCurrentWeather(cityName);
      final data = jsonDecode(weatherData);

      if (data['cod'] != '200') {
        throw 'An unexpected error occurred';
      }

      return WeatherModel.fromMap(data);
    } catch (e) {
      throw e.toString();
    }
  }
}
