import 'package:latlong2/latlong.dart';

class StoredLocationEvent {
  final LatLng? coordinates;

  StoredLocationEvent({
    this.coordinates,
  });
}

class GetCoordsEvent extends StoredLocationEvent {
  GetCoordsEvent();
}

class SetCoordsEvent extends StoredLocationEvent {
  SetCoordsEvent({
    required LatLng coordinates,
  }) : super(coordinates: coordinates);
}
