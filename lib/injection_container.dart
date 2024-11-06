import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:weather_app/core/constatns/constants.dart';
import 'package:weather_app/features/weather/data/data_sources/local/location_storage.dart';
import 'package:weather_app/features/weather/data/data_sources/remote/open_cage_data_api.dart';
import 'package:weather_app/features/weather/data/data_sources/remote/open_meteo_api.dart';
import 'package:weather_app/features/weather/data/repository/location_repository_impl.dart';
import 'package:weather_app/features/weather/data/repository/weather_repository_impl.dart';
import 'package:weather_app/features/weather/domain/repository/location_repository.dart';
import 'package:weather_app/features/weather/domain/repository/weather_repository.dart';
import 'package:weather_app/features/weather/domain/usecases/get_location.dart';
import 'package:weather_app/features/weather/domain/usecases/get_location_from_storage.dart';
import 'package:weather_app/features/weather/domain/usecases/get_weather.dart';
import 'package:weather_app/features/weather/domain/usecases/set_location_to_storage.dart';
import 'package:weather_app/features/weather/presentation/bloc/location/location_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/stored_location/stored_location_bloc.dart';
import 'package:weather_app/features/weather/presentation/bloc/weather/weather_bloc.dart';

final sl = GetIt.instance;

Future<void> initializaDependencies() async {
  // Local storages

  final prefs = await SharedPreferences.getInstance();

  sl.registerSingleton<SharedPreferences>(prefs);

  sl.registerSingleton<LocationStorage>(
    LocationStorage(
      sharedPreferences: sl(),
    ),
  );

  // APIs

  sl.registerSingleton<OpenCageDataApi>(
    OpenCageDataApi(
      dio: Dio(
        BaseOptions(
          baseUrl: openCageDataApiUrl,
        ),
      ),
    ),
  );

  sl.registerSingleton<OpenMeteoApi>(
    OpenMeteoApi(
      dio: Dio(
        BaseOptions(
          baseUrl: openMeteoApiUrl,
        ),
      ),
    ),
  );

  // Repositories

  sl.registerSingleton<LocationRepository>(
    LocationRepositoryImpl(
      geocodingApiDioClient: sl(),
      locationStorage: sl(),
    ),
  );

  sl.registerSingleton<WeatherRepository>(
    WeatherRepositoryImpl(
      openMeteoApi: sl(),
    ),
  );

  // UseCases

  sl.registerSingleton<GetLocationFromStorageUseCase>(
    GetLocationFromStorageUseCase(
      locationRepository: sl(),
    ),
  );

  sl.registerSingleton<GetLocationUseCase>(
    GetLocationUseCase(
      locationRepository: sl(),
    ),
  );

  sl.registerSingleton<SetLocationToStorageUseCase>(
    SetLocationToStorageUseCase(
      locationRepository: sl(),
    ),
  );

  sl.registerSingleton<GetWeatherUseCase>(
    GetWeatherUseCase(
      weatherRepository: sl(),
    ),
  );

  // Blocs

  sl.registerFactory<StoredLocationBloc>(
    () => StoredLocationBloc(
      getLocationFromStorageUseCase: sl(),
      setLocationToStorageUseCase: sl(),
    ),
  );

  sl.registerFactory<LocationBloc>(
    () => LocationBloc(
      getLocationUseCase: sl(),
    ),
  );

  sl.registerFactory<WeatherBloc>(
    () => WeatherBloc(
      getWeatherUseCase: sl(),
    ),
  );
}
