import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/features/weather/domain/usecases/get_location_from_storage.dart';
import 'package:weather_app/features/weather/domain/usecases/set_location_to_storage.dart';
import 'package:weather_app/features/weather/presentation/bloc/stored_location/stored_location_event.dart';
import 'package:weather_app/features/weather/presentation/bloc/stored_location/stored_location_state.dart';

class StoredLocationBloc
    extends Bloc<StoredLocationEvent, StoredLocationState> {
  final GetLocationFromStorageUseCase _getLocationFromStorageUseCase;
  final SetLocationToStorageUseCase _setLocationToStorageUseCase;

  StoredLocationBloc({
    required GetLocationFromStorageUseCase getLocationFromStorageUseCase,
    required SetLocationToStorageUseCase setLocationToStorageUseCase,
  })  : _getLocationFromStorageUseCase = getLocationFromStorageUseCase,
        _setLocationToStorageUseCase = setLocationToStorageUseCase,
        super(
          const StoredLocationLoading(),
        ) {
    on<GetCoordsEvent>(_onGetLocation);

    on<SetCoordsEvent>(_onSetLocation);
  }

  void _onGetLocation(
    GetCoordsEvent event,
    Emitter<StoredLocationState> emit,
  ) async {
    emit(const StoredLocationLoading());

    final coordinates = await _getLocationFromStorageUseCase.call();

    emit(StoredLocationDone(coordinates: coordinates));
  }

  void _onSetLocation(
    SetCoordsEvent event,
    Emitter<StoredLocationState> emit,
  ) async {
    emit(const StoredLocationLoading());

    if (event.coordinates != null) {
      await _setLocationToStorageUseCase.call(params: event.coordinates!);

      emit(StoredLocationDone(coordinates: event.coordinates!));
    }
  }
}
