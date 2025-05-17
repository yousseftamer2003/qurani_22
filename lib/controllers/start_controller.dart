import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qurani_22/constants/colors.dart';
import 'package:qurani_22/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';


class StartController with ChangeNotifier {

  bool _isLoading = true;

  bool get isLoading => _isLoading;

  void setisLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  double _latitude = 0.0;
  double _longitude = 0.0;
  String _address = '';

  double get latitude => _latitude;
  double get longitude => _longitude;
  String get address => _address;

  Future<void> getAddressFromLatLong(double lat, double lon) async {
  try {
    List<Placemark> placemarks = await placemarkFromCoordinates(lat, lon);

    if (placemarks.isNotEmpty) {
      Placemark place = placemarks[0]; 
      _address = "${place.subLocality} ${place.locality}, ${place.country}";
    }
    notifyListeners();
  } catch (e) {
    log('$e');
  }
}


Future<void> getCurrentLocation(context,{required bool isFirstTime}) async {
  if(!isFirstTime){
    final prefs = await SharedPreferences.getInstance();
    _latitude = prefs.getDouble('latitude') ?? 0.0;
    _longitude = prefs.getDouble('longitude') ?? 0.0;
    _address = prefs.getString('address') ?? 'No Address';
    notifyListeners();
  }else{
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
  _isLoading = true; // Start loading
  notifyListeners();

  await showDialog(
    context: context,
    barrierDismissible: true, // Allow tapping outside to close
    builder: (context) => AlertDialog(
      title: Text(S.of(context).locationRequired),
      content: Text(S.of(context).pleaseEnableLocationServicesForExactPrayerTimes),
      actions: [
        TextButton(
          child: Text(S.of(context).ok, style: const TextStyle(color: darkBlue)),
          onPressed: () async {
            Navigator.pop(context, true); // return true
          },
        )
      ],
    ),
  ).then((value) async {
    _isLoading = false;
    notifyListeners();
    if (value == true) {
      _isLoading = false;
      await Geolocator.openLocationSettings();
    }
  });

  return;
}

  PermissionStatus status = await Permission.location.status;
  
  if (status.isDenied) {
    
    status = await Permission.location.request();
  }
  
  if (status.isPermanentlyDenied) {
    
    return Future.error('Location permissions are permanently denied');
  }
  
  if (status.isGranted) {
    // Permission granted, get the location
    Position position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
    
    _latitude = position.latitude;
    _longitude = position.longitude;
    await getAddressFromLatLong(position.latitude, position.longitude);
    final prefs = await SharedPreferences.getInstance();
    prefs.setDouble('latitude', _latitude);
    prefs.setDouble('longitude', _longitude);
    prefs.setString('address', _address);
    _isLoading = false;
    notifyListeners();
  } else {
    return Future.error('Location permissions denied');
  }
  }
}
}