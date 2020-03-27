import 'package:flutterblocpattern/weather/data/models/weather_model.dart';

abstract class WeatherRepository {

  Future<int> getLocationId(String city);

  Future<WeatherModel> fetchWeather(int locationId);

  Future<WeatherModel> getWeather(String city);
}
