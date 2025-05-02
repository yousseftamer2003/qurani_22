import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LangServices with ChangeNotifier {
  String _selectedLang = 'ar';
  Locale _locale = const Locale('ar'); 

  Locale get locale => _locale;
  String get selectedLang => _selectedLang;

  bool get isArabic => _selectedLang == 'ar';

  Future<void> loadLangFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _selectedLang = prefs.getString('selectedLang') ?? 'ar';
    _locale = Locale(_selectedLang);
    notifyListeners();
  }

  Future<void> selectLang(String langCode) async {
    _selectedLang = langCode;
    _locale = Locale(langCode);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('selectedLang', langCode);
    notifyListeners(); 
  }
}