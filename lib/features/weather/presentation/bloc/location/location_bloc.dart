import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/domain/usecases/get_location.dart';
import 'package:weather_app/features/weather/presentation/bloc/location/location_event.dart';
import 'package:weather_app/features/weather/presentation/bloc/location/location_state.dart';

class LocationBloc extends Bloc<LocationEvent, LocationState> {
  final GetLocationUseCase _getLocationUseCase;

  LocationBloc({
    required GetLocationUseCase getLocationUseCase,
  })  : _getLocationUseCase = getLocationUseCase,
        super(const LocationLoading()) {
    on<GetLocationEvent>(_onGetLocation);
  }

  void _onGetLocation(
    GetLocationEvent event,
    Emitter<LocationState> emit,
  ) async {
    emit(const LocationLoading());

    final dataState = await _getLocationUseCase.call(params: event.coordinates);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(LocationDone(locationEntity: dataState.data!));
    }

    if (dataState is DataError) {
      emit(LocationError(error: dataState.error!));
    }
  }
}
