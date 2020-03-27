import 'package:flutter/material.dart';
import 'package:flutterblocpattern/weather/data/models/weather_model.dart';

class WeatherConditions extends StatelessWidget {
  final WeatherCondition condition;

  WeatherConditions({Key key, @required this.condition})
      : assert(condition != null),
        super(key: key);

  @override
  Widget build(BuildContext context) =>
      _mapConditionToImage(context, condition);

  Container _mapConditionToImage(
      BuildContext context, WeatherCondition condition) {
    double _screenWith = MediaQuery.of(context).size.width;
    String imageURI;
    switch (condition) {
      case WeatherCondition.clear:
      case WeatherCondition.lightCloud:
        imageURI = 'assets/clear.png';
        break;
      case WeatherCondition.hail:
      case WeatherCondition.snow:
      case WeatherCondition.sleet:
        imageURI = 'assets/snow.png';
        break;
      case WeatherCondition.heavyCloud:
        imageURI = 'assets/cloudy.png';
        break;
      case WeatherCondition.heavyRain:
      case WeatherCondition.lightRain:
      case WeatherCondition.showers:
        imageURI = 'assets/rainy.png';
        break;
      case WeatherCondition.thunderstorm:
        imageURI = 'assets/thunderstorm.png';
        break;
      case WeatherCondition.unknown:
        imageURI = 'assets/clear.png';
        break;
    }
    return Container(
      width: _screenWith/6,
      height: _screenWith/6,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imageURI),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}
