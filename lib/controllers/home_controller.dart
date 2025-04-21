import 'dart:async';
import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:qurani_22/controllers/lang_controller.dart';
import 'package:qurani_22/controllers/notifications_controller.dart';
import 'package:qurani_22/controllers/start_controller.dart';
import 'package:qurani_22/models/prayer_model.dart';

class HomeController with ChangeNotifier {
  PrayerTimes? _prayerTimes;
  PrayerTimes? get prayerTimes => _prayerTimes;

  HijriDate? _hijriDate;
  HijriDate? get hijriDate => _hijriDate;

  String countdown = "Loading...";
  String nextPrayerName = "Loading...";  // Store the next prayer name
  Timer? _timer;

  bool isLoaded = false;

  Future<void> getPrayerTimes(BuildContext context) async {
    try {
      final startProvider = Provider.of<StartController>(context, listen: false);
      final latitude = startProvider.latitude;
      final longitude = startProvider.longitude;
      final date = DateFormat('dd-MM-yyyy').format(DateTime.now());
      final response = await http.get(Uri.parse(
          'https://api.aladhan.com/v1/timings/$date?latitude=$latitude&longitude=$longitude'));

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        _prayerTimes = PrayerTimes.fromJson(responseData['data']['timings']);
        _hijriDate = HijriDate.fromJson(responseData['data']['date']['hijri']);
        isLoaded = true;
        startCountdown(context);
        notifyListeners();
      }
    } catch (e) {
      log("Error fetching prayer times: $e");
    }
  }

  void startCountdown(BuildContext context) {
    _timer?.cancel(); // Cancel existing timer if any

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      timeUntilNextPrayer(context);
      notifyListeners();
    });
  }

  /// Function to calculate time until the next prayer
  void timeUntilNextPrayer(BuildContext context) {
  final langServices = Provider.of<LangServices>(context, listen: false);

  if (_prayerTimes == null) {
    countdown = "Loading...";
    nextPrayerName = "Loading...";
    return;
  }

  DateTime now = DateTime.now();

  // Define prayer names based on language
  List<Map<String, String>> prayers = langServices.isArabic
      ? [
          {"name": "الفجر", "time": _prayerTimes!.fajr},
          {"name": "الظهر", "time": _prayerTimes!.dhuhr},
          {"name": "العصر", "time": _prayerTimes!.asr},
          {"name": "المغرب", "time": _prayerTimes!.maghrib},
          {"name": "العشاء", "time": _prayerTimes!.isha},
        ]
      : [
          {"name": "Fajr", "time": _prayerTimes!.fajr},
          {"name": "Dhuhr", "time": _prayerTimes!.dhuhr},
          {"name": "Asr", "time": _prayerTimes!.asr},
          {"name": "Maghrib", "time": _prayerTimes!.maghrib},
          {"name": "Isha", "time": _prayerTimes!.isha},
        ];

  DateFormat format = DateFormat("HH:mm", "en");

  for (var prayer in prayers) {
    DateTime prayerTime = format.parse(prayer["time"]!);
    DateTime todayPrayerTime = DateTime(now.year, now.month, now.day, prayerTime.hour, prayerTime.minute);

    if (todayPrayerTime.isAfter(now)) {
      Duration difference = todayPrayerTime.difference(now);
      countdown = formatDuration(difference);
      nextPrayerName = prayer["name"]!;

      NotificationsController.instance.schduleNotification(
        id: prayers.indexOf(prayer),
        title: langServices.isArabic
            ? "الصلاة القادمة: ${prayer["name"]}"
            : "Upcoming Prayer: ${prayer["name"]}",
        body: langServices.isArabic
            ? "لقد حان وقت صلاة ${prayer["name"]}"
            : "It's time for ${prayer["name"]} prayer.",
        hour: prayerTime.hour,
        minute: prayerTime.minute,
      );
      return;
    }
  }

  // Schedule Fajr for the next day
  DateTime tomorrowFajr = format.parse(_prayerTimes!.fajr);
  DateTime nextFajr = DateTime(now.year, now.month, now.day + 1, tomorrowFajr.hour, tomorrowFajr.minute);
  Duration difference = nextFajr.difference(now);

  countdown = formatDuration(difference);
  nextPrayerName = langServices.isArabic ? "الفجر" : "Fajr";

  NotificationsController.instance.schduleNotification(
    id: prayers.length,
    title: langServices.isArabic ? "الصلاة القادمة: الفجر" : "Upcoming Prayer: Fajr",
    body: langServices.isArabic ? "لقد حان وقت صلاة الفجر" : "It's time for Fajr prayer.",
    hour: tomorrowFajr.hour,
    minute: tomorrowFajr.minute,
  );
}


  /// Formats Duration into HH:mm:ss format
  String formatDuration(Duration duration) {
    int hours = duration.inHours;
    int minutes = duration.inMinutes % 60;
    int seconds = duration.inSeconds % 60;
    return "${hours}h ${minutes}m ${seconds}s";
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }
}
