import 'dart:async';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:weather/weather.dart';

import '../components/menu_nav.dart';
import '../components/meteo_result.dart';

const String baseUrl = 'http://localhost:8000/question';
const String apiKey = 'cfa429146861dfcffac43fa0d97a7eaa';

// Meteo Page
class MeteoPage extends StatefulWidget {
  const MeteoPage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  MeteoState createState() {
    return MeteoState();
  }
}

class MeteoState extends State<MeteoPage> {
  late WeatherFactory wf;
  late Weather ?weather;
  late String errorMessage;

  @override
  void initState() {
    super.initState();
    wf = WeatherFactory(apiKey, language: Language.FRENCH);
    weather = null;
    errorMessage = '';
  }

  Future<Position> determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      setState(() {
        errorMessage = 'Service de géolocalisation désactivé';
      });
      return Future.error('Service de géolocalisation désactivé');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        setState(() {
          errorMessage = 'Service de géolocalisation rejeté';
        });
        return Future.error('Service de géolocalisation rejeté');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      setState(() {
        errorMessage = 'Location permissions are permanently denied, we cannot request permissions.';
      });
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.blueAccent,
      ),
      drawer: const MenuNavigation(),
      body: SingleChildScrollView (
        padding: const EdgeInsets.only(bottom: 50.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children:  <Widget>[
            Container(
              margin: const EdgeInsets.only(top: 50.0, bottom: 10.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () async {
                    var posCoordinates = await determinePosition();
                    Weather w = await wf.currentWeatherByLocation(
                        posCoordinates.latitude, posCoordinates.longitude);
                    setState(() {
                      weather = w;
                    });
                  },
                  style: ButtonStyle(
                      padding: MaterialStateProperty.all(const EdgeInsets.all(30)),
                      shape: MaterialStateProperty.all(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                              side: const BorderSide(color: Color.fromRGBO(21, 96, 189, 0.5))
                          )
                      )
                  ),
                  child: const Text(
                    'Utiliser sa position',
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
            ),
            (weather != null)?
              MeteoResult(weather: weather!):
            (errorMessage.isNotEmpty)?
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 50.0),
                  child: Text(
                    errorMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 25.0,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ):
              Container(),
          ],
        ),
      ),
    );
  }
}