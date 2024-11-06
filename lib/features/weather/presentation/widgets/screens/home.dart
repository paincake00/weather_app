import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:weather_app/features/weather/presentation/bloc/location/location_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/location/location_event.dart';
import 'package:weather_app/features/weather/presentation/bloc/location/location_state.dart';
import 'package:weather_app/features/weather/presentation/bloc/stored_location/stored_location_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/stored_location/stored_location_state.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_event.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_state.dart';
import 'package:weather_app/features/weather/presentation/widgets/components/location_widget.dart';
import 'package:weather_app/features/weather/presentation/widgets/components/weather_widget.dart';

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
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Expanded(
                child: const WeatherView(),
              ),
              const LocationView(),
            ],
          ),
        ),
      ),
    );
  }
}

class WeatherView extends StatelessWidget {
  const WeatherView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        if (state is WeatherLoading) {
          return const Text('Loading...');
        }
        if (state is WeatherDone) {
          final weather = state.weatherEntity;
          if (weather != null) {
            return WeatherWidget(
              timezone: weather.timezone,
              currentTime: weather.currentTime,
              currentTemperature: weather.currentTemperature,
              isDay: weather.isDay,
              currentWeatherCode: weather.currentWeatherCode,
              forecastings: weather.forecastings,
            );
          }
          return const WeatherWidget();
        }
        if (state is WeatherError) {
          return Text(
            state.error.toString(),
          );
        }
        return const SizedBox();
      },
    );
  }
}

class LocationView extends StatelessWidget {
  const LocationView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocationBloc, LocationState>(
      builder: (context, state) {
        if (state is LocationLoading) {
          return const Text('Loading...');
        }
        if (state is LocationDone) {
          final location = state.locationEntity;
          if (location != null) {
            return LocationWidget(
              fullName: location.fullName,
              normalizedCity: location.normalizedCity,
              state: location.state,
              country: location.country,
            );
          }
          return const LocationWidget();
        }
        if (state is LocationError) {
          return Text(
            state.error.toString(),
          );
        }
        return const SizedBox();
      },
    );
  }
}
