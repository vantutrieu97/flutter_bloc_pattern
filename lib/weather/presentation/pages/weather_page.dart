import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutterblocpattern/weather/presentation/manager/weather_bloc.dart';
import 'package:flutterblocpattern/weather/presentation/manager/weather_event.dart';
import 'package:flutterblocpattern/weather/presentation/manager/weather_state.dart';
import 'package:flutterblocpattern/weather/presentation/widgets/weather_conditions.dart';

class WeatherPage extends StatefulWidget {
  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Container(
          constraints: BoxConstraints.expand(),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.6, 0.8, 1.0],
              colors: [
                Colors.lightBlue[300],
                Colors.lightBlue[500],
                Colors.lightBlue[700],
              ],
            ),
          ),
          child: Center(
            child: BlocConsumer<WeatherBloc, WeatherState>(
              listener: (context, state) {},
              builder: (context, state) {
                if (state is WeatherLoading) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(
                          backgroundColor: Colors.green,
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Text(
                          '...Loading...',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  );
                }
                else if (state is WeatherLoaded) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '${state.weatherModel.location} city',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 2,
                      ),
                      Text(
                        'Last updated: ${TimeOfDay.fromDateTime(state.weatherModel.lastUpdated).format(context)}',
//                        'Updated: 27-03-2020',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: Colors.white,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          WeatherConditions(
                              condition: state.weatherModel.condition),
                          SizedBox(
                            width: 6,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text(
                                'Min: ${state.weatherModel.minTemp.toDouble().round()}°',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                'Max: ${state.weatherModel.maxTemp.toDouble().round()}°',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                      Text(
                        '${state.weatherModel.formattedCondition}',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w200,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 16,
                      ),
                      SeacrLocationWidget(),
                    ],
                  );
                }
                else if (state is WeatherError) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        'Something went wrong!',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        height: 6,
                      ),
                      SeacrLocationWidget()
                    ],
                  );
                }
                return SeacrLocationWidget();
              },
            ),
          ),
        ),
      ),
    );
  }
}

class SeacrLocationWidget extends StatefulWidget {
  @override
  _SeacrLocationWidgetState createState() => _SeacrLocationWidgetState();
}

class _SeacrLocationWidgetState extends State<SeacrLocationWidget> {
  TextEditingController _fillLocationController;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _fillLocationController = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Container(
          padding: const EdgeInsets.only(
            left: 32,
            right: 32,
          ),
          height: 40,
          decoration: BoxDecoration(
            color: Colors.transparent,
          ),
          child: TextField(
            autofocus: true,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(4),
                ),
                borderSide: BorderSide(
                  width: 1,
                  color: Colors.yellowAccent,
                ),
              ),
              labelText: 'City',
            ),
            controller: _fillLocationController,
            onSubmitted: (city) => BlocProvider.of<WeatherBloc>(context).add(
              FetchWeather(city: _fillLocationController.text),
            ),
          ),
        ),
        GestureDetector(
          child: IconButton(
            icon: Icon(
              Icons.search,
              color: Colors.white,
              size: 42,
            ),
            tooltip: 'CLick to fecth new data',
            onPressed: () => {
              BlocProvider.of<WeatherBloc>(context).add(
                FetchWeather(city: _fillLocationController.text),
              ),
            },
          ),
        ),
      ],
    );
    ;
  }
}
