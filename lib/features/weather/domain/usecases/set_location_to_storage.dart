import 'package:latlong2/latlong.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/weather/domain/repository/location_repository.dart';

class SetLocationToStorageUseCase implements UseCase<void, LatLng> {
  final LocationRepository _locationRepository;

  SetLocationToStorageUseCase({
    required LocationRepository locationRepository,
  }) : _locationRepository = locationRepository;

  @override
  Future<void> call({required LatLng params}) async {
    _locationRepository.saveLocationToStorage(params);
  }
}
