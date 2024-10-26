import 'package:flutter/material.dart';
import 'package:weather_app/models/realtime_weather.dart';
import 'package:weather_app/widgets/custom_icon.dart';

class ExtraInfo extends StatelessWidget {
  const ExtraInfo(
      {super.key,
      required this.visibility,
      required this.main,
      required this.windSpeed});
  final int visibility;
  final Main main;
  final String windSpeed;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 250,
      width: MediaQuery.of(context).size.width * 0.90,
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black),
          borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.only(top: 20),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
          ),
          children: [
            CustomIcon(
              icon: const Icon(
                Icons.wind_power,
                color: Colors.blue,
                size: 30,
              ),
              lable: 'Wind',
              value: '${windSpeed}km/h',
            ),
            CustomIcon(
              icon: const Icon(
                Icons.water_drop_outlined,
                color: Colors.blue,
                size: 30,
              ),
              lable: 'Humidity',
              value: '${main.humidity.toString()}%',
            ),
            CustomIcon(
              icon: const Icon(
                Icons.close_fullscreen_sharp,
                color: Colors.blue,
                size: 30,
              ),
              lable: 'Pressure',
              value: '${main.pressure.toString()}mb',
            ),
            CustomIcon(
              icon: const Icon(
                Icons.visibility,
                color: Colors.blue,
                size: 30,
              ),
              lable: 'Visibility',
              value: '${visibility.toString()}km',
            ),
          ],
        ),
      ),
    );
  }
}
