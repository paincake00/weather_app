import 'package:dio/dio.dart';
import 'package:weather_app/features/weather/domain/entities/location_entity.dart';

abstract class LocationState {
  final LocationEntity? locationEntity;
  final DioException? error;

  const LocationState({
    this.locationEntity,
    this.error,
  });
}

class LocationLoading extends LocationState {
  const LocationLoading();
}

class LocationDone extends LocationState {
  const LocationDone({
    required LocationEntity locationEntity,
  }) : super(locationEntity: locationEntity);
}

class LocationError extends LocationState {
  const LocationError({
    required DioException error,
  }) : super(error: error);
}
