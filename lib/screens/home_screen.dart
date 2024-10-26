import 'dart:convert';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather_app/models/realtime_weather.dart';
import 'package:weather_app/widgets/extra_info.dart';

import 'package:weather_app/widgets/search_dialog.dart';
import 'package:weather_app/widgets/todayweathercontainer.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Position? _currentPosition;
  String locationname = 'Location';
  String? cityname;

  @override
  void initState() {
    super.initState();
    _getCurrentLocation();
  }

  Future<void> _getCurrentLocation() async {
    try {
      LocationPermission permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied ||
          permission == LocationPermission.deniedForever) {
        throw ('Location permissions are denied');
      }
      Position position = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      placemarkFromCoordinates(position.latitude, position.longitude)
          .then((placem) {
        setState(() {
          locationname = placem[0].locality.toString();
        });
      });

      setState(() {
        _currentPosition = position;
      });
    } catch (e) {
      throw ('Error getting location: $e');
    }
  }

  Future<WeatherRealTime> loaddata(double lat, double lon) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?lat=$lat&lon=$lon&appid=${'40ce3f067b530f0109a65a11d17f032d'}'),
        headers: {'accept': 'application/json'},
      );

      final body = jsonDecode(response.body);
      final output = WeatherRealTime.fromJson(body);

      return output;
    } catch (e) {
      throw (e.toString());
    }
  }

  Future<WeatherRealTime> loaddataByCity(String city) async {
    try {
      final response = await http.get(
        Uri.parse(
            'https://api.openweathermap.org/data/2.5/weather?q=$city&appid=${'40ce3f067b530f0109a65a11d17f032d'}'),
        headers: {'accept': 'application/json'},
      );

      final body = jsonDecode(response.body);
      final output = WeatherRealTime.fromJson(body);

      return output;
    } catch (e) {
      throw (e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    final time = DateTime.now().hour;
    String toshow = 'Good Morning';
    String label = 'Have a good day!';
    bool day = true;
    if (time >= 12 && time <= 16) {
      toshow = 'Good Afternoon';
      label = 'How you are doing!';
    } else if (time >= 16 && time <= 23) {
      toshow = 'Good Evening';
      label = 'How was your day?';
    }

    if (time >= 18 || time <= 5) {
      day = false;
    }

    if (_currentPosition == null && cityname == null) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              ' $toshow',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            Text(
              label,
              style: const TextStyle(
                  color: Color.fromARGB(255, 90, 83, 83), fontSize: 15),
            )
          ],
        ),
        actions: [
          InkWell(
            onTap: () {
              showDialog(
                context: context,
                builder: (context) {
                  return SearchDialog(
                    takeinput: (city) {
                      setState(() {
                        cityname = city;
                        locationname = city;
                      });
                    },
                  );
                },
              );
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue, width: 1.5),
                  borderRadius: BorderRadius.circular(18)),
              child: Center(
                child: Row(
                  children: [
                    const Icon(
                      Icons.location_pin,
                      size: 18,
                      color: Colors.blue,
                    ),
                    Text(
                      locationname,
                      style: const TextStyle(
                          color: Colors.blue, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
      body: FutureBuilder(
        future: cityname == null
            ? loaddata(_currentPosition!.latitude, _currentPosition!.longitude)
            : loaddataByCity(cityname!),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Invalid city name or error fetching data'),
            );
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final data = snapshot.data;
          return Center(
            child: Column(
              children: [
                WeatherContainer(
                  temperature: (data!.main!.temp! - 273.15).roundToDouble(),
                  temperatureApparent:
                      (data.main!.feelsLike! - 273.15).roundToDouble(),
                  weathercode: data.weather![0].icon!,
                  weather: data.weather![0].description!,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20),
                  child: ExtraInfo(
                    main: data.main!,
                    visibility: data.visibility!,
                    windSpeed: data.wind!.speed!.toString(),
                  ),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
