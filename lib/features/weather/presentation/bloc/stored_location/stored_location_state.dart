import 'package:latlong2/latlong.dart';

class StoredLocationState {
  final LatLng? coordinates;

  const StoredLocationState({
    this.coordinates,
  });
}

class StoredLocationLoading extends StoredLocationState {
  const StoredLocationLoading();
}

class StoredLocationDone extends StoredLocationState {
  const StoredLocationDone({
    required LatLng coordinates,
  }) : super(coordinates: coordinates);
}
