import 'package:weather_app/features/weather/domain/entities/forecasting_entity.dart';

class WeatherEntity {
  final String? timezone;
  final String? currentTime;
  final double? currentTemperature;
  final int? isDay;
  final int? curretnWeatherCode;
  final List<ForecastingEntity>? forecastings;

  WeatherEntity({
    this.timezone,
    this.currentTime,
    this.currentTemperature,
    this.isDay,
    this.curretnWeatherCode,
    this.forecastings,
  });
}
