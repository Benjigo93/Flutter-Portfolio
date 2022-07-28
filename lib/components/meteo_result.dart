import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_map/plugin_api.dart';
import 'package:latlong2/latlong.dart';
import 'package:weather/weather.dart';
import '../extensions/string.dart';
import '../extensions/zoombuttons_plugin_option.dart';

// Meteo Result Card
class MeteoResult extends Container{
  MeteoResult({Key? key, required this.weather,}) : super(key: key);
  final Weather weather;

  @override
  Container build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 0.0, horizontal: 0.0),
      child: Column(
        children: [
          Container(
            width: 600,
            padding: const EdgeInsets.all(30.0),
            margin: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 30.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: const Color.fromRGBO(115, 194, 251, 1),
                width: 3,
              ),
              borderRadius: BorderRadius.circular(10),
              boxShadow: const [
                BoxShadow(
                  color: Color.fromRGBO(115, 194, 251, 0.5),
                  offset: Offset(
                    5.0,
                    5.0,
                  ),
                  blurRadius: 15.0,
                  spreadRadius: 7.0,
                ), //BoxShadow
                BoxShadow(
                  color: Colors.white,
                  offset: Offset(0.0, 0.0),
                  blurRadius: 0.0,
                  spreadRadius: 0.0,
                ),
              ],
            ),
            child: Align(
              alignment: Alignment.center,
              child:  Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'http://openweathermap.org/img/w/${weather.weatherIcon!}.png',
                        width: 130,
                        height: 130,
                        fit: BoxFit.cover,
                      ),
                      Text(
                        'Température :\n ${weather.temperature!}',
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w500,
                          color: Color.fromRGBO(21, 67, 96, 1.0),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      'Description : ${weather.weatherDescription?.toTitleCase()}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(21, 67, 96, 1.0),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      'Pression : ${weather.pressure!}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(21, 67, 96, 1.0),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      'Humidité : ${weather.humidity!}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(21, 67, 96, 1.0),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 5.0),
                    child: Text(
                      'Lieu : ${weather.areaName!}',
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.w500,
                        color: Color.fromRGBO(21, 67, 96, 1.0),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 400,
            width: 600,
            child: FlutterMap(
              options: MapOptions(
                center: LatLng(weather.latitude!, weather.longitude!),
                zoom: 12.0,
                maxZoom: 19.0,
                keepAlive: true,
                plugins: [
                  ZoomButtonsPlugin(),
                ],
              ),
              layers: [
                ZoomButtonsPluginOption(
                  minZoom: 4,
                  maxZoom: 19,
                  mini: true,
                  padding: 10,
                  alignment: Alignment.bottomLeft,
                  zoomInColorIcon: const Color.fromRGBO(21, 96, 189, 1.0),
                  zoomInColor: const Color.fromRGBO(115, 194, 251, 1.0),
                  zoomOutColorIcon: const Color.fromRGBO(21, 96, 189, 1.0),
                  zoomOutColor: const Color.fromRGBO(115, 194, 251, 1.0),
                )
              ],
              children: <Widget>[
                TileLayerWidget(
                  options: TileLayerOptions(
                    urlTemplate:
                    'https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png',
                    subdomains: ['a', 'b', 'c'],
                    userAgentPackageName: 'dev.fleaflet.flutter_map.example',
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}