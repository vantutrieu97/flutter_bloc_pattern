import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocpattern/weather/data/repositories/weather_repository_impl.dart';
import 'package:flutterblocpattern/weather/data/models/weather_model.dart';
import 'package:flutterblocpattern/weather/presentation/manager/weather_event.dart';
import 'package:flutterblocpattern/weather/presentation/manager/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final WeatherRepositoryImpl weatherRepositoryImpl;

  WeatherBloc({@required this.weatherRepositoryImpl})
      : assert(weatherRepositoryImpl != null);

  @override
  WeatherState get initialState => WeatherEmpty();

  @override
  Stream<WeatherState> mapEventToState(WeatherEvent event) async* {
    if (event is FetchWeather) {
      yield* _mapFetchWeatherToState(event);
    } else if (event is RefreshWeather) {
      yield* _mapRefreshWeatherToState(event);
    }
  }

  Stream<WeatherState> _mapFetchWeatherToState(FetchWeather event) async* {
    yield WeatherLoading();
    var _city =
        event.city == null || event.city == '' ? 'Cape Town' : event.city;
    debugPrint('_city---------------------' + _city);
    try {
      final WeatherModel _weatherModel =
          await weatherRepositoryImpl.getWeather(_city);
      yield WeatherLoaded(weatherModel: _weatherModel);
    } catch (_) {
      yield WeatherError();
    }
  }

  Stream<WeatherState> _mapRefreshWeatherToState(RefreshWeather event) async* {
    try {
      final WeatherModel _weatherModel =
          await weatherRepositoryImpl.getWeather(event.city);
      yield WeatherLoaded(weatherModel: _weatherModel);
    } catch (_) {
      yield state;
    }
  }
}
