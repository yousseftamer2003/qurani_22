import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/quran.dart';
import 'package:qurani_22/controllers/quran_provider.dart';
import 'package:qurani_22/views/tabs_screen/widgets/basmalah.dart';
import 'package:qurani_22/views/tabs_screen/widgets/header_widget.dart';
import 'package:qurani_22/views/tabs_screen/widgets/modal_sheets.dart'; // Add this import

class QuranTextWidget extends StatelessWidget {
  const QuranTextWidget({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final quranProvider = Provider.of<QuranController>(context, listen: false);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: SizedBox(
          width: double.infinity,
          child: RichText(
            textDirection: TextDirection.rtl,
            // textAlign: (index == 1 || index == 2)
            //     ? TextAlign.center
            //     : TextAlign.justify,
            softWrap: true,
            locale: const Locale("ar"),
            text: TextSpan(
              style: const TextStyle(
                color: Colors.black,
                fontSize: 23,
              ),
              children: getPageData(index).expand((e) {
                List<InlineSpan> spans = [];

                for (var i = e["start"]; i <= e["end"]; i++) {
                  if (i == 1) {
                    spans.add(WidgetSpan(
                      child: HeaderWidget(
                          e: e, jsonData: quranProvider.widgejsonData),
                    ));

                    if (index != 187 && index != 1 && e["surah"] != 9) {
                      spans.add(const WidgetSpan(child: Basmallah(index: 0)));
                    }

                    if (index == 187) {
                      spans.add(WidgetSpan(
                        child: Container(height: 10),
                      ));
                    }
                  }

                  spans.add(TextSpan(
                    recognizer: LongPressGestureRecognizer()
                      ..onLongPress = () {
                        showOptionsMenu(context, e["surah"], i);
                      },
                    text: getVerse(e["surah"], i,verseEndSymbol: true),
                    style: TextStyle(
                      color: Colors.black,
                      // height: (index == 1 || index == 2) ? 2.h : index == 591? 1.7.h : 1.7.h,
                      // fontSize: index == 1 || index == 2
                      //     ? 23.sp
                      //     : index == 145 || index == 201z
                      //         ? index == 532 || index == 533
                      //             ? 18.5.sp
                      //             : 17.6.sp
                      //         : 17.0.sp,
                      // backgroundColor: Colors.transparent,
                      fontFamily: 'Scheherazade New'
                    ),
                  ));
                }
                return spans;
              }).toList(),
            ),
          ),
        ),
      ),
    );
  }
}
