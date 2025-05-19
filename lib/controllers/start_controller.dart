// ignore_for_file: use_build_context_synchronously

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



Future<void> getCurrentLocation(BuildContext context, {required bool isFirstTime}) async {
  try {
    // Set loading state at the beginning
    _isLoading = true;
    notifyListeners();

    // If not first time, load cached location from preferences
    if (!isFirstTime) {
      final prefs = await SharedPreferences.getInstance();
      _latitude = prefs.getDouble('latitude') ?? 0.0;
      _longitude = prefs.getDouble('longitude') ?? 0.0;
      _address = prefs.getString('address') ?? 'No Address';
      _isLoading = false;
      notifyListeners();
      return;
    }

    // Check if location services are enabled
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      bool shouldOpenSettings = await showDialog(
        context: context,
        barrierDismissible: true,
        builder: (context) => AlertDialog(
          title: Text(S.of(context).locationRequired),
          content: Text(S.of(context).pleaseEnableLocationServicesForExactPrayerTimes),
          actions: [
            TextButton(
              child: Text(S.of(context).ok, style: const TextStyle(color: darkBlue)),
              onPressed: () => Navigator.pop(context, true),
            ),
            TextButton(
              child: Text(S.of(context).cancel, style: const TextStyle(color: Colors.grey)),
              onPressed: () => Navigator.pop(context, false),
            ),
          ],
        ),
      ) ?? false;

      if (shouldOpenSettings) {
        await Geolocator.openLocationSettings();
      }
      
      _isLoading = false;
      notifyListeners();
      return;
    }

    // Check location permission
    PermissionStatus status = await Permission.location.status;
    
    if (status.isDenied) {
      status = await Permission.location.request();
    }
    
    if (status.isPermanentlyDenied) {
      await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text(S.of(context).permissionDenied),
          content: Text(S.of(context).locationPermissionPermanentlyDenied),
          actions: [
            TextButton(
              child: Text(S.of(context).settings),
              onPressed: () => openAppSettings(),
            ),
            TextButton(
              child: Text(S.of(context).cancel),
              onPressed: () => Navigator.pop(context),
            ),
          ],
        ),
      );
      _isLoading = false;
      notifyListeners();
      return;
    }
    
    if (status.isGranted) {
      // Permission granted, get the location
      Position position = await Geolocator.getCurrentPosition(
        locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
      );
      
      _latitude = position.latitude;
      _longitude = position.longitude;
      await getAddressFromLatLong(position.latitude, position.longitude);
      
      // Save to preferences
      final prefs = await SharedPreferences.getInstance();
      prefs.setDouble('latitude', _latitude);
      prefs.setDouble('longitude', _longitude);
      prefs.setString('address', _address);
    }
  } catch (e) {
    // Handle any errors
    debugPrint('Error getting location: $e');
    _address = 'No Address'; // Reset to default on error
  } finally {
    // Always ensure loading is set to false when operation completes
    _isLoading = false;
    notifyListeners();
  }
}
}