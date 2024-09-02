import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather_app/core/constatns/constants.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/data/models/weather_model.dart';

class OpenMeteoApi {
  final Dio _dio;

  OpenMeteoApi({
    required Dio dio,
  }) : _dio = dio;

  Future<DataState<WeatherModel>> getWeatherFromCoordinates(
    double latitude,
    double longitude,
  ) async {
    try {
      final response = await _dio.get(
        '/forecast',
        queryParameters: {
          'latitude': latitude,
          'longitude': longitude,
          'current': current,
          'hourly': hourly,
          'timezone': timezone,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data;
        return DataSuccess(WeatherModel.fromJson(data));
      }
      return DataFailure(
        DioException(
          error: response.statusMessage,
          response: response,
          type: DioExceptionType.unknown,
          requestOptions: response.requestOptions,
        ),
      );
    } on DioException catch (e) {
      return DataFailure(e);
    }
  }
}
