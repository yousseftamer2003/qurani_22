
import 'dart:convert';
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:quran_library/core/utils/storage_constants.dart';
import 'package:quran_library/data/models/styles_models/bookmark.dart';

/// A repository class for managing Quran-related data.
///
/// This class provides methods to fetch, store, and manipulate
/// data related to the Quran. It acts as an intermediary between
/// the data sources (such as APIs or local databases) and the
/// application logic, ensuring that the data is properly handled
/// and formatted before being used in the app.
class QuranRepository {
  ///Quran pages number
  static const hafsPagesNumber = 604;

  /// Fetches the Quran data.
  ///
  /// This method retrieves a list of Quran data asynchronously.
  ///
  /// Returns a [Future] that completes with a [List] of dynamic objects
  /// representing the Quran data.
  ///
  /// Throws an [Exception] if the data retrieval fails.
  Future<List<dynamic>> getQuran() async {
    String content = await rootBundle
        .loadString('packages/quran_library/assets/jsons/quran_hafs.json');
    return jsonDecode(content);
  }

  /// Fetches the list of Surahs from the data source.
  ///
  /// This method returns a [Future] that completes with a [Map] containing
  /// the Surah data. The keys in the map are the Surah identifiers, and the
  /// values are the corresponding Surah details.
  ///
  /// Returns:
  ///   A [Future] that completes with a [Map<String, dynamic>] containing
  ///   the Surah data.
  ///
  /// Throws:
  ///   An exception if there is an error while fetching the Surah data.
  Future<Map<String, dynamic>> getSurahs() async {
    String content = await rootBundle
        .loadString('packages/quran_library/assets/jsons/surahs_name.json');
    return jsonDecode(content);
  }

  /// Fetches a list of Quran fonts.
  ///
  /// This method retrieves a list of available fonts for the Quran.
  ///
  /// Returns a [Future] that completes with a [List] of dynamic objects
  /// representing the fonts.
  ///
  /// Example usage:
  /// ```dart
  /// List<dynamic> fonts = await getFontsQuran();
  /// ```
  Future<List<dynamic>> getFontsQuran() async {
    String jsonString = await rootBundle
        .loadString('packages/quran_library/assets/jsons/quranV2.json');
    Map<String, dynamic> jsonResponse = jsonDecode(jsonString);
    List<dynamic> surahsJson = jsonResponse['data']['surahs'];
    return surahsJson;
  }

  /// Saves the last page number.
  ///
  /// This method takes an integer [lastPage] which represents the last page
  /// number read by the user and saves it for future reference.
  ///
  /// [lastPage]: The page number to be saved.
  saveLastPage(int lastPage) =>
      GetStorage().write(StorageConstants().lastPage, lastPage);

  /// Retrieves the last page number from the storage.
  ///
  /// This method reads the last page number stored in the local storage
  /// using the `GetStorage` package and returns it as an integer. If the
  /// value is not found, it returns `null`.
  ///
  /// Returns:
  ///   - `int?`: The last page number if it exists in the storage, otherwise `null`.
  int? getLastPage() => GetStorage().read(StorageConstants().lastPage);

  /// Saves the list of bookmarks to persistent storage.
  ///
  /// This method uses the `GetStorage` package to write the provided list of
  /// [BookmarkModel] instances to storage. The bookmarks can be retrieved later
  /// using the appropriate read method from `GetStorage`.
  ///
  /// [bookmarks] - A list of [BookmarkModel] instances to be saved.
  saveBookmarks(List<BookmarkModel> bookmarks) => GetStorage().write(
        StorageConstants().bookmarks,
        bookmarks.map((bookmark) => jsonEncode(bookmark.toJson())).toList(),
      );

  /// Retrieves a list of bookmarks.
  ///
  /// This method fetches all the bookmarks stored in the repository.
  ///
  /// Returns:
  ///   A list of [BookmarkModel] objects representing the bookmarks.
  List<BookmarkModel> getBookmarks() {
    final savedBookmarks = GetStorage().read(StorageConstants().bookmarks);

    if (savedBookmarks == null || savedBookmarks is! List) {
      return []; // Return an empty list if data is null or not a list
    }

    try {
      return savedBookmarks.map((bookmark) {
        if (bookmark is Map<dynamic, dynamic>) {
          // Cast to Map<String, dynamic> before passing to fromJson
          return BookmarkModel.fromJson(Map<String, dynamic>.from(bookmark));
        } else if (bookmark is String) {
          // Decode JSON string and cast to Map<String, dynamic>
          return BookmarkModel.fromJson(
            Map<String, dynamic>.from(jsonDecode(bookmark)),
          );
        } else {
          throw Exception("Unexpected bookmark type: ${bookmark.runtimeType}");
        }
      }).toList();
    } catch (e) {
      // Log the error and return an empty list in case of issues
      log("Error parsing bookmarks: $e");
      return [];
    }
  }
}
