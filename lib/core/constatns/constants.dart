import 'package:flutter_dotenv/flutter_dotenv.dart';

/// OPEN_CAGE_DATA_API
const String openCageDataApiUrl = 'https://api.opencagedata.com/geocode/v1';
final apiKey = dotenv.env['API_KEY'];
const String language = 'ru';
const int abbrv = 1;
const int addressOnly = 1;
