import 'package:latlong2/latlong.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/location_entity.dart';
import 'package:weather_app/features/weather/domain/repository/location_repository.dart';

class GetLocationUseCase implements UseCase<DataState<LocationEntity>, LatLng> {
  final LocationRepository _locationRepository;

  GetLocationUseCase({
    required LocationRepository locationRepository,
  }) : _locationRepository = locationRepository;

  @override
  Future<DataState<LocationEntity>> call({required LatLng params}) {
    return _locationRepository.getLocationFromCoordinates(params);
  }
}
