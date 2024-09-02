import 'package:dio/dio.dart';

class OpenMeteoApi {
  final Dio _dio;

  OpenMeteoApi({
    required Dio dio,
  }) : _dio = dio;
}
