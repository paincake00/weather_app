import 'package:flutter_dotenv/flutter_dotenv.dart';

/// OPEN_CAGE_DATA_API
const String openCageDataApiUrl = 'https://api.opencagedata.com/geocode/v1';
final apiKey = dotenv.env['API_KEY'];
const String language = 'ru';
const int abbrv = 1;
const int addressOnly = 1;

/// OPEN_METEO_API
const String openMeteoApiUrl = 'https://api.open-meteo.com/v1';
const String current = 'temperature_2m,is_day,weather_code';
const String hourly = 'temperature_2m,weather_code';
const String timezone = 'auto';
