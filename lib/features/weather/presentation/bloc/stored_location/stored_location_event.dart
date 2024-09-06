import 'package:latlong2/latlong.dart';

class StoredLocationEvent {
  final LatLng? coordinates;

  StoredLocationEvent({
    this.coordinates,
  });
}

class GetLocationEvent extends StoredLocationEvent {
  GetLocationEvent();
}

class SetLocationEvent extends StoredLocationEvent {
  SetLocationEvent({
    required LatLng coordinates,
  }) : super(coordinates: coordinates);
}
