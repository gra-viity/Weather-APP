import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:weather/screen/MoreDetails.dart';
import 'package:weather/screen/MyHomePage.dart';
import 'package:weather/services/weatherModel.dart';

List<Widget> myPages = [
  MyHomePage(LocationWeather: weatherData),
  MoreDetails(LocationWeather: weatherData)
];
var weatherData;

class loadingScreen extends StatefulWidget {
  @override
  _loadingScreenState createState() => _loadingScreenState();
}

class _loadingScreenState extends State<loadingScreen> {
  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  Future<dynamic> getLocationData() async {
    weatherData = await WeatherModel().getCityWeather();

    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) {
      return PageView.builder(
          scrollDirection: Axis.vertical,
          itemCount: myPages.length,
          itemBuilder: (context, position) => myPages[position]);
    }), (route) => false);
  }

  @override
  Widget build(BuildContext context) {
    return (weatherData == null)
        ? Scaffold(
            body: Center(
                child: SpinKitDoubleBounce(
            color: Colors.white,
            size: 100,
          )))
        : makeAlert(context);
  }

  makeAlert(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
              title: Text('Check your data connection adn location'));
        });
  }
}
