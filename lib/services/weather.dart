import 'package:weather_app/services/location.dart';
import 'package:weather_app/services/networking.dart';

const kapikey = 'abcf902cf40a3c7865a24cf0563757d8';

class WeatherModel {
  Future<dynamic> CurrentWeatherData() async {
    Location location = Location();
    await location.getPosition();
    var network = Network(
        "https://api.openweathermap.org/data/2.5/weather?lat=${location.latitude}&lon=${location.longitude}&appid=$kapikey&units=metric");
    var weatherData = await network.getResponse();
    return weatherData;
  }

  Future<dynamic> CityWeatherData(var cityName) async {
    String cityNameS = cityName.toString();
    var network = Network(
        "https://api.openweathermap.org/data/2.5/weather?q=$cityNameS&appid=$kapikey&units=metric");
    print(cityNameS);
    var weatherData = await network.getResponse();
    return weatherData;
  }

  String getWeatherIcon(int condition) {
    if (condition == 0) {
      return ' ';
    } else if (condition < 300) {
      return '๐ฉ';
    } else if (condition < 400) {
      return '๐ง';
    } else if (condition < 600) {
      return 'โ๏ธ';
    } else if (condition < 700) {
      return 'โ๏ธ';
    } else if (condition < 800) {
      return '๐ซ';
    } else if (condition == 800) {
      return 'โ๏ธ';
    } else if (condition <= 804) {
      return 'โ๏ธ';
    } else {
      return '๐คทโ';
    }
  }

  String getMessage(int temp) {
    if (temp == -66) {
      return "Invalid";
    } else if (temp > 25) {
      return 'It\'s ๐ฆ time';
    } else if (temp > 20) {
      return 'Time for shorts and ๐';
    } else if (temp < 10) {
      return 'You\'ll need ๐งฃ and ๐งค';
    } else {
      return 'Bring a ๐งฅ just in case';
    }
  }
}
