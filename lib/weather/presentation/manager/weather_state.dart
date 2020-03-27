import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutterblocpattern/weather/data/models/weather_model.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object> get props => [];
}

class WeatherEmpty extends WeatherState {}

class WeatherLoading extends WeatherState {}

class WeatherLoaded extends WeatherState {
  final WeatherModel weatherModel;

  const WeatherLoaded({@required this.weatherModel})
      : assert(weatherModel != null);

  @override
  List<Object> get props => [weatherModel];
}

class WeatherError extends WeatherState {}
