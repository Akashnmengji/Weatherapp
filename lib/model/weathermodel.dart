class WeatherModel {
  final String temp;
  final String city;
  final String desc;
  final String weathermain;
  final String pressure;
  final String humidity;
  final String tempmin;
  final String tempmax;
  final String visibility;
  final String wind;
  final String country;
  final String sunrise;
  final String sunset;
  final String lon;
  final String lat;
  final String pic;
  final String dt;

  WeatherModel.fromMap(Map<String, dynamic> json)
      : temp = json['main']['temp'].toString(),
        city = json['name'],
        weathermain = json['weather'][0]['main'],
        pressure = json['main']['pressure'].toString(),
        humidity = json['main']['humidity'].toString(),
        tempmin = json['main']['temp_min'].toString(),
        tempmax = json['main']['temp_max'].toString(),
        visibility = json['visibility'].toString(),
        wind = json['wind']['speed'].toString(),
        country = json['sys']['country'],
        sunrise = json['sys']['sunrise'].toString(),
        sunset = json['sys']['sunset'].toString(),
        lon = json['coord']['lon'].toString(),
        lat = json['coord']['lat'].toString(),
        desc = json['weather'][0]['description'],
        pic = json['weather'][0]['icon'],
        dt = json['dt'].toString();
}