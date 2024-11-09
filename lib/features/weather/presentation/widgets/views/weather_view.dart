import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_state.dart';
import 'package:weather_app/features/weather/presentation/widgets/components/weather_widget.dart';

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return const Text('Loading...');
        }
        if (state is WeatherDone) {
          final weather = state.weatherEntity;
          if (weather != null) {
            return WeatherWidget(
              timezone: weather.timezone,
              currentTime: weather.currentTime,
              currentTemperature: weather.currentTemperature,
              isDay: weather.isDay,
              currentWeatherCode: weather.currentWeatherCode,
              forecastings: weather.forecastings,
            );
          }
          return const WeatherWidget();
        }
        if (state is WeatherError) {
          return Text(
            state.error.toString(),
          );
        }
        return const SizedBox();
      },
    );
  }
}
