import 'package:latlong2/latlong.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/data/data_sources/remote/open_meteo_api.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/domain/repository/weather_repository.dart';

class WeatherRepositoryImpl implements WeatherRepository {
  final OpenMeteoApi _openMeteoApi;

  WeatherRepositoryImpl({
    required OpenMeteoApi openMeteoApi,
  }) : _openMeteoApi = openMeteoApi;

  @override
  Future<DataState<WeatherEntity>> getWeatherFromCoordinates(
    LatLng coordinates,
  ) async {
    return _openMeteoApi.getWeatherFromCoordinates(
      coordinates.latitude,
      coordinates.longitude,
    );
  }
}
