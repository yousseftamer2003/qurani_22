import 'package:flutter_quran/flutter_quran.dart';
import 'package:flutter_quran/src/repository/quran_repository.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  late QuranRepository quranRepository;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    quranRepository = QuranRepository();
  });

  test('Saving and getting Last page', () async {
    const pageToSave = 19;
    final res = await quranRepository.saveLastPage(pageToSave);
    expect(true, res);

    final page = quranRepository.getLastPage();
    expect(pageToSave, page);
  });

  test('Saving and getting Bookmarks', () async {
    final List<Bookmark> bookmarks = [
      Bookmark(id: 0, colorCode: 0xFF000000, name: "Black bookmark"),
      Bookmark(id: 1, colorCode: 0xFFFFFFFF, name: "White bookmark")
    ];
    final res = await quranRepository.saveBookmarks(bookmarks);
    expect(true, res);

    final savedBookmarks = await quranRepository.getBookmarks();
    expect(savedBookmarks.length, bookmarks.length);
    expect(savedBookmarks[0].id, bookmarks[0].id);
    expect(savedBookmarks[0].name, bookmarks[0].name);
    expect(savedBookmarks[0].colorCode, bookmarks[0].colorCode);
    expect(savedBookmarks[1].id, bookmarks[1].id);
    expect(savedBookmarks[1].name, bookmarks[1].name);
    expect(savedBookmarks[1].colorCode, bookmarks[1].colorCode);
  });
}
