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
            final ayahText = ayah.ayah.trim();
            final match = RegExp(r'([\u0660-\u0669]+)$').firstMatch(ayahText);

            String displayText;

            if (match != null) {
              // final number = match.group(1)!;
              // displayText = ayahText.replaceFirst(RegExp(r'([\u0660-\u0669]+)$'), '﴿$number﴾');
              displayText = ayahText;
            } else {
              displayText = ayahText;
            }

            return WidgetSpan(
              child: GestureDetector(
                onLongPress: () {
                  showOptionsMenu(context, ayah.surahNumber, ayah.ayahNumber);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4.0),
                    color: bookmarksAyahs.contains(ayah.id)
                        ? Color(bookmarks[bookmarksAyahs.indexOf(ayah.id)].colorCode).withOpacity(0.7): null,
                  ),
                  child: Text(
                    ayah.codev2!,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.55,
                      fontFamily: "QCF_P${ayah.page.toString().padLeft(3, '0')}",
                      height: 1.2,
                    ),
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
