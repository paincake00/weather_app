import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:weather_app/features/weather/presentation/bloc/location/location_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/location/location_event.dart';
import 'package:weather_app/features/weather/presentation/bloc/stored_location/stored_location_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/stored_location/stored_location_state.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_event.dart';
import 'package:weather_app/features/weather/presentation/widgets/views/location_view.dart';
import 'package:weather_app/features/weather/presentation/widgets/views/weather_view.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text(
          'Weather App',
          style: TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
            fontFamily: 'Roboto',
          ),
        ),
        backgroundColor: Colors.blue[400],
      ),
      backgroundColor: Colors.blue[200],
      body: BlocListener<StoredLocationBloc, StoredLocationState>(
        listener: (context, state) {
          if (state is StoredLocationDone) {
            context.read<WeatherBloc>().add(
                  GetWeatherEvent(
                    coordinates: state.coordinates ?? const LatLng(0, 0),
                  ),
                );

            context.read<LocationBloc>().add(
                  GetLocationEvent(
                    coordinates: state.coordinates ?? const LatLng(0, 0),
                  ),
                );
          }
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: WeatherView(),
        ),
      ),
      bottomSheet: DecoratedBox(
        decoration: BoxDecoration(
          color: Colors.blue[300],
          borderRadius: BorderRadius.circular(0),
        ),
        child: const LocationView(),
      ),
    );
  }
}
