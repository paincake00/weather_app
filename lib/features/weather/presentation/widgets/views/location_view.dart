import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/location/location_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/location/location_state.dart';
import 'package:weather_app/features/weather/presentation/widgets/components/location_widget.dart';

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
