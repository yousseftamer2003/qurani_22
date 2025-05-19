class StorageConstants {
  final String bookmarks = 'bookmarks';
  final String lastPage = 'last_page';
  final String isDownloadedCodeV2Fonts = 'isDownloadedCodeV2Fonts';
  final String fontsSelected = 'fontsSelected2';
  final String isTajweed = 'isTajweed';
  final String fontsDownloadedList = 'fontsDownloadedList';
  final String isBold = 'IS_BOLD';

  /// Tafsir & Translation Constants
  final String radioValue = 'TAFSEER_VAL';
  final String tafsirTableValue = 'TAFSEER_TABLE_VAL';
  final String translationLangCode = 'TRANS';
  final String translationValue = 'TRANSLATE_VALUE';
  final String isTafsir = 'IS_TAFSEER';
  final String fontSize = 'FONT_SIZE';

  ///Singleton factory
  static final StorageConstants _instance = StorageConstants._internal();

  factory StorageConstants() {
    return _instance;
  }

  StorageConstants._internal();
}
