import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:qurani_22/controllers/user_controller.dart';
import 'package:qurani_22/models/emotions_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class EmotionsController with ChangeNotifier {
  List<Emotion> _emotions = [];
  List<Emotion> get emotions => _emotions;

  EmotionResult? _emotionResult;
  EmotionResult? get emotionResult => _emotionResult;

  String? selectedEmotion;
  int? selectedEmotionId;

  String? result;

  bool isEmotionLoaded = false;

  final random = math.Random();

  void setSelectedEmotion(Emotion? emotion) {
    if (emotion == null) {
      selectedEmotion = null;
      selectedEmotionId = null;
    } else {
      selectedEmotion = emotion.name;
      selectedEmotionId = emotion.id;
    }
    notifyListeners();
  }

  void resetValues() {
    result = null;
    notifyListeners();
  }

  Future<void> getEmotions(BuildContext context) async {
    final userProvider = Provider.of<UserController>(context, listen: false);
    final uuid = userProvider.uuid;
    try {
      final response = await http.get(
        Uri.parse('https://talk-to-quran.com/api/user/getEmotions'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Device-UUID': uuid!,
        },
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        Emotions emotions = Emotions.fromJson(responseData);
        _emotions = emotions.emotions.map((e) => Emotion.fromJson(e)).toList();
        isEmotionLoaded = true;
        notifyListeners();
      } else {
        log('Failed to fetch emotions: ${response.statusCode}');
        log('Failed to fetch emotions: ${response.body}');
      }
    } catch (e) {
      log('Error fetching emotions: $e');
    }
  }

  Future<void> fetchEmotionResult(BuildContext context, int emotionId) async {
  final userProvider = Provider.of<UserController>(context, listen: false);
  final uuid = userProvider.uuid;

  final prefs = await SharedPreferences.getInstance();
  final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

  // Get stored values
  final storedDate = prefs.getString('lastGenerationDate');
  int count = prefs.getInt('generationCount') ?? 0;
  int limit = prefs.getInt('limit') ?? 0;

  // If the stored date is different from today, reset the count
  if (storedDate != today) {
    await prefs.setInt('generationCount', 0);
    await prefs.setString('lastGenerationDate', today);
    count = 0;
  }

  // If the count has reached the limit, don't proceed
  if (count >= limit) {
    log('User has reached the daily generation limit: $limit');
    // You could also show a dialog or toast here if needed
    return;
  }

  try {
    final response = await http.get(
      Uri.parse('https://talk-to-quran.com/api/user/getemotionthings/$emotionId'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Device-UUID': uuid!,
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      EmotionResult emotionResult = EmotionResult.fromJson(responseData['data']);
      _emotionResult = emotionResult;
      setRandomResult();

      // Increment and store the new count
      await prefs.setInt('generationCount', count + 1);

      notifyListeners();
    } else {
      log('Failed to fetch emotions: ${response.statusCode}');
      log('Failed to fetch emotions: ${response.body}');
    }
  } catch (e) {
    log('Error fetching emotions result: $e');
  }
}

  void setRandomResult() {
    if (_emotionResult == null) {
      result = null;
      return;
    }

    List<String> allItems = [];

    for (var duaa in _emotionResult!.duaas) {
      allItems.add(duaa.duaaEn);
    }

    for (var aya in _emotionResult!.ayat) {
      allItems.add(aya.ayaEn);
    }

    for (var hadith in _emotionResult!.ahadith) {
      allItems.add(hadith.hadithEn);
    }

    for (var zekr in _emotionResult!.azkar) {
      allItems.add(zekr.zekrEn);
    }

    if (allItems.isNotEmpty) {
      int randomIndex = random.nextInt(allItems.length);
      result = allItems[randomIndex];
      log('result: $result');
      notifyListeners();
    } else {
      result = null;
    }
  }

  void regenerateResult() {
    setRandomResult();
  }

  Future<void> getEmotionsLimit(BuildContext context) async {
  final userProvider = Provider.of<UserController>(context, listen: false);
  final uuid = userProvider.uuid;

  try {
    final response = await http.get(
      Uri.parse('https://talk-to-quran.com/api/user/limit'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Device-UUID': uuid!,
      },
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      if (responseData is List && responseData.isNotEmpty) {
        final firstItem = responseData.first;
        if (firstItem is Map && firstItem.containsKey("usres_limit")) {
          int limit = firstItem["usres_limit"];
          final prefs = await SharedPreferences.getInstance();
          await prefs.setInt('limit', limit);
        } else {
          log("Invalid data format or missing key.");
        }
      } else {
        log("Empty or invalid response.");
      }

      notifyListeners();
    } else {
      log('Failed to fetch emotions limit: ${response.statusCode}');
      log('Failed to fetch emotions limit: ${response.body}');
    }
  } catch (e) {
    log('Error fetching emotions limit: $e');
  }
}

}
