import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserController with ChangeNotifier {
  static const String uuidKey = "app_uuid";

  String? _uuid;
  String? get uuid => _uuid;


  Future<void> getOrCreateUUID() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? storedUUID = prefs.getString(uuidKey);

  if (storedUUID == null) {
    _uuid = const Uuid().v4();
    await prefs.setString(uuidKey, _uuid!);
  } else {
    _uuid = storedUUID;
  }

  notifyListeners(); 
  log("UUID: $_uuid");
}

}

