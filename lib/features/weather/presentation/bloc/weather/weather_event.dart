import 'package:latlong2/latlong.dart';

abstract class WeatherEvent {
  const WeatherEvent();
}

class GetWeatherEvent extends WeatherEvent {
  final LatLng coordinates;

  const GetWeatherEvent({required this.coordinates});
}
