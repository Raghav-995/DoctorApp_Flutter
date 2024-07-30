// import 'package:flutter/material.dart';
// import 'package:location/location.dart';
// import 'package:dio/dio.dart';
//
// class LocationDioDemo extends StatefulWidget {
// @override
// _LocationDioDemoState createState() => _LocationDioDemoState();
// }
//
// class _LocationDioDemoState extends State<LocationDioDemo> {
//   LocationData? _currentLocation;
//   Location _locationService = Location();
//   bool _permission = false;
//   String? _error;
//
//   @override
//   void initState() {
//     super.initState();
//     _getLocationPermission();
//   }
//
//   void _getLocationPermission() async {
//     bool serviceEnabled = await _locationService.serviceEnabled();
//     if (!serviceEnabled) {
//       serviceEnabled = await _locationService.requestService();
//       if (!serviceEnabled) {
//         setState(() {
//           _error = 'Location services are disabled.';
//         });
//         return;
//       }
//     }
//
//     PermissionStatus permissionGranted = await _locationService.hasPermission();
//     if (permissionGranted == PermissionStatus.denied) {
//       permissionGranted = await _locationService.requestPermission();
//       if (permissionGranted != PermissionStatus.granted) {
//         setState(() {
//           _error = 'Location permissions are denied.';
//         });
//         return;
//       }
//     }
//
//     if (permissionGranted == PermissionStatus.granted) {
//       setState(() {
//         _permission = true;
//       });
//       _getCurrentLocation();
//     } else {
//       setState(() {
//         _error = 'Location permissions are denied.';
//       });
//     }
//   }
//
//   void _getCurrentLocation() async {
//     try {
//       LocationData locationData = await _locationService.getLocation();
//       setState(() {
//         _currentLocation = locationData;
//       });
//       _postDataToApi(locationData);
//     } catch (e) {
//       setState(() {
//         _error = e.toString();
//       });
//     }
//   }
//
//   void _postDataToApi(LocationData locationData) async {
//     Dio dio = Dio();
//     // Replace 'YOUR_API_ENDPOINT' with your actual API endpoint
//     String apiUrl = 'https://seerecs.org/user/addDeviceLocation';
//
//     try {
//       Response response = await dio.post(apiUrl, data: {
//         'latitude': locationData.latitude,
//         'longitude': locationData.longitude,
//         'altitude': locationData.altitude,
//       });
//       print(response.data);
//     } catch (error) {
//       print('Error posting data to API: $error');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Location to Dio API Demo'),
//       ),
//       body: Center(
//         child: _permission
//             ? Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: <Widget>[
//             Text('Latitude: ${_currentLocation!.latitude}'),
//             Text('Longitude: ${_currentLocation!.longitude}'),
//             Text('Altitude: ${_currentLocation!.altitude}'),
//           ],
//         )
//             : Text(_error ?? 'Getting location...'),
//       ),
//     );
//   }
// }
