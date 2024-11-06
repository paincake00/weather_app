import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:weather_app/features/weather/presentation/bloc/location/location_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/location/location_state.dart';
import 'package:weather_app/features/weather/presentation/bloc/location/location_event.dart';
import 'package:weather_app/features/weather/presentation/bloc/stored_location/stored_location_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/stored_location/stored_location_event.dart';
import 'package:weather_app/features/weather/presentation/bloc/stored_location/stored_location_state.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
  });

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final MapController _mapController;

  @override
  void initState() {
    _mapController = MapController();
    super.initState();
  }

  @override
  void dispose() {
    _mapController.dispose();
    super.dispose();
  }

  void _showSnackBarBloc() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.black,
        content: BlocBuilder<LocationBloc, LocationState>(
          builder: (context, state) {
            if (state is LocationLoading) {
              return const Text('Loading...');
            }
            if (state is LocationDone) {
              return Text(
                state.locationEntity!.fullName ?? 'undefined',
                style: const TextStyle(color: Colors.white),
              );
            }
            if (state is LocationError) {
              return Text(
                state.error.toString(),
                style: const TextStyle(color: Colors.white),
              );
            }
            return const SizedBox();
          },
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<StoredLocationBloc, StoredLocationState>(
          builder: (BuildContext context, StoredLocationState state) {
            if (state is StoredLocationLoading) {
              return const Text('Loading...');
            }
            if (state is StoredLocationDone) {
              final coords = state.coordinates!;
              return Text(
                '${coords.latitude.toStringAsFixed(2)}, ${coords.longitude.toStringAsFixed(2)}',
              );
            }
            return const Text('Map');
          },
        ),
      ),
      body: ColoredBox(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: FlutterMap(
              mapController: _mapController,
              options: MapOptions(
                initialCenter: const LatLng(55, 37),
                initialZoom: 5,
                minZoom: 3,
                maxZoom: 10,
                onTap: (TapPosition tapPosition, LatLng point) async {
                  // String result = await getAddressFromCoordinates(
                  //     point.latitude, point.longitude);
                  // _showSnackBar(result);
                  BlocProvider.of<LocationBloc>(context).add(
                    GetLocationEvent(
                      coordinates: LatLng(
                        point.latitude,
                        point.longitude,
                      ),
                    ),
                  );
                  BlocProvider.of<StoredLocationBloc>(context).add(
                    SetCoordsEvent(
                      coordinates: LatLng(
                        point.latitude,
                        point.longitude,
                      ),
                    ),
                  );
                  _showSnackBarBloc();
                },
                cameraConstraint: CameraConstraint.contain(
                  bounds: LatLngBounds(
                    const LatLng(85, 180),
                    const LatLng(-85, -180),
                  ),
                ),
              ),
              children: [
                TileLayer(
                  urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                  userAgentPackageName: 'com.example.weather_app',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
