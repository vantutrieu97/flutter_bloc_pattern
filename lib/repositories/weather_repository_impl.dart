import 'dart:convert';

import 'package:flutterblocpattern/models/weather_model.dart';
import 'package:http/http.dart' as http;

abstract class WeatherRepository {
  Future<int> getLocationId(String city);

  Future<WeatherModel> fetchWeather(int locationId);

  Future<WeatherModel> getWeather(String city);
}

class WeatherRepositoryImpl extends WeatherRepository {
  static const baseUrl = 'https://www.metaweather.com';

  @override
  Future<WeatherModel> fetchWeather(int locationId) async {
    final weatherUrl = '$baseUrl/api/location/$locationId';
    final weatherResponse = await http.get(weatherUrl);

    if (weatherResponse.statusCode != 200) {
      throw Exception('error getting weather for location');
    }

    final weatherJson = jsonDecode(weatherResponse.body);
    WeatherModel _weatherModel = WeatherModel.fromJson(weatherJson);
    return _weatherModel;
  }

  @override
  Future<int> getLocationId(String city) async {
    final locationUrl = '$baseUrl/api/location/search/?query=$city';
    final locationResponse = await http.get(locationUrl);
    if (locationResponse.statusCode != 200) {
      throw Exception('error getting locationId for city');
    }

    final locationJson = jsonDecode(locationResponse.body) as List;
    return (locationJson.first)['woeid'];
  }

  @override
  Future<WeatherModel> getWeather(String city) async {
    final int locationId = await getLocationId(city);
    return fetchWeather(locationId);
  }
}
