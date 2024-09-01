import 'package:weather_app/features/weather/domain/entities/forecasting.dart';

class Weather {
  final String? timezone;
  final String? currentTime;
  final double? currentTemperature;
  final int? isDay;
  final int? curretnWeatherCode;
  final List<Forecasting>? forecastings;

  Weather({
    this.timezone,
    this.currentTime,
    this.currentTemperature,
    this.isDay,
    this.curretnWeatherCode,
    this.forecastings,
  });
}
