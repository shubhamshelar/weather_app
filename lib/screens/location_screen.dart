//import 'dart:html';

import 'package:flutter/material.dart';
import 'package:weather_app/utilities/constants.dart';
import 'package:weather_app/services/weather.dart';
import 'city_screen.dart';

class LocationScreen extends StatefulWidget {
  final weatherData;
  LocationScreen(this.weatherData);
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  late int temperature;
  late int conditionNo;
  String? cityName;
  var weather = WeatherModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setData(widget.weatherData);
    //print(widget.weatherData);
  }

  void setData(var weatherData) {
    print(weatherData);
    if (weatherData == null) {
      setState(() {
        temperature = -66;
        //temperature = 0;
        conditionNo = 0;
        cityName = '#';
      });
      return;
    }
    setState(() {
      var temp = weatherData['main']['temp'];
      temperature = temp.toInt();
      //temperature = 0;
      conditionNo = weatherData['weather'][0]['id'];
      cityName = weatherData['name'];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('images/location_background.jpg'),
              fit: BoxFit.cover,
              colorFilter: ColorFilter.mode(
                  Colors.white.withOpacity(0.8), BlendMode.dstATop),
            ),
          ),
          constraints: BoxConstraints.expand(),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    TextButton(
                      onPressed: () async {
                        var weatherData = await weather.CurrentWeatherData();
                        setData(weatherData);
                      },
                      child: Icon(
                        Icons.near_me,
                        size: 50.0,
                      ),
                    ),
                    TextButton(
                      onPressed: () async {
                        var cityName = await Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CityScreen();
                        }));

                        if (cityName != null) {
                          var weatherData =
                              await weather.CityWeatherData(cityName);
                          setData(weatherData);
                        }
                      },
                      child: Icon(
                        Icons.location_city,
                        size: 50.0,
                      ),
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Text(
                        '$temperature ',
                        style: kTempTextStyle,
                      ),
                      Text(
                        '${weather.getWeatherIcon(conditionNo)}️',
                        style: kConditionTextStyle,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 10.0),
                  child: Text(
                    "${weather.getMessage(temperature)} in $cityName!",
                    textAlign: TextAlign.right,
                    style: kMessageTextStyle,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
