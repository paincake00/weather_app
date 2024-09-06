import 'package:latlong2/latlong.dart';

abstract class LocationEvent {
  const LocationEvent();
}

class GetLocationEvent extends LocationEvent {
  final LatLng coordinates;

  const GetLocationEvent({required this.coordinates});
}
