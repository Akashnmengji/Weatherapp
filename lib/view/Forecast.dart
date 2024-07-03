import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../model/Forecastmodel.dart';
import '../service/call_to_api2.dart';

class Forecastpage extends StatefulWidget {
  const Forecastpage({super.key});

  @override
  State<Forecastpage> createState() => _ForecastpageState();
}

class _ForecastpageState extends State<Forecastpage> {
  Future<Forecastmodel> getData1(bool isCurrentCity, String cityName) async {
    return await CallToApi2().callWeatherAPihourly(isCurrentCity, cityName);
  }

  late String img;
  late String img2 = '';
  late String tempmin = '0';
  late String tempmax = '0';
  late String weathermain = '';
  late String description = '';
  late String temp = '';
  late String pressure = '';
  late String seaLevel = '';
  late String grndLevel = '';
  late String humidity = '';
  late String tempKf = '';

  late String main = '';

  late String speed = '';

  late String visibility = '';

  late String sr = '';
  late String ss = '';

  int a = 0;

  TextEditingController _search2 = TextEditingController();
  Future<Forecastmodel>? _myData2;
  @override
  void initState() {
    setState(() {
      _myData2 = getData1(true, "");
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
                controller: _search2,
                onSubmitted: (value) {
                  setState(() {
                    _myData2 = getData1(false, _search2.text);
                    a=0;
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
                  if (a == 0) {
                    String? pic2 = snapshot.data?.list[0].weather[0].icon;
                    if (pic2 == '01d') {
                      img2 = 'asset/sunny.png';
                    } else if (pic2 == '01n') {
                      img2 = 'asset/moon.png';
                    } else if (pic2 == '02d') {
                      img2 = 'asset/CloudDay.png';
                    } else if (pic2 == '02n') {
                      img2 = 'asset/CloudNight.png';
                    } else if (pic2 == '03d') {
                      img2 = 'asset/ScatteredCloudDay.png';
                    } else if (pic2 == '03n') {
                      img2 = 'asset/ScatteredCloudNight.png';
                    } else if (pic2 == '04d') {
                      img2 = 'asset/BrokenCloudsDay.png';
                    } else if (pic2 == '04n') {
                      img2 = 'asset/BrokenCloudsNight.png';
                    } else if (pic2 == '09d') {
                      img2 = 'asset/RainDay.png';
                    } else if (pic2 == '09n') {
                      img2 = 'asset/RainNight.png';
                    } else if (pic2 == '10d') {
                      img2 = 'asset/RainDay.png';
                    } else if (pic2 == '10n') {
                      img2 = 'asset/RainNight.png';
                    } else if (pic2 == '11d') {
                      img2 = 'asset/thunderstormDay.png';
                    } else if (pic2 == '11n') {
                      img2 = 'asset/thunderstormNight.png';
                    } else if (pic2 == '13d') {
                      img2 = 'asset/SnowDay.png';
                    } else if (pic2 == '13n') {
                      img2 = 'asset/SnowNight.png';
                    } else if (pic2 == '50d') {
                      img2 = 'asset/MistDay.png';
                    } else if (pic2 == '50n') {
                      img2 = 'asset/MistNight.png';
                    }

                    temp = snapshot.data!.list[0].main.temp.toString();
                    tempKf = snapshot.data!.list[0].main.tempKf.toString();
                    pressure = snapshot.data!.list[0].main.pressure.toString();
                    humidity = snapshot.data!.list[0].main.humidity.toString();
                    tempmin = snapshot.data!.list[0].main.tempMin.toString();
                    tempmax = snapshot.data!.list[0].main.tempMax.toString();
                    seaLevel = snapshot.data!.list[0].main.seaLevel.toString();
                    grndLevel =
                        snapshot.data!.list[0].main.grndLevel.toString();

                    weathermain =
                        snapshot.data!.list[0].weather[0].main.toString();
                    description = snapshot.data!.list[0].weather[0].description
                        .toString();

                    speed = snapshot.data!.list[0].wind.speed.toString();

                    visibility = snapshot.data!.list[0].visibility.toString();

                    DateTime srt = DateTime.fromMillisecondsSinceEpoch(
                        snapshot.data!.city.sunrise * 1000);
                    String srh = DateFormat.jm().format(srt);

                    DateTime sst = DateTime.fromMillisecondsSinceEpoch(
                        snapshot.data!.city.sunset * 1000);
                    String ssh = DateFormat.jm().format(sst);

                    ss = ssh as String;
                    sr = srh as String;
                  }

                  // If error occured
                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        '${snapshot.error.toString()} occurred',
                        style: TextStyle(fontSize: 18),
                      ),
                    );
                  } else if (snapshot.hasData) {
                    final data = snapshot.data as Forecastmodel;
                    return Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(16, 8, 8, 0),
                                  child: Icon(
                                    Icons.location_pin,
                                    size: 40,
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data.city.name,
                                      style: TextStyle(
                                          fontSize: 30,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(data.city.country)
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.01,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(12.0),
                          child: Container(
                            height: MediaQuery.sizeOf(context).height * 0.21,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: data.list.length,
                              itemBuilder: (context, index) {
                                // print(List);
                                final weather = data.list[index].weather[0];
                                int? d = int.tryParse(
                                    data.list[index].dt.toString());
                                DateTime date =
                                    DateTime.fromMillisecondsSinceEpoch(
                                        d! * 1000);
                                // String formattedDate =
                                //     DateFormat.yMMMMd().format(date);
                                String formattedtime =
                                    DateFormat.jm().format(date);

                                String pic = weather.icon;
                                void imgselected() {
                                  if (pic == '01d') {
                                    img = 'asset/sunny.png';
                                  } else if (pic == '01n') {
                                    img = 'asset/moon.png';
                                  } else if (pic == '02d') {
                                    img = 'asset/CloudDay.png';
                                  } else if (pic == '02n') {
                                    img = 'asset/CloudNight.png';
                                  } else if (pic == '03d') {
                                    img = 'asset/ScatteredCloudDay.png';
                                  } else if (pic == '03n') {
                                    img = 'asset/ScatteredCloudNight.png';
                                  } else if (pic == '04d') {
                                    img = 'asset/BrokenCloudsDay.png';
                                  } else if (pic == '04n') {
                                    img = 'asset/BrokenCloudsNight.png';
                                  } else if (pic == '09d') {
                                    img = 'asset/RainDay.png';
                                  } else if (pic == '09n') {
                                    img = 'asset/RainNight.png';
                                  } else if (pic == '10d') {
                                    img = 'asset/RainDay.png';
                                  } else if (pic == '10n') {
                                    img = 'asset/RainNight.png';
                                  } else if (pic == '11d') {
                                    img = 'asset/thunderstormDay.png';
                                  } else if (pic == '11n') {
                                    img = 'asset/thunderstormNight.png';
                                  } else if (pic == '13d') {
                                    img = 'asset/SnowDay.png';
                                  } else if (pic == '13n') {
                                    img = 'asset/SnowNight.png';
                                  } else if (pic == '50d') {
                                    img = 'asset/MistDay.png';
                                  } else if (pic == '50n') {
                                    img = 'asset/MistNight.png';
                                  }
                                }

                                imgselected();

                                return Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.fromLTRB(
                                          18, 0, 0, 0),
                                      child: Container(
                                        width:
                                            MediaQuery.sizeOf(context).width *
                                                0.25,
                                        height:
                                            MediaQuery.sizeOf(context).height *
                                                0.19,
                                        decoration: BoxDecoration(
                                            color: Colors.deepPurple[200],
                                            borderRadius:
                                                BorderRadius.circular(15),
                                            boxShadow: [
                                              BoxShadow(
                                                  color: Colors
                                                      .deepPurple.shade100,
                                                  offset: Offset(0, 25),
                                                  blurRadius: 10,
                                                  spreadRadius: -12)
                                            ]),
                                        child: Stack(
                                          children: [
                                            Column(
                                              // crossAxisAlignment:CrossAxisAlignment.center,
                                              // mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.fromLTRB(
                                                          0, 16, 0, 0),
                                                  child: Text('$formattedtime'),
                                                ),
                                                Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: Image.asset(
                                                      img,
                                                      width: 60,
                                                    ),
                                                  ),
                                                ),
                                                Text("T-min  "
                                                    '${data.list[index].main.tempMin.toString()}'),
                                                Text("T-max  "
                                                    '${data.list[index].main.tempMax.toString()}'),
                                              ],
                                            ),
                                            Container(
                                              width: MediaQuery.sizeOf(context)
                                                      .width *
                                                  0.25,
                                              height: MediaQuery.sizeOf(context)
                                                      .height *
                                                  0.19,
                                              child: ElevatedButton(
                                                style: ElevatedButton.styleFrom(
                                                  primary: Colors.transparent,
                                                  shadowColor:
                                                      Colors.transparent,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 20.0,
                                                      vertical: 15.0),
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    temp = data
                                                        .list[index].main.temp
                                                        .toString();
                                                    print(temp);
                                                    tempKf = data
                                                        .list[index].main.tempKf
                                                        .toString();
                                                    pressure = data.list[index]
                                                        .main.pressure
                                                        .toString();
                                                    humidity = data.list[index]
                                                        .main.humidity
                                                        .toString();
                                                    tempmin = data.list[index]
                                                        .main.tempMin
                                                        .toString();
                                                    tempmax = data.list[index]
                                                        .main.tempMax
                                                        .toString();
                                                    seaLevel = data.list[index]
                                                        .main.seaLevel
                                                        .toString();
                                                    grndLevel = data.list[index]
                                                        .main.grndLevel
                                                        .toString();

                                                    weathermain =
                                                        weather.main.toString();
                                                    description = weather
                                                        .description
                                                        .toString();

                                                    speed = data
                                                        .list[index].wind.speed
                                                        .toString();

                                                    visibility = data
                                                        .list[index].visibility
                                                        .toString();

                                                    DateTime srt = DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                            data.city.sunrise *
                                                                1000);
                                                    String srh = DateFormat.jm()
                                                        .format(srt);

                                                    DateTime sst = DateTime
                                                        .fromMillisecondsSinceEpoch(
                                                            data.city.sunset *
                                                                1000);
                                                    String ssh = DateFormat.jm()
                                                        .format(sst);

                                                    ss = ssh as String;
                                                    sr = srh as String;

                                                    img2 = pic;
                                                    if (pic == '01d') {
                                                      img2 = 'asset/sunny.png';
                                                    } else if (pic == '01n') {
                                                      img2 = 'asset/moon.png';
                                                    } else if (pic == '02d') {
                                                      img2 =
                                                          'asset/CloudDay.png';
                                                    } else if (pic == '02n') {
                                                      img2 =
                                                          'asset/CloudNight.png';
                                                    } else if (pic == '03d') {
                                                      img2 =
                                                          'asset/ScatteredCloudDay.png';
                                                    } else if (pic == '03n') {
                                                      img2 =
                                                          'asset/ScatteredCloudNight.png';
                                                    } else if (pic == '04d') {
                                                      img2 =
                                                          'asset/BrokenCloudsDay.png';
                                                    } else if (pic == '04n') {
                                                      img2 =
                                                          'asset/BrokenCloudsNight.png';
                                                    } else if (pic == '09d') {
                                                      img2 =
                                                          'asset/RainDay.png';
                                                    } else if (pic == '09n') {
                                                      img2 =
                                                          'asset/RainNight.png';
                                                    } else if (pic == '10d') {
                                                      img2 =
                                                          'asset/RainDay.png';
                                                    } else if (pic == '10n') {
                                                      img2 =
                                                          'asset/RainNight.png';
                                                    } else if (pic == '11d') {
                                                      img2 =
                                                          'asset/thunderstormDay.png';
                                                    } else if (pic == '11n') {
                                                      img2 =
                                                          'asset/thunderstormNight.png';
                                                    } else if (pic == '13d') {
                                                      img2 =
                                                          'asset/SnowDay.png';
                                                    } else if (pic == '13n') {
                                                      img2 =
                                                          'asset/SnowNight.png';
                                                    } else if (pic == '50d') {
                                                      img2 =
                                                          'asset/MistDay.png';
                                                    } else if (pic == '50n') {
                                                      img2 =
                                                          'asset/MistNight.png';
                                                    }
                                                    a = 1;
                                                  });
                                                },
                                                child: const Text(
                                                  '',
                                                  style: TextStyle(
                                                      color: Colors.black),
                                                ),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).width * 0.1),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.8,
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
                                    img2,
                                    width: 140,
                                  )),
                              Positioned(
                                  bottom: 70,
                                  left: 46,
                                  child: Text(
                                    (weathermain),
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
                                        (temp),
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
                                child: Text((description),
                                    style: TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold)),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: MediaQuery.sizeOf(context).height * 0.06,
                        ),
                        Container(
                          width: MediaQuery.sizeOf(context).width * 0.8,
                          height: MediaQuery.sizeOf(context).height * 0.65,
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
                                height: MediaQuery.sizeOf(context).width * 0.1,
                              ),
                              Text(
                                'More Details',
                                style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    decoration: TextDecoration.underline),
                              ),
                              rows('Country', data.city.country),
                              rows('City', data.city.name),
                              rows('Population',
                                  data.city.population.toString()),
                              rows('Sunrise Time', '$sr'),
                              rows('Sunset Time', '$ss'),
                              rows('Pressure', pressure),
                              rows('Visibility', visibility),
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
                                          Text(tempmin),
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
                                        Text(tempmax),
                                        Text(
                                          'o',
                                          style: TextStyle(fontSize: 8),
                                        )
                                      ],
                                    ),
                                  )
                                ],
                              ),
                              rows('Longitude', data.city.coord.lon.toString()),
                              rows('Latitude', data.city.coord.lat.toString()),
                            ],
                          ),
                        ),
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
              future: _myData2!,
            ),
          ],
        ),
      ),
    );
  }

  Widget rows(String str1, String str2) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(50, 20, 0, 0),
          child: Text(
            str1,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 50, 0),
          //child: Text(data.city.coord.lat.toString()),
          child: Text(str2),
        )
      ],
    );
  }
}
