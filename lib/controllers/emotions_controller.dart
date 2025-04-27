// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:qurani_22/controllers/in_app_purchases_controller.dart';
import 'package:qurani_22/controllers/lang_controller.dart';
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
  String? noteResult;

  bool isEmotionLoaded = false;

  bool isLimitReached = false;

  final random = math.Random();

  void setSelectedEmotion(Emotion? emotion,bool isArabic) {
    if (emotion == null) {
      selectedEmotion = null;
      selectedEmotionId = null;
    } else {
      selectedEmotion = isArabic? emotion.nameAr : emotion.name;
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
  final iapProvider = Provider.of<InAppPurchasesController>(context, listen: false);
  final isPremium = iapProvider.isPremium;

  final prefs = await SharedPreferences.getInstance();
  final today = DateFormat('yyyy-MM-dd').format(DateTime.now());

  // Get stored values
  final storedDate = prefs.getString('lastGenerationDate');
  int count = prefs.getInt('generationCount') ?? 0;
  int limit = prefs.getInt('limit') ?? 0;

  if (storedDate != today) {
    await prefs.setInt('generationCount', 0);
    await prefs.setString('lastGenerationDate', today);
    count = 0;
  }

  if (!isPremium && count >= limit) {
    log('User has reached the daily generation limit: $limit');
    isLimitReached = true;
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
      setRandomResult(context);

      if (!isPremium) {
        // Only increment for non-premium users
        await prefs.setInt('generationCount', count + 1);
      }

      notifyListeners();
    } else {
      log('Failed to fetch emotions: ${response.statusCode}');
      log('Failed to fetch emotions: ${response.body}');
    }
  } catch (e) {
    log('Error fetching emotions result: $e');
  }
}


  void setRandomResult(BuildContext context) {
  final langServices = Provider.of<LangServices>(context, listen: false);

  if (_emotionResult == null) {
    result = null;
    noteResult = null;
    return;
  }

  List<Map<String, String>> allItems = [];

  for (var duaa in _emotionResult!.duaas) {
    allItems.add({
      'text': langServices.isArabic ? duaa.duaaAr : duaa.duaaEn,
      'note':  (duaa.note ?? ''),
    });
  }

  for (var aya in _emotionResult!.ayat) {
    allItems.add({
      'text': langServices.isArabic ? aya.ayaAr : aya.ayaEn,
      'note': (aya.note ?? ''),
    });
  }

  for (var hadith in _emotionResult!.ahadith) {
    allItems.add({
      'text': langServices.isArabic ? hadith.hadithAr : hadith.hadithEn,
      'note':  (hadith.note ?? ''),
    });
  }

  for (var zekr in _emotionResult!.azkar) {
    allItems.add({
      'text': langServices.isArabic ? zekr.zekrAr : zekr.zekrEn,
      'note': (zekr.note ?? ''),
    });
  }

  if (allItems.isNotEmpty) {
    int randomIndex = random.nextInt(allItems.length);
    result = allItems[randomIndex]['text'];
    noteResult = allItems[randomIndex]['note'];
    log('result: $result');
    log('note: $noteResult');
    notifyListeners();
  } else {
    result = null;
    noteResult = null;
  }
}



  void regenerateResult(BuildContext context) {
    setRandomResult(context);
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
