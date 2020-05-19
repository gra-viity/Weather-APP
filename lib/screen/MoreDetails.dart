import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather/constant.dart';
import 'package:weather/services/networking.dart';

class MoreDetails extends StatefulWidget {
  final LocationWeather;

  const MoreDetails({this.LocationWeather});

  @override
  _MoreDetailsState createState() => _MoreDetailsState();
}

class _MoreDetailsState extends State<MoreDetails> {
  var humidity;
  var pressure;
  var sea_level;
  var ground_level;
  var windspeed;
  var timezone;
  var clouds;

  @override
  void initState() {
    super.initState();
    getLocationData();
    updateUI(widget.LocationWeather);
  }

  void getLocationData() async {
    // Asynchronous method to get location coord
    Networking networking = Networking(
        'https://api.openweathermap.org/data/2.5/forecast?lat=35&lon=139&appid=12df51e291aae483fedeb9e98eb69ab4');
    Networking networking2 = Networking(
        'https://api.openweathermap.org/data/2.5/uvi?lat=76.82&lon=30.69&appid=12df51e291aae483fedeb9e98eb69ab4');
    /*
    Note :This is sample url to get weekly forecast as free api key does't not support daily forecast.(mon to sun)
    so if you have purchased higher package replace it sample==api and id == your api key.
     */
    var uvIndex = await networking2.getData();
    var weeklyWeatherData = await networking.getData();
    //print(weatherData);
  }

  void updateUI(dynamic weatherData) {
    setState(() {
      if (weatherData == null) {
        humidity = 0;
        pressure = 0;
        sea_level = 0;
        ground_level = 0;
        windspeed = 0;
        timezone = 0;
        clouds = 0;
        return;
      }
      humidity = weatherData['main']['humidity'];
      pressure = weatherData['main']['pressure'];
      sea_level = weatherData['main']['sea_level'];
      ground_level = weatherData['main']['grnd_level'];
      windspeed = weatherData['wind']['speed'];
      timezone = weatherData['timezone'];
      clouds = weatherData['clouds']['all'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: <Widget>[
                      Icon(FontAwesomeIcons.angleDoubleUp),
                      SizedBox(height: 10),
                      Center(child: Text('More Details', style: ktextStyle20)),
                    ])),
            Container(
              height: 250,
              child: Padding(
                padding:
                    EdgeInsets.only(bottom: 50, left: 25, right: 25, top: 30),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    makeWeatherWeek(
                        day: 'MON',
                        image: 'asset/icons/ldpi/cloudyldpi.png',
                        minTemp: '20',
                        maxTemp: '40'),
                    makeWeatherWeek(
                        day: 'TUE',
                        image: 'asset/icons/ldpi/cloudyldpi.png',
                        minTemp: '20',
                        maxTemp: '40'),
                    makeWeatherWeek(
                        day: 'WED',
                        image: 'asset/icons/ldpi/cloudyldpi.png',
                        minTemp: '20',
                        maxTemp: '40'),
                    makeWeatherWeek(
                        day: 'THU',
                        image: 'asset/icons/ldpi/cloudyldpi.png',
                        minTemp: '20',
                        maxTemp: '40'),
                    makeWeatherWeek(
                        day: 'FRI',
                        image: 'asset/icons/ldpi/cloudyldpi.png',
                        minTemp: '20',
                        maxTemp: '40'),
                    makeWeatherWeek(
                        day: 'SAT',
                        image: 'asset/icons/ldpi/cloudyldpi.png',
                        minTemp: '20',
                        maxTemp: '40'),
                    makeWeatherWeek(
                        day: 'SUN',
                        image: 'asset/icons/ldpi/cloudyldpi.png',
                        minTemp: '20',
                        maxTemp: '40'),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                margin: EdgeInsets.all(30),
                child: Column(
                  children: <Widget>[
                    makeDetailsColumn(
                        data1Name: 'Cloudiness',
                        data2Name: 'Humidity',
                        data1Value: '$clouds%',
                        data2Value: '$humidity %'),
                    makeDetailsColumn(
                        data1Name: 'Wind',
                        data2Name: 'Dew Point*', //not available in api data
                        data1Value: '$windspeed m/s',
                        data2Value: '40'),
                    makeDetailsColumn(
                        data1Name: 'Precipitation*', //not available in api data
                        data2Name: 'Pressure',
                        data1Value: '0 mm',
                        data2Value: '$pressure hPa'),
                    makeDetailsColumn(
                        data1Name: 'At.Presssure on Sea Level',
                        data2Name: 'At.Presssure on Ground Level',
                        data1Value: '$sea_level hPa',
                        data2Value: '$ground_level hPa'),
                    makeDetailsColumn(
                        data1Name:
                            'Air Quality Index*', //not available in api data
                        data2Name: 'Air Quality*', //not available in api data
                        data1Value: '71',
                        data2Value: 'Moderate')
                  ],
                ),
              ),
            ),
            Text('* Not Available Parameters'),
            Divider(
              endIndent: 100,
              indent: 100,
              thickness: 2,
            )
          ],
        ),
      ),
    );
  }

//--------------------------------------------------------------------------------------------
  Widget makeDetailsColumn({data1Name, data1Value, data2Name, data2Value}) {
    return Container(
        child: Column(children: <Widget>[
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(child: Text(data1Name, style: ktextStyle25boldgrey)),
          Expanded(child: Text(data2Name, style: ktextStyle25boldgrey))
        ],
      ),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          Expanded(child: Text(data1Value, style: ktextStyle20)),
          Expanded(child: Text(data2Value, style: ktextStyle20))
        ],
      ),
      Divider(
        height: 25,
        thickness: 2,
      )
    ]));
  }

//----------------------------------Custom Widget------------------------------------------
  Widget makeWeatherWeek({day, image, minTemp, maxTemp}) {
    return AspectRatio(
      aspectRatio: 3 / 4.4,
      child: Theme(
        data: ThemeData(), //TODO setup dark theme
        child: Container(
          margin: EdgeInsets.only(right: 20),
          decoration: BoxDecoration(
              color: Colors.grey[400], borderRadius: BorderRadius.circular(10)),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(
                day,
                style: ktextStyle20bold,
              ),
              SizedBox(
                height: 10,
              ),
              Image(
                image: AssetImage(image),
                height: 50,
                width: 50,
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    minTemp + '° ',
                    style: ktextStyle20.copyWith(color: Colors.white),
                  ),
                  Text(
                    maxTemp + '° ',
                    style: ktextStyle20.copyWith(color: Colors.deepOrange),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
