

import 'package:flutter/material.dart';
import 'package:flutter_quran/flutter_quran.dart';
import 'package:flutter_quran/src/models/quran_page.dart';
import 'package:flutter_quran/src/widgets/model_sheets_2.dart';

class QuranLine extends StatelessWidget {
  const QuranLine(this.line, this.bookmarksAyahs, this.bookmarks,
      {super.key, this.boxFit = BoxFit.fill, this.onLongPress});

  final Line line;
  final List<int> bookmarksAyahs;
  final List<Bookmark> bookmarks;
  final BoxFit boxFit;
  final GestureLongPressCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    return FittedBox(
        fit: boxFit,
        child: RichText(
            text: TextSpan(
          children: line.ayahs.reversed.map((ayah) {
            return WidgetSpan(
              child: GestureDetector(
                onLongPress: (){
                  showOptionsMenu(context,ayah.surahNumber,ayah.ayahNumber);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: bookmarksAyahs.contains(ayah.id)
                        ? Color(bookmarks[bookmarksAyahs.indexOf(ayah.id)]
                                .colorCode)
                            .withValues(alpha: 0.7)
                        : null,
                  ),
                  child: Text(
                    ayah.ayah,
                    style: FlutterQuran().hafsStyle,
                  ),
                ),
              ),
            );
          }).toList(),
          style: FlutterQuran().hafsStyle,
        )));
  }
}
