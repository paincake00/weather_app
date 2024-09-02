import 'package:weather_app/features/weather/domain/entities/forecasting_entity.dart';

class ForecastingModel extends ForecastingEntity {
  ForecastingModel({
    super.time,
    super.temperature,
    super.weatherCode,
  });

  factory ForecastingModel.fromJson(Map<String, dynamic> json) {
    return ForecastingModel(
      time: json['time'] ?? "",
      temperature: json['temperature_2m'] ?? 0.0,
      weatherCode: json['weather_code'] ?? 0,
    );
  }

  factory ForecastingModel.fromEntity(ForecastingEntity entity) {
    return ForecastingModel(
      time: entity.time,
      temperature: entity.temperature,
      weatherCode: entity.weatherCode,
    );
  }
}
