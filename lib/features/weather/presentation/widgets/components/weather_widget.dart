import 'package:flutter/material.dart';
import 'package:weather_app/core/utils/weather_code_parse.dart';
import 'package:weather_app/features/weather/domain/entities/forecasting_entity.dart';

extension on WeatherCondition {
  String get toEmoji {
    return switch (this) {
      WeatherCondition.clear => '☀️',
      WeatherCondition.rainy => '🌧️',
      WeatherCondition.cloudy => '☁️',
      WeatherCondition.snowy => '🌨️',
      WeatherCondition.unknown => '❓',
    };
  }
}

class WeatherWidget extends StatelessWidget {
  final String? timezone;
  final String? currentTime;
  final double? currentTemperature;
  final int? isDay;
  final int? currentWeatherCode;
  final List<ForecastingEntity>? forecastings;

  const WeatherWidget({
    super.key,
    this.timezone,
    this.currentTime,
    this.currentTemperature,
    this.isDay,
    this.currentWeatherCode,
    this.forecastings,
  });

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const SizedBox(
                      width: 180,
                      height: 180,
                      child: DecoratedBox(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                    Text(
                      (currentWeatherCode ?? -1).toCondition.toEmoji,
                      style: const TextStyle(fontSize: 120),
                    ),
                  ],
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextPanel(text: timezone ?? 'undefined'),
                TextPanel(
                    text: 'Updated: ${currentTime.toString().split('T')[1]}'),
                Row(
                  // mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextPanel(text: '$currentTemperature °C'),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: Icon(
                        (isDay ?? 0) > 0 ? Icons.sunny : Icons.nights_stay,
                        color: Colors.black,
                      ),
                    ),
                  ],
                ),
                TextPanel(
                  text:
                      'Weather: ${(currentWeatherCode ?? -1).toCondition.name}',
                ),
              ],
            ),
          ],
        ),
        // if (forecastings != null)
        //   for (var forecasting in forecastings!)
        //     TextPanel(
        //       text: '''
        //         ${forecasting.time}
        //         ${forecasting.temperature} °C
        //         ${forecasting.weatherCode}
        //         ''',
        //     ),
      ],
    );
  }
}

class TextPanel extends StatelessWidget {
  final String text;

  const TextPanel({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: FittedBox(
        fit: BoxFit.scaleDown,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(10),
          child: ColoredBox(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Text(
                text,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.black,
                  // fontWeight: FontWeight.bold,
                  fontFamily: 'Roboto',
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
