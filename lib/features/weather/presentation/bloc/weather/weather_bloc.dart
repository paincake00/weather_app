import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weather.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_event.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  final GetWeatherUseCase _getWeatherUseCase;

  WeatherBloc({
    required GetWeatherUseCase getWeatherUseCase,
  })  : _getWeatherUseCase = getWeatherUseCase,
        super(const WeatherLoading()) {
    on<GetWeatherEvent>(_onGetWeather);
  }

  void _onGetWeather(
    GetWeatherEvent event,
    Emitter<WeatherState> emit,
  ) async {
    emit(const WeatherLoading());

    final dataState = await _getWeatherUseCase.call(params: event.coordinates);

    if (dataState is DataSuccess && dataState.data != null) {
      emit(WeatherDone(weatherEntity: dataState.data!));
    }

    if (dataState is DataError) {
      emit(WeatherError(error: dataState.error!));
    }
  }
}
