import 'package:latlong2/latlong.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/domain/entities/location_entity.dart';

abstract class LocationRepository {
  Future<DataState<LocationEntity>> getLocationFromCoordinates(
    LatLng coordinates,
  );
}
