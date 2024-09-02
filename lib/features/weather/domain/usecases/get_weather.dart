import 'package:latlong2/latlong.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/core/usecase/usecase.dart';
import 'package:weather_app/features/weather/domain/entities/weather_entity.dart';
import 'package:weather_app/features/weather/domain/repository/weather_repository.dart';

class GetWeatherUseCase implements UseCase<DataState<WeatherEntity>, LatLng> {
  final WeatherRepository _weatherRepository;

  GetWeatherUseCase({
    required WeatherRepository weatherRepository,
  }) : _weatherRepository = weatherRepository;

  @override
  Future<DataState<WeatherEntity>> call({required LatLng params}) {
    return _weatherRepository.getWeatherFromCoordinates(params);
  }
}
