import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui' as ui;

class LangServices with ChangeNotifier {
  String _selectedLang = 'ar';
  Locale _locale = const Locale('ar'); 

  Locale get locale => _locale;
  String get selectedLang => _selectedLang;

  bool get isArabic => _selectedLang == 'ar';

  String _getSystemLanguage() {
    final systemLocale = ui.window.locale;
    String systemLangCode = systemLocale.languageCode;
    
    const supportedLanguages = ['ar', 'en'];
    
    if (supportedLanguages.contains(systemLangCode)) {
      return systemLangCode;
    }
    
    return 'ar'; 
  }

  Future<void> loadLangFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    
    if (prefs.containsKey('selectedLang')) {
      _selectedLang = prefs.getString('selectedLang') ?? 'ar';
    } else {
      _selectedLang = _getSystemLanguage();
      await prefs.setString('selectedLang', _selectedLang);
    }
    
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