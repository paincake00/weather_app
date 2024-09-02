import 'package:latlong2/latlong.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';

abstract class WeatherRepository {
  Future<DataState<WeatherEntity>> getWeatherFromCoordinates(
    LatLng coordinates,
  );
}
