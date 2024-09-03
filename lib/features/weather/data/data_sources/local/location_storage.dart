import 'package:latlong2/latlong.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LocationStorage {
  final SharedPreferences _sharedPreferences;

  LocationStorage({
    required SharedPreferences sharedPreferences,
  }) : _sharedPreferences = sharedPreferences;

  Future<void> setLocation({
    required LatLng coordinates,
  }) async {
    await _sharedPreferences.setDouble(
      LocationStorageKeys.latitude.key,
      coordinates.latitude,
    );
    await _sharedPreferences.setDouble(
      LocationStorageKeys.longitude.key,
      coordinates.longitude,
    );
  }

  Future<LatLng> getLocation() async {
    final latitude =
        _sharedPreferences.getDouble(LocationStorageKeys.latitude.key);
    final longitude =
        _sharedPreferences.getDouble(LocationStorageKeys.longitude.key);

    if (latitude == null || longitude == null) {
      return const LatLng(0, 0);
    }

    return LatLng(latitude, longitude);
  }
}

enum LocationStorageKeys {
  latitude('latitude'),
  longitude('longitude');

  final String key;

  const LocationStorageKeys(this.key);
}
