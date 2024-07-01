import 'package:flutter/material.dart';
import '../model/weathermodel.dart';
import '../service/call_to_api.dart';
import 'package:intl/intl.dart';

class Weatherpage extends StatefulWidget {
  const Weatherpage({super.key});

  @override
  State<Weatherpage> createState() => _WeatherpageState();
}

class _WeatherpageState extends State<Weatherpage> {
   late String imge;
  Future<WeatherModel> getData(bool isCurrentCity, String cityName) async {
    return await CallToApi().callWeatherAPi(isCurrentCity, cityName);
  }

 
  TextEditingController _search = TextEditingController();
  Future<WeatherModel>? _myData;
  @override
  void initState() {
    setState(() {
      _myData = getData(true, "");
    });

    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: TextField(
                controller: _search,
                onSubmitted: (value) {
                  setState(() {
                    _myData = getData(false, _search.text);
                  });
                },
                decoration: InputDecoration(
                    prefixIcon: Icon(Icons.location_searching),
                    hintText: 'Search City Name',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8))),
              ),
            ),
            FutureBuilder(
              builder: (
                ctx,
                snapshot,
              ) {
                if (snapshot.connectionState == ConnectionState.done) {
                  // If error occured
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error.toString()} occurred',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final data = snapshot.data as WeatherModel;
                    int? d = int.tryParse(data.dt);
                    DateTime date =
                        DateTime.fromMillisecondsSinceEpoch(d! * 1000);
                    String formattedDate = DateFormat.yMMMMd().format(date);
                    String formattedtime = DateFormat.jm().format(date);

                    int? sr = int.tryParse(data.sunrise);
                    DateTime srt =
                        DateTime.fromMillisecondsSinceEpoch(sr! * 1000);
                    String srh = DateFormat.jm().format(srt);

                    int? ss = int.tryParse(data.sunset);
                    DateTime sst =
                        DateTime.fromMillisecondsSinceEpoch(ss! * 1000);
                    String ssh = DateFormat.jm().format(sst);
                    if (data.pic == '01d') {
                      imge = 'asset/sunny.png';
                    } else if (data.pic == '01n') {
                      imge = 'asset/moon.png';
                    } else if (data.pic == '02d') {
                      imge = 'asset/CloudDay.png';
                    } else if (data.pic == '02n') {
                      imge = 'asset/CloudNight.png';
                    } else if (data.pic == '03d') {
                      imge = 'asset/ScatteredCloudDay.png';
                    } else if (data.pic == '03n') {
                      imge = 'asset/ScatteredCloudNight.png';
                    } else if (data.pic == '04d') {
                      imge = 'asset/BrokenCloudsDay.png';
                    } else if (data.pic == '04n') {
                      imge = 'asset/BrokenCloudsNight.png';
                    } else if (data.pic == '09d') {
                      imge = 'asset/RainDay.png';
                    } else if (data.pic == '09n') {
                      imge = 'asset/RainNight.png';
                    } else if (data.pic == '10d') {
                      imge = 'asset/RainDay.png';
                    } else if (data.pic == '10n') {
                      imge = 'asset/RainNight.png';
                    } else if (data.pic == '11d') {
                      imge = 'asset/thunderstormDay.png';
                    } else if (data.pic == '11n') {
                      imge = 'asset/thunderstormNight.png';
                    } else if (data.pic == '13d') {
                      imge = 'asset/SnowDay.png';
                    } else if (data.pic == '13n') {
                      imge = 'asset/SnowNight.png';
                    } else if (data.pic == '50d') {
                      imge = 'asset/MistDay.png';
                    } else if (data.pic == '50n') {
                      imge = 'asset/MistNight.png';
                    }
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.location_pin,
                                  size: 30,
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.city,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(data.country)
                                  ],
                                ),
                              ],
                            ),
                            // SizedBox(
                            //   width: MediaQuery.sizeOf(context).height * 0.1,
                            // ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formattedtime,
                                  style: TextStyle(
                                    fontSize: 30,
                                  ),
                                ),
                                Text('$formattedDate'),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).width * 0.2),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          // child: Image.asset('asset/sunny.png')
                          height: MediaQuery.sizeOf(context).height * 0.25,
                          decoration: BoxDecoration(
                              color: Colors.deepPurple[200],
                              borderRadius: BorderRadius.circular(15),
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.deepPurple.shade100,
                                    offset: Offset(0, 25),
                                    blurRadius: 10,
                                    spreadRadius: -12)
                              ]),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              Positioned(
                                  top: -60,
                                  left: 15,
                                  child: Image.asset(
                                    imge,
                                    width: 140,
                                  )),
                              Positioned(
                                  bottom: 70,
                                  left: 46,
                                  child: Text(
                                    data.weathermain,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  )),
                              Positioned(
                                  right: 10,
                                  top: 50,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        data.temp,
                                        style: TextStyle(
                                            fontSize: 50, color: Colors.white),
                                      ),
                                      Text(
                                        'o',
                                        style: TextStyle(
                                            fontSize: 15, color: Colors.white),
                                      ),
                                      // Text(
                                      //   'C',
                                      //   style: TextStyle(
                                      //       fontSize: 20, color: Colors.white),
                                      // )
                                    ],
                                  )),
                              Positioned(
                                  bottom: 30,
                                  left: 100,
                                  child: Text('Description',
                                      style: TextStyle(
                                        fontSize: 18,
                                        color: Colors.white,
                                      ))),
                              Align(
                                alignment: Alignment.bottomCenter,
                                child: Text(data.desc,
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).width * 0.08),
                        Row(
                          children: [
                            SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.1),
                            Text('Windspeed',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(
                                width:
                                    MediaQuery.sizeOf(context).width * 0.115),
                            Text('Humidity',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(
                                width:
                                    MediaQuery.sizeOf(context).width * 0.115),
                            Text('Temperture',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).width * 0.04),
                        Row(
                          children: [
                            SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.1),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.2,
                              height: MediaQuery.sizeOf(context).height * 0.1,
                              decoration: BoxDecoration(
                                  color: Colors.deepPurple[200],
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.deepPurple.shade100,
                                        offset: Offset(0, 25),
                                        blurRadius: 10,
                                        spreadRadius: -12)
                                  ]),
                              child: Center(
                                  child: Image.asset(
                                'asset/windspeed.png',
                                width: 60,
                              )),
                            ),
                            SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.1),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.2,
                              height: MediaQuery.sizeOf(context).height * 0.1,
                              decoration: BoxDecoration(
                                  color: Colors.deepPurple[200],
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.deepPurple.shade100,
                                        offset: Offset(0, 25),
                                        blurRadius: 10,
                                        spreadRadius: -12)
                                  ]),
                              child: Center(
                                  child: Image.asset(
                                'asset/humidity.png',
                                width: 60,
                              )),
                            ),
                            SizedBox(
                                width: MediaQuery.sizeOf(context).width * 0.1),
                            Container(
                              width: MediaQuery.sizeOf(context).width * 0.2,
                              height: MediaQuery.sizeOf(context).height * 0.1,
                              decoration: BoxDecoration(
                                  color: Colors.deepPurple[200],
                                  borderRadius: BorderRadius.circular(15),
                                  boxShadow: [
                                    BoxShadow(
                                        color: Colors.deepPurple.shade100,
                                        offset: Offset(0, 25),
                                        blurRadius: 10,
                                        spreadRadius: -12)
                                  ]),
                              child: Center(
                                  child: Image.asset(
                                'asset/temp.png',
                                width: 60,
                              )),
                            ),
                          ],
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).width * 0.04),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.9,
                          height: MediaQuery.sizeOf(context).height * 0.04,
                          child: Stack(
                            children: [
                              Positioned(
                                  left: 20,
                                  top: 6,
                                  child: Row(
                                    children: [
                                      Text(data.wind,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                                      Text(' Kmph',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                                    ],
                                  )),
                              Positioned(
                                  left: 160,
                                  top: 6,
                                  child: Row(
                                    children: [
                                      Text(data.humidity,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                                      Text('%',
                                style: TextStyle(fontWeight: FontWeight.bold)),
                                    ],
                                  )),
                              Positioned(
                                  left: 268,
                                  top: 6,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(data.temp,
                                style: TextStyle(fontWeight: FontWeight.bold)),
                                      Text(
                                        'o',
                                        style: TextStyle(fontSize: 8,fontWeight: FontWeight.bold),
                                      )
                                    ],
                                  )),
                            ],
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).width * 0.04),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          height: MediaQuery.sizeOf(context).height * 0.55,
                          decoration: BoxDecoration(
                            color: Colors.deepPurple.shade500.withOpacity(0.4),
                            borderRadius: BorderRadius.circular(15),
                            // boxShadow: [
                            //   BoxShadow(
                            //       //color: Colors.deepPurple.shade100,
                            //       offset: Offset(0, 25),
                            //       blurRadius: 10,
                            //       spreadRadius: -12)
                            // ]
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                'More Details',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(50, 20, 0, 0),
                                    child: Text(
                                      'Country',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 50, 0),
                                    child: Text(data.country),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(50, 20, 0, 0),
                                    child: Text(
                                      'City',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 50, 0),
                                    child: Text(data.city),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(50, 20, 0, 0),
                                    child: Text(
                                      'Sunrise Time',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 50, 0),
                                    child: Text("$srh"),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(50, 20, 0, 0),
                                    child: Text(
                                      'Sunset Time',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 50, 0),
                                    child: Text("$ssh"),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(50, 20, 0, 0),
                                    child: Text(
                                      'Pressure',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 50, 0),
                                    child: Text(data.pressure),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(50, 20, 0, 0),
                                    child: Text(
                                      'Temp-min',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          0, 20, 50, 0),
                                      child: Row(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(data.tempmin),
                                          Text(
                                            'o',
                                            style: TextStyle(fontSize: 8),
                                          )
                                        ],
                                      ))
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(50, 20, 0, 0),
                                    child: Text(
                                      'Temp-max',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 50, 0),
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(data.tempmax),
                                        Text(
                                          'o',
                                          style: TextStyle(fontSize: 8),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(50, 20, 0, 0),
                                    child: Text(
                                      'Visibility',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 50, 0),
                                    child: Text(data.visibility),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(50, 20, 0, 0),
                                    child: Text(
                                      'Longitude',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 50, 0),
                                    child: Text(data.lon),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(50, 20, 0, 0),
                                    child: Text(
                                      'Latitude',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(0, 20, 50, 0),
                                    child: Text(data.lat),
                                  )
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    );
                  }
                } else if (snapshot.connectionState ==
                    ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                } else {
                  return Center(
                    child: Text("${snapshot.connectionState} occured"),
                  );
                }
                return Center(
                  child: Text("Server timed out!"),
                );
              },
              future: _myData!,
            ),
          ],
        ),
      ),
    );
  }
}
