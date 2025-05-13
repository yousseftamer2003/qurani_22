import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_quran/flutter_quran.dart';
import 'package:flutter_quran/src/utils/preferences/preferences.dart';

class QuranRepository {
  static const hafsPagesNumber = 604;

  Future<List<dynamic>> getQuran() async {
    String content = await rootBundle.loadString(
      'assets/json/quran_hafs.json',
    );
    return jsonDecode(content);
  }

  Future<bool> saveLastPage(int lastPage) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setInt(Preferences().lastPage, lastPage);
  }

  Future<int?> getLastPage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getInt(Preferences().lastPage);
  }

  Future<bool> saveBookmarks(List<Bookmark> bookmarks) async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarkList = bookmarks.map((b) => json.encode(b.toJson())).toList();
    return prefs.setStringList(Preferences().bookmarks, bookmarkList);
  }

  Future<List<Bookmark>> getBookmarks() async {
    final prefs = await SharedPreferences.getInstance();
    final bookmarkStrings = prefs.getStringList(Preferences().bookmarks) ?? [];
    return bookmarkStrings.map((s) => Bookmark.fromJson(json.decode(s))).toList();
  }
}
