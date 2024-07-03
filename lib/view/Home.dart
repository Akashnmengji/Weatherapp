import 'dart:async';

import 'package:flutter/material.dart';
import 'package:weather_report/view/Forecast.dart';
import 'package:weather_report/view/Weatherpage.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  int myindex = 0;
  String _appBarTitle = "Weather Report";
  //List<Widget> _appBarActions = [];
  //Color _appBarColor;
  late StreamSubscription subscription;
  var isDeviceconnected = false;
  bool isalertbox = false;
  @override
  void initState() {
    getconnection();
    // TODO: implement initState
    super.initState();
  }

  getconnection() => {
        subscription = Connectivity()
            .onConnectivityChanged
            .listen((ConnectivityResult result) async {
          isDeviceconnected = await InternetConnectionChecker().hasConnection;
          if (!isDeviceconnected && isalertbox == false) {
            showdialogbox();
            setState(() {
              isalertbox = true;
            });
          }
        })
      };
  void showdialogbox() => showDialog(
      context: context,
      builder: (BuildContext context) => AlertDialog(
            title: Text('No Internet Connection'),
            content: Text('Please Cheak Your Mobile data or WiFi is On'),
            actions: [
              TextButton(
                  onPressed: () async {
                    Navigator.pop(context);
                    setState(() => isalertbox = false);
                    isDeviceconnected =
                        await InternetConnectionChecker().hasConnection;
                    if (!isDeviceconnected) {
                      showdialogbox();
                      setState(() {
                        isalertbox = true;
                      });
                    }
                  },
                  child: Text("OK"))
            ],
          ));
  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  List<Widget> _widgetOptions = <Widget>[
    Weatherpage(),
    Forecastpage(),
    // Favouritepage()
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          centerTitle: true,
          title: Text(
            '$_appBarTitle',
            style: TextStyle(color: Colors.black),
          ),
          elevation: 0,
          automaticallyImplyLeading: false,
        ),
        body: Center(
          child: _widgetOptions[myindex],
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              myindex = index;
            });
            _setAppBarContent();
          },
          currentIndex: myindex,
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('asset/weather1.png'),
                    color: Colors.amberAccent),
                label: 'Weather',
                backgroundColor: Colors.blue),
            BottomNavigationBarItem(
                icon: ImageIcon(AssetImage('asset/weather2.png'),
                    color: Colors.orange),
                label: 'Forecast',
                backgroundColor: Colors.green),
            // BottomNavigationBarItem(
            //     icon: ImageIcon(AssetImage('asset/Favourite.png'),
            //         color: Colors.red),
            //     label: 'Favourite',
            //     backgroundColor: Colors.red),
          ],
        ));
  }

  void _setAppBarContent() {
    switch (myindex) {
      case 0:
        setState(() {
          _appBarTitle = "Weather Report";
          //_appBarActions = _pageOneActions;
          //_appBarColor = Colors.blue;
        });
        break;
      case 1:
        setState(() {
          _appBarTitle = "Forecast";
          //_appBarActions = _pageTwoActions;
          //_appBarColor = Colors.green;
        });
        break;
      // case 2:
      //   setState(() {
      //     _appBarTitle = "Favourite";
      //     //_appBarActions = _pageThreeActions;
      //     //_appBarColor = Colors.indigo;
      //   });
      // break;
      default:
        break;
    }
  }
}
