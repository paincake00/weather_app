import 'package:latlong2/latlong.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/data/data_sources/remote/open_cage_data_api.dart';
import 'package:weather_app/features/weather/domain/entities/location_entity.dart';
import 'package:weather_app/features/weather/domain/repository/location_repository.dart';

class LocationRepositoryImpl implements LocationRepository {
  final OpenCageDataApi _geocodingApi;

  LocationRepositoryImpl({
    required OpenCageDataApi geocodingApiDioClient,
  }) : _geocodingApi = geocodingApiDioClient;

  @override
  Future<DataState<LocationEntity>> getLocationFromCoordinates(
    LatLng coordinates,
  ) async {
    return _geocodingApi.getLocationFromCoordinates(
      coordinates.latitude,
      coordinates.longitude,
    );
  }
}
