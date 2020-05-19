import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:weather/constant.dart';
import 'package:weather/screen/loading_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          scaffoldBackgroundColor: kbackgroundColor,
          sliderTheme: SliderThemeData(
            thumbColor: Colors.orangeAccent,
            overlayColor: Colors.orange[200].withOpacity(0.4),
          ),
          fontFamily: 'Source Sans Pro',
          appBarTheme: AppBarTheme(
              color: kbackgroundColor,
              textTheme: TextTheme(
                  title: TextStyle(
                      fontFamily: 'SourceSansPro-Light',
                      fontWeight: FontWeight.w500))),
        ),
        title: 'Weather',
        darkTheme: ThemeData.dark().copyWith(
            scaffoldBackgroundColor: Colors.grey[900],
            sliderTheme: SliderThemeData(thumbColor: Colors.grey[200])),
        home: loadingScreen());
  }
}
