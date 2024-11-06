import 'package:weather_app/features/weather/data/models/forecasting_model.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';

class WeatherModel extends WeatherEntity {
  WeatherModel({
    super.timezone,
    super.currentTime,
    super.currentTemperature,
    super.isDay,
    super.currentWeatherCode,
    super.forecastings,
  });

  factory WeatherModel.fromJson(Map<String, dynamic> json) {
    return WeatherModel(
      timezone: json['timezone'] ?? "",
      currentTime: json['current']['time'] ?? "",
      currentTemperature: json['current']['temperature_2m'] ?? 0.0,
      isDay: json['current']['is_day'] ?? 0,
      currentWeatherCode: json['current']['weather_code'] ?? 0,
      forecastings: getForecastings(json['hourly']),
    );
  }

  static List<ForecastingModel> getForecastings(Map<String, dynamic> json) {
    List<ForecastingModel> forecastings = [];
    List<dynamic> times = json['time'];
    List<dynamic> temperatures = json['temperature_2m'];
    List<dynamic> weatherCodes = json['weather_code'];

    for (int i = 0; i < times.length; i++) {
      forecastings.add(
        ForecastingModel.fromJson(
          {
            'time': times[i],
            'temperature_2m': temperatures[i],
            'weather_code': weatherCodes[i],
          },
        ),
      );
    }

    return forecastings;
  }
}
