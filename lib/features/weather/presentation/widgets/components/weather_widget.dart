import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
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

enum DayPart {
  morning("Morning"),
  afternoon("Afternoon"),
  evening("Evening"),
  night("Night");

  final String name;

  const DayPart(this.name);
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
    return CustomScrollView(
      slivers: [
        SliverToBoxAdapter(
          child: CurrentForecastWidget(
            timezone: timezone,
            currentTime: currentTime,
            currentTemperature: currentTemperature,
            isDay: isDay,
            currentWeatherCode: currentWeatherCode,
          ),
        ),
        SliverToBoxAdapter(
          child: SizedBox(
            height: 200,
            child: ForecastingPerHourWidget(forecastings: forecastings),
          ),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (context, index) {
              // final forecasting = forecastings![index];
              if (index == 0 || index % 24 == 0) {
                return ForecastingPerDaypartWidget(
                  morning: forecastings![index + 3],
                  afternoon: forecastings![index + 9],
                  evening: forecastings![index + 15],
                  night: forecastings![index + 21],
                  index: index,
                );
              }
              return const SizedBox();
            },
            childCount: forecastings?.length ?? 0,
          ),
        ),
        SliverPadding(
          padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).padding.bottom + 100),
        ),
      ],
    );
  }
}

class CurrentForecastWidget extends StatelessWidget {
  final String? timezone;
  final String? currentTime;
  final double? currentTemperature;
  final int? isDay;
  final int? currentWeatherCode;

  const CurrentForecastWidget({
    super.key,
    this.timezone,
    this.currentTime,
    this.currentTemperature,
    this.isDay,
    this.currentWeatherCode,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
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
              text: 'Weather: ${(currentWeatherCode ?? -1).toCondition.name}',
            ),
          ],
        ),
      ],
    );
  }
}

class ForecastingPerHourWidget extends StatelessWidget {
  final List<ForecastingEntity>? forecastings;

  const ForecastingPerHourWidget({
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            DateFormat('hh a')
                                .format(DateTime.parse(forecasting.time!)),
                          ),
                          Text(
                            (forecasting.weatherCode ?? -1).toCondition.toEmoji,
                            style: const TextStyle(fontSize: 40),
                          ),
                          Text(
                            (forecasting.weatherCode ?? -1).toCondition.name,
                          ),
                          Text(
                            '${forecasting.temperature} °C',
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

class ForecastingPerDaypartWidget extends StatelessWidget {
  final ForecastingEntity morning;
  final ForecastingEntity afternoon;
  final ForecastingEntity evening;
  final ForecastingEntity night;
  final int index;

  const ForecastingPerDaypartWidget({
    super.key,
    required this.morning,
    required this.afternoon,
    required this.evening,
    required this.night,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
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
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  DateForecasting(
                    time: morning.time!,
                    index: index,
                  ),
                  Row(
                    children: [
                      Text(
                        '${DayPart.morning.name}: ',
                      ),
                      Text(
                        (morning.weatherCode ?? -1).toCondition.name,
                      ),
                      Text(
                        (morning.weatherCode ?? -1).toCondition.toEmoji,
                        style: const TextStyle(fontSize: 40),
                      ),
                      Text(
                        '${morning.temperature} °C',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '${DayPart.afternoon.name}: ',
                      ),
                      Text(
                        (afternoon.weatherCode ?? -1).toCondition.name,
                      ),
                      Text(
                        (afternoon.weatherCode ?? -1).toCondition.toEmoji,
                        style: const TextStyle(fontSize: 40),
                      ),
                      Text(
                        '${afternoon.temperature} °C',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '${DayPart.evening.name}: ',
                      ),
                      Text(
                        (evening.weatherCode ?? -1).toCondition.name,
                      ),
                      Text(
                        (evening.weatherCode ?? -1).toCondition.toEmoji,
                        style: const TextStyle(fontSize: 40),
                      ),
                      Text(
                        '${evening.temperature} °C',
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        '${DayPart.night.name}: ',
                      ),
                      Text(
                        (night.weatherCode ?? -1).toCondition.name,
                      ),
                      Text(
                        (night.weatherCode ?? -1).toCondition.toEmoji,
                        style: const TextStyle(fontSize: 40),
                      ),
                      Text(
                        '${night.temperature} °C',
                      ),
                    ],
                  ),

                  // for (var entry in forecastingsOfDayPart.entries) ...[
                  //   Text(
                  //     entry.key.name,
                  //   ),
                  //   Text(
                  //     (entry.value.weatherCode ?? -1).toCondition.toEmoji,
                  //   ),
                  //   Text(
                  //     (entry.value.weatherCode ?? -1).toCondition.name,
                  //   ),
                  //   Text(
                  //     '${entry.value.temperature} °C',
                  //   ),
                  // ],
                ],
              ),
            ),
          ),
        ),
      ),
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
