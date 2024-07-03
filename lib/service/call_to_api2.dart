import 'dart:convert';
import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import "package:http/http.dart" as http;

import '../model/Forecastmodel.dart';
// import 'package:weathercast/constants/api_key.dart';

// import 'package:weathercast/logic/models/weather_model.dart';

class CallToApi2 {
  Future<Forecastmodel> callWeatherAPihourly(bool current1, String cityName1) async {
    try {
      Position currentPosition = await getCurrentPosition1();

      if (current1) {
        List<Placemark> placemarks1 = await placemarkFromCoordinates(
            currentPosition.latitude, currentPosition.longitude);

        Placemark place1 = placemarks1[0];
        cityName1 = place1.locality!;
        print(cityName1);
      }
      String apiKey = "b1b15e88fa797225412429c1c50c122a1";
      var url = Uri.https('pro.openweathermap.org', '/data/2.5/forecast/hourly',
          {'q': cityName1, "units": "metric", "appid": apiKey});
      final http.Response response = await http.get(url);
      log(response.body.toString());
      if (response.statusCode == 200) {
        final Map<String, dynamic> decodedJson = json.decode(response.body);
        return Forecastmodel.fromMap(decodedJson);
      } else {
        throw Exception('Failed to load weather data222');
      }
    } catch (e) {
      throw Exception('Failed to load weather data111');
    }
  }

  Future<Position> getCurrentPosition1() async {
    bool serviceEnabled;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
    );
  }
}
