import 'dart:developer';
import 'package:flutter/services.dart';

class AutoStartHelper {
  static const platform = MethodChannel('com.yourcompany.autostart');

  static Future<void> openAutoStartSettings() async {
    try {
      await platform.invokeMethod('openAutoStartSettings');
    } on PlatformException catch (e) {
      log("Failed to open auto-start settings: '${e.message}'.");
    }
  }
}

