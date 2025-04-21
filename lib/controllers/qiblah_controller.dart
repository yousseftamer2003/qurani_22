import 'package:flutter/foundation.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:permission_handler/permission_handler.dart';

class QiblaProvider with ChangeNotifier {
  bool isLoading = true;
  bool hasPermission = false;
  QiblahDirection? qiblaDirection;

  QiblaProvider() {
    _checkPermissions();
  }

  Future<void> _checkPermissions() async {
    var status = await Permission.location.request();
    if (status.isGranted) {
      hasPermission = true;
      _startQiblaStream();
    } else {
      hasPermission = false;
    }
    isLoading = false;
    notifyListeners();
  }

  void _startQiblaStream() {
    FlutterQiblah.qiblahStream.listen((direction) {
      qiblaDirection = direction;
      notifyListeners();
    });
  }
}
