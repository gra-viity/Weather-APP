import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:weather/constant.dart';
import 'package:weather/screen/loading_screen.dart';
import 'package:weather/services/weatherModel.dart';

class MyHomePage extends StatefulWidget {
  final LocationWeather;

  MyHomePage({this.LocationWeather});
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var formatter =
      new DateFormat('jm'); //Time formatter jm stands for local time in AM/PM
  WeatherModel weatherModel = WeatherModel();
  int temp;
  double minTemp;
  double maxTemp;
  var feelsLike;
  String cityName;
  String description;
  var sunrise;
  var sunset;
  var time;
  String formattedUpdatedTime;
  String cel = 'C';
  String far = 'F';
  bool unit = true;
  String weatherIcon;
  var iconCode;
  @override
  void initState() {
    super.initState();
    updateUI(widget.LocationWeather);
  }

  dynamic timeFormatter({var time}) {
    var now = DateTime.fromMillisecondsSinceEpoch(time * 1000);
    return now;
  }

  void updateUI(dynamic weatherData) {
    print(weatherData);
    setState(() {
      if (weatherData == null) {
        temp = 0;
        minTemp = 0;
        maxTemp = 0;
        feelsLike = 0;
        cityName = 'its an error';
        description = 'its an error';
        sunrise = 0;
        sunset = 0;
        time = 0;
        weatherIcon = 'asset/icons/xxhdpi/appIconxxhdpi.png';
        formattedUpdatedTime = 'its an error';
        return;
      }
      description = weatherData['weather'][0]['description'];
      double temperature = weatherData['main']['temp'];
      temp = temperature.toInt();
      minTemp = weatherData['main']['temp_min'];
      maxTemp = weatherData['main']['temp_max'];
      feelsLike = weatherData['main']['feels_like'];
      var condition = weatherData['weather'][0]['id'];
      weatherIcon = weatherModel.getWeatherIcon(condition, iconCode);
      //--------------------------------time--------------------------------------
      var sunriseTime = weatherData['sys']['sunrise'];
      sunrise = formatter.format(timeFormatter(time: sunriseTime));

      var sunsetTime = weatherData['sys']['sunset'];
      sunset = formatter.format(timeFormatter(time: sunsetTime));

      time = weatherData['dt'];
      formattedUpdatedTime = formatter.format(timeFormatter(time: time));
      print(formattedUpdatedTime);
      cityName = weatherData['name'];
      day_night();
    });
  }

  String day_night() {
    if (weatherData == null) {
      return 'Damn';
    } else {
      iconCode = weatherData['weather'][0]['icon'];
      String ico = iconCode.toString();

      if (ico.contains('n')) {
        return 'Good Night';
      } else {
        return 'Good Morning';
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        title: Align(
            child: Text(cityName.toUpperCase(),
                style: TextStyle(fontSize: 35, color: Colors.grey[700]))),
        leading: IconButton(
          onPressed: () async {
            var weatherData = await WeatherModel().getCityWeather();
            updateUI(weatherData);
          },
          icon: FaIcon(FontAwesomeIcons.locationArrow, color: Colors.grey[700]),
        ),
        actions: <Widget>[
          GestureDetector(
            onTap: () => setState(() {
              // changeTempUnit(unit);
            }),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Center(
                child: RichText(
                  textScaleFactor: 2,
                  text: TextSpan(
                      text: '$cel°',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      children: <TextSpan>[
                        TextSpan(
                            text: ' / ',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey)),
                        TextSpan(
                            text: '$far°',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.grey))
                      ]),
                ),
              ),
            ),
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Container(
              child: Image.asset(weatherIcon),
            ),
            Text(
              '$description'.toUpperCase(),
              style: ktextStyle20,
            ),
            Divider(
              height: 1,
              thickness: 2,
              indent: 50,
              endIndent: 50,
            ),
            Row(
                textBaseline: TextBaseline.alphabetic,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.baseline,
                children: <Widget>[
                  Text(
                    'Min: $minTemp°',
                    style: ktextStyle20,
                  ),
                  Text(
                    '$temp°',
                    style: TextStyle(fontSize: 120),
                  ),
                  Text(
                    'Max: $maxTemp°',
                    style: ktextStyle20,
                  ),
                ]),

            Column(
              children: <Widget>[
                Text(
                  'Feels Like',
                  style: TextStyle(fontSize: 30),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    '$feelsLike°',
                    style: TextStyle(fontSize: 20),
                  ),
                )
              ],
            ),
            Divider(
              height: 1,
              thickness: 2,
              indent: 50,
              endIndent: 50,
            ),
            Text(
              'Updated as on $formattedUpdatedTime',
              style: ktextStyle16,
            ),
            Divider(
              height: 1,
              thickness: 2,
              indent: 50,
              endIndent: 50,
            ),
            //*********************************************----------------------------------------------****************
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text('Surise', style: TextStyle(fontSize: 16)),
                    SizedBox(width: 30.0),
                    Text('Sunset', style: TextStyle(fontSize: 16))
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Text('$sunrise', style: ktextStyle25),
                    SizedBox(width: 30.0),
                    Text('$sunset', style: ktextStyle25)
                  ],
                ),
              ],
            ),
            Column(children: <Widget>[
              Text(day_night(), style: TextStyle(fontSize: 20)),
              SizedBox(height: 10),
              Icon(FontAwesomeIcons.angleDoubleDown)
            ])
          ],
        ),
      ),
    );
  }
}
