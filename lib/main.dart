import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocpattern/blocs/weather/weather_bloc.dart';
import 'package:flutterblocpattern/repositories/weather_repository_impl.dart';

import 'ui/pages/weather_page.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  WeatherRepositoryImpl _weatherRepositoryImpl = WeatherRepositoryImpl();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        // Define the default brightness and colors.
        brightness: Brightness.dark,
        accentColor: Colors.white,
      ),
      home: BlocProvider(
        create: (context) =>
            WeatherBloc(weatherRepositoryImpl: _weatherRepositoryImpl),
        child: WeatherPage(),
      ),
    );
  }
}
