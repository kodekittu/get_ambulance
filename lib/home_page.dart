import 'package:flutter/material.dart';
import 'package:location/location.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  bool isCollected = false;
  double longitude = 0.0;
  double latitude = 0.0;
  double altitude = 0.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Location"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            MaterialButton(
              child: Text("Get My location"),
              onPressed: ()  async {
                Location location = new Location();

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

                setState(() {
                  longitude = _locationData.longitude;
                  latitude = _locationData.latitude;
                });
                print(_locationData.longitude.toString());
                print(_locationData.latitude.toString());

              },
            ),

            Container(
              padding: EdgeInsets.all(15),
              child: Text(
                "LATITUTE : " + latitude.toString() + "\n" +
                "LONGITUDE : " + longitude.toString()
              ),
            )
          ],
        ),
      ),
    );
  }
}