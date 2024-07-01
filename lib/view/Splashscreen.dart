import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:weather_report/view/Home.dart';

class Splashscreen extends StatefulWidget {
  const Splashscreen({super.key});

  @override
  State<Splashscreen> createState() => _SplashscreenState();
}

class _SplashscreenState extends State<Splashscreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     Timer(Duration(seconds: 4), () {
      Get.to(Homepage());
     });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.3,
            ),
            Image.asset(
              'asset/Logo.gif',
              width: 300,
            ),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.05,
            ),
            Container(
                width: MediaQuery.sizeOf(context).height * 0.35,
                color: Colors.blue[100],
                child: Center(
                  child: Text(
                    'Weather Report',
                    style: TextStyle(
                      fontSize: 35,
                    ),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
