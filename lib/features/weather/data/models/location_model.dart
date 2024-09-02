import 'package:weather_app/features/weather/domain/entities/location_entity.dart';

class LocationModel extends LocationEntity {
  LocationModel({
    super.fullName,
    super.normalizedCity,
    super.state,
    super.country,
  });

  factory LocationModel.fromJson(Map<String, dynamic> json) {
    return LocationModel(
      fullName: json['formatted'] ?? "",
      normalizedCity: json['city'] ?? "",
      state: json['state'] ?? "",
      country: json['country'] ?? "",
    );
  }

  factory LocationModel.fromEntity(LocationEntity entity) {
    return LocationModel(
      fullName: entity.fullName,
      normalizedCity: entity.normalizedCity,
      state: entity.state,
      country: entity.country,
    );
  }
}
