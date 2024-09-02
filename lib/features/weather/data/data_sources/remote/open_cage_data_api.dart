import 'dart:io';

import 'package:dio/dio.dart';
import 'package:weather_app/core/constatns/constants.dart';
import 'package:weather_app/core/resources/data_state.dart';
import 'package:weather_app/features/weather/data/models/location_model.dart';

class OpenCageDataApi {
  final Dio _dio;

  OpenCageDataApi({
    required Dio dio,
  }) : _dio = dio;

  Future<DataState<LocationModel>> getLocationFromCoordinates(
      double latitude, double longitude) async {
    try {
      final response = await _dio.get(
        '/json',
        queryParameters: {
          'q': '$latitude+$longitude',
          'abbrv': abbrv,
          'address_only': addressOnly,
          'language': language,
          'key': apiKey,
        },
      );

      if (response.statusCode == HttpStatus.ok) {
        final data = response.data;
        return DataSuccess(LocationModel.fromJson(data));
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
