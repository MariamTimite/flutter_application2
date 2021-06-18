import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:flutter_application_2/services/weather.dart';
import 'package:flutter_application_2/utilities/constants.dart';
import 'package:http/http.dart' as http;

class LocationScreen extends StatefulWidget {
  double longitude;
  double latitude;
  LocationScreen(this.longitude, this.latitude);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {



@override
  void initState() {
    super.initState();
    print("Je viens avant la creation de la page");
    getDataOpenWeatherMap(widget.latitude, widget.longitude);

  }

  getDataOpenWeatherMap(double lon, double lat)async{
    var url = Uri.parse('https://community-open-weather-map.p.rapidapi.com/weather?lat=${lat}&lon=${lon}&units=metric');
    print(url);
    var response = await http.get(url, headers: {
      'x-rapidapi-key': '52753f5ac0msh7c9c191566215abp16924bjsn15aea723e7d9', 
      'x-rapidapi-host': 'community-open-weather-map.p.rapidapi.com',
      'useQueryString': 'true'
    
      });
    print('Response status: ${response.statusCode}');
    print('Response body: ${response.body}');

    // decode data
    // 
    var data = json.decode(response.body);
    double temp = data['main']['temp'];
    var temperature = temp.toInt();
    var condition = data['weather'][0]['id'];

    print('///////////////////////////////');
    print(temperature);
    print(condition);

    print(WeatherModel().getWeatherIcon(condition));
    print(WeatherModel().getMessage(temperature));

  }

  @override
  Widget build(BuildContext context) {

    print(widget.longitude);
    print(widget.latitude);

    return Scaffold(
      body: Container(
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
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: () {},
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      '32°',
                      style: kTempTextStyle,
                    ),
                    Text(
                      '☀️',
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
                  "It's 🍦 time in San Francisco!",
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
