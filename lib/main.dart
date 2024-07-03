
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:weather_report/view/Forecast.dart';

import 'package:weather_report/view/Weatherpage.dart';

import 'view/Home.dart';
import 'view/Splashscreen.dart';

void main() {
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    home: Homepage(),
    getPages: [
      GetPage(name: '/Splashscreen', page: () => Splashscreen()),
      GetPage(name: '/Homepage', page: () => Homepage()),
      GetPage(name: '/Weatherpage', page: () => Weatherpage()),
      GetPage(name: '/Forecast', page: () => Forecastpage()),
    ],
  ));
}
