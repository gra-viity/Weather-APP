import 'package:weather/services/location.dart';
import 'package:weather/services/networking.dart';

const String apiKey = '12df51e291aae483fedeb9e98eb69ab4';   //API key

//Use your own API Key by signing in into openWeatherMap
// This is free api Key only for limited use.
class WeatherModel {
//  Future<dynamic> getCityWeather(String cityName) async {
//    NetworkHelper networkHelper = NetworkHelper(
//        '$openWeatherMapURL?q=$cityName&appid=$apiKey&units=metric');
//    var weatherData = await networkHelper.getData();
//    return weatherData;
//  }
//  Future<dynamic> getLocationWeather() async {
//    Location location = Location();
//    await location.getCurrentLocation();
//    NetworkHelper networkHelper = NetworkHelper(
//        '$openWeatherMapURL?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');
//    var weatherData = await networkHelper.getData();
//    return weatherData;
//  }

  Future<dynamic> getCityWeather() async {
    location lo = location();
    await lo.getCurrentLocation();
    Networking networking = Networking(
        'https://api.openweathermap.org/data/2.5/weather?lat=${lo.latitude}&lon=${lo.longitude}&appid=$apiKey&units=metric');
    // lo.latitude adn lo.longitude added in url after $ sign along with apiKey.

    var weatherData = await networking.getData();
    return weatherData;
  }

  String getWeatherIcon(int condition, var iconCode) {
    String ico = iconCode.toString();
//---------------------------------------------------------------------------
    if (condition < 300) {
      if (ico.contains('n')) {
        return 'asset/icons/xxhdpi/lightingWithRainNightxxhdpi.png'; //lighting with rain night
      }
      return 'asset/icons/xxhdpi/lightingWithRainxxhdpi.png';
    }
//----------------------------------------------------------------------------
    else if (condition < 400) {
      if (ico.contains('n')) {
        return 'asset/icons/xxhdpi/lightingNightxxhdpi.png'; //lighting night
      }
      return 'asset/icons/xxhdpi/lightningxxhdpi.png'; //lighting day
    }
//----------------------------------------------------------------------------
    else if (condition < 600 && condition >= 500) {
      if (condition == 500 || condition == 501) {
        if (ico.contains('n')) {
          return 'asset/icons/xxhdpi/rainNightxxhdpi.png'; //rain night
        }
        return 'asset/icons/xxhdpi/lightRainxxhdpi.png'; //moderate rain
      } else if (condition == 502 || condition == 503) {
        if (ico.contains('n')) {
          return 'asset/icons/xxhdpi/rainNightxxhdpi.png'; //rain night
        }
        return 'asset/icons/xxhdpi/heavyRainxxhdpi.png'; //heavy rain
      } else if (condition == 521 || condition == 522 || condition == 531) {
        return 'asset/icons/xxhdpi/showerxxhdpi.png'; // rain shower
      } else {
        return 'asset/icons/xxhdpi/rainxxhdpi.png';
      }
    }
//---------------------------------------------------------------------------
    else if (condition < 700) {
      return 'asset/icons/xxhdpi/breezyxxhdpi.png'; //windy or snowy atmosphere
    }
//---------------------------------------------------------------------------
    else if (condition < 800) {
      return 'asset/icons/xxhdpi/windyxxhdpi.png'; //windy atmosphere
    }
//---------------------------------------------------------------------------
    else if (condition == 800) {
      if (ico.contains('n')) {
        return 'asset/icons/xxhdpi/clearNightxxhdpi.png';
      }
      return 'asset/icons/xxhdpi/sunnyxxhdpi.png'; //clear sky with sun
    }
//---------------------------------------------------------------------------
    else if (condition <= 804) {
      if (ico.contains('n')) {
        return 'asset/icons/xxhdpi/cloudyNightxxhdpi.png'; //cloudy night
      }
      return 'asset/icons/xxhdpi/cloudyxxhdpi.png'; //cloudy
    }
//---------------------------------------------------------------------------
    else {
      return 'asset/icons/xxhdpi/appIconxxhdpi.png‍'; //default app icon
    }
  }

  String getMessage(int temp) {
    if (temp > 25) {
      return 'It\'s 🍦 time';
    } else if (temp > 20) {
      return 'Time for shorts and 👕';
    } else if (temp < 10) {
      return 'You\'ll need 🧣 and 🧤';
    } else {
      return 'Bring a 🧥 just in case';
    }
  }
}
