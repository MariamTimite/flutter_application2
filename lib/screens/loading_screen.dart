import 'package:flutter/material.dart';
import 'package:flutter_application_2/screens/location_screen.dart';
import 'package:location/location.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width / 2.5,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20)
              )
            ),
            onPressed: () async{
              // recuperer la position actuelle
              // 
              Location location =  Location();

              bool _serviceEnabled;
              PermissionStatus _permissionGranted;
              LocationData _locationData;

              _serviceEnabled = await location.serviceEnabled();
              if (!_serviceEnabled) {
                _serviceEnabled = await location.requestService();
                if (!_serviceEnabled) {
                  return;
                }
              }
              _permissionGranted = await location.hasPermission();
              if (_permissionGranted == PermissionStatus.denied) {
                _permissionGranted = await location.requestPermission();
                if (_permissionGranted != PermissionStatus.granted) {
                  return;
                }
              }
              _locationData = await location.getLocation();
              print("${_locationData.latitude} : ${_locationData.longitude}");
              
              print(_locationData.latitude.runtimeType);
              Navigator.push(context, MaterialPageRoute(builder: (context)=> LocationScreen(_locationData.longitude, _locationData.latitude)));
            },
            child: Text('Get Location'),
          ),
        ),
      ),
    );
  }
}
