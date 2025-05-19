// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:qurani_22/generated/l10n.dart';
import 'package:qurani_22/views/tabs_screen/widgets/custom_floating_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';

class QuranController with ChangeNotifier {
  var widgejsonData;
  Map<String, String> _tafsirs = {};

  int? savedPage;
  int? lastReadPage;

  int get getSavedPage => savedPage?? 0;

  String getTafsir(int surah, int ayah) {
    return _tafsirs['$surah:$ayah'] ?? ''; 
  }


  Future<void> loadJsonAsset() async {
    final String jsonString =
        await rootBundle.loadString('assets/json/surahs.json');
    widgejsonData = jsonDecode(jsonString);
    notifyListeners();
  }

  Future<void> fetchTafsir({required int surahnum, required int ayahnum}) async {
    String key = '$surahnum:$ayahnum';
    if (_tafsirs.containsKey(key)) return;

    try {
      final response = await http.get(
        Uri.parse('http://api.quran-tafseer.com/tafseer/1/$surahnum/$ayahnum'),
      );

      if (response.statusCode == 200) {
        final utf8Response = utf8.decode(response.bodyBytes);
      final responseData = jsonDecode(utf8Response);
        _tafsirs[key] = responseData['text'] ?? 'No Tafsir available';
        notifyListeners();
      } else {
        log('Failed to fetch tafsir: ${response.statusCode}');
      }
    } catch (e) {
      log('Error fetching tafsir: $e');
    }
  }

  Future<void> savePage(BuildContext context,int pageNum) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('savedPage', pageNum);
      savedPage = pageNum;
      notifyListeners();
    showFloatingSnackBar(context, S.of(context).savedSuccessfully);
  }

  Future<void> saveLastRead(int pageNum) async{
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('lastReadPage', pageNum);
    log('saved: $pageNum');
  }

  Future<void> loadLastRead() async{
    final prefs = await SharedPreferences.getInstance();
    lastReadPage = prefs.getInt('lastReadPage');
    log('loaded: $lastReadPage');
    notifyListeners();
  }

  
  Future<void> loadSavedPage() async {
    final prefs = await SharedPreferences.getInstance();
      savedPage = prefs.getInt('savedPage');
      notifyListeners();
  }

}


class QuranNavigationController extends ChangeNotifier {
  int selectedSurah = 1;
  int selectedAyah = 1;

  void updateSurah(int newSurah) {
    selectedSurah = newSurah;
    notifyListeners(); // Notify UI to rebuild
  }

  void updateAyah(String newAyah) {
    selectedAyah = int.tryParse(newAyah) ?? 1;
    notifyListeners();
  }
}

