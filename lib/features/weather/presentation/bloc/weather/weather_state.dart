import 'package:dio/dio.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';

abstract class WeatherState {
  final WeatherEntity? weatherEntity;
  final DioException? error;

  const WeatherState({
    this.weatherEntity,
    this.error,
  });
}

class WeatherLoading extends WeatherState {
  const WeatherLoading();
}

class WeatherDone extends WeatherState {
  const WeatherDone({
    required WeatherEntity weatherEntity,
  }) : super(weatherEntity: weatherEntity);
}

class WeatherError extends WeatherState {
  const WeatherError({
    required DioException error,
  }) : super(error: error);
}
