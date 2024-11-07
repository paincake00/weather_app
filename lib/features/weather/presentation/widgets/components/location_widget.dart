import 'package:flutter/material.dart';
import 'package:weather_app/features/weather/presentation/widgets/screens/map_screen.dart';

class LocationWidget extends StatelessWidget {
  final String? fullName;
  final String? normalizedCity;
  final String? state;
  final String? country;

  const LocationWidget({
    super.key,
    this.fullName,
    this.normalizedCity,
    this.state,
    this.country,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: ColoredBox(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    fullName ?? 'undefined',
                    style: const TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontFamily: 'Roboto',
                      overflow: TextOverflow.ellipsis,
                    ),
                    maxLines: 2,
                  ),
                ),
                IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MapScreen(),
                        ),
                      );
                    },
                    icon: const Icon(
                      Icons.location_on,
                      size: 30,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
