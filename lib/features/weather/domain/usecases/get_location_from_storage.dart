import 'package:latlong2/latlong.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/weather/domain/repository/location_repository.dart';

class GetLocationFromStorageUseCase implements UseCase<LatLng, void> {
  final LocationRepository _locationRepository;

  GetLocationFromStorageUseCase({
    required LocationRepository locationRepository,
  }) : _locationRepository = locationRepository;

  @override
  Future<LatLng> call({required void params}) {
    return _locationRepository.getLocationFromStorage();
  }
}
