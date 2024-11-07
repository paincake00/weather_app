import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextPanel(text: timezone ?? 'undefined'),
                TextPanel(
                    text:
                        'Updated: ${DateFormat('hh:mm a').format(DateTime.parse(currentTime!))}'),
                Row(
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
        SizedBox(
          height: 200,
          child: ForecastingWidget(forecastings: forecastings),
        ),
      ],
    );
  }
}

class ForecastingWidget extends StatelessWidget {
  final List<ForecastingEntity>? forecastings;

  const ForecastingWidget({
    super.key,
    this.forecastings,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      scrollDirection: Axis.horizontal,
      itemCount: forecastings?.length ?? 0,
      itemBuilder: (context, index) {
        final forecasting = forecastings![index];
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: ColoredBox(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      SizedBox(
                        child: DateForecasting(
                          time: forecasting.time!,
                          index: index,
                        ),
                      ),
                      Text(
                        (forecasting.weatherCode ?? -1).toCondition.toEmoji,
                        style: const TextStyle(fontSize: 70),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // Text(
                          //   DateFormat('dd MMM')
                          //       .format(DateTime.parse(forecasting.time!)),
                          // ),
                          // Text(
                          //   DateFormat('EEEE')
                          //       .format(DateTime.parse(forecasting.time!)),
                          // ),
                          Text(
                            DateFormat('hh:mm a')
                                .format(DateTime.parse(forecasting.time!)),
                          ),
                          Text(
                            '${forecasting.temperature} °C',
                          ),
                          Text(
                            (forecasting.weatherCode ?? -1).toCondition.name,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

class DateForecasting extends StatelessWidget {
  final String time;
  final int index;

  const DateForecasting({
    super.key,
    required this.time,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return const TextPanel(
        text: 'Today',
      );
    } else if (index % 24 == 0) {
      return TextPanel(
        text:
            '${DateFormat('dd MMM').format(DateTime.parse(time))}, ${DateFormat('EEEE').format(DateTime.parse(time))}',
      );
    }
    return const SizedBox();
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
