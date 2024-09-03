import 'package:latlong2/latlong.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/data/data_sources/local/location_storage.dart';
import 'package:weather_app/features/weather/data/data_sources/remote/open_cage_data_api.dart';
import 'package:weather_app/features/weather/domain/entities/location_entity.dart';
import 'package:weather_app/features/weather/domain/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  // API
  final OpenCageDataApi _geocodingApi;

  // LOCAL STORAGE
  final LocationStorage _locationStorage;

  LocationRepositoryImpl({
    required OpenCageDataApi geocodingApiDioClient,
    required LocationStorage locationStorage,
  })  : _geocodingApi = geocodingApiDioClient,
        _locationStorage = locationStorage;

  @override
  Future<DataState<LocationEntity>> getLocationFromCoordinates(
    LatLng coordinates,
  ) async {
    return _geocodingApi.getLocationFromCoordinates(
      coordinates.latitude,
      coordinates.longitude,
    );
  }

  @override
  Future<LatLng> getLocationFromStorage() async {
    return await _locationStorage.getLocation();
  }

  @override
  Future<void> saveLocationToStorage(LatLng coordinates) async {
    await _locationStorage.setLocation(coordinates: coordinates);
  }
}
