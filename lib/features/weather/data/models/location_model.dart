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
      fullName: json['results'][0]['formatted'] ?? "",
      normalizedCity:
          json['results'][0]['components']['_normalized_city'] ?? "",
      state: json['results'][0]['components']['state'] ?? "",
      country: json['results'][0]['components']['country'] ?? "",
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
