import 'package:flutter/material.dart';
import 'package:weather_app/core/weather_codes.dart';

class WeatherContainer extends StatelessWidget {
  const WeatherContainer(
      {super.key,
      required this.temperature,
      required this.temperatureApparent,
      required this.weathercode,
      required this.weather});
  final double temperature;
  final double temperatureApparent;
  final String weathercode;
  final String weather;
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              height: 120,
              decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(40)),
                  color: Colors.blue),
            ),
            Positioned(
              top: -40,
              width: 140,
              height: 130,
              right: 0,
              child: Image.asset('assets/icons/$weathercode${'@2x'}.png'),
            ),
            Positioned(
              left: 30,
              top: 15,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$temperature°',
                    style: const TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  Text(
                    'Feels like $temperatureApparent° /$weather',
                    style: const TextStyle(
                        color: Color.fromARGB(217, 255, 255, 255),
                        fontSize: 17,
                        fontWeight: FontWeight.w600),
                  )
                ],
              ),
            )
          ],
        ));
  }
}
