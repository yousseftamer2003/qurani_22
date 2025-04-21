import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:quran/quran.dart';
import 'package:qurani_22/json/quran_provider.dart';
import 'package:qurani_22/views/tabs_screen/widgets/basmalah.dart';
import 'package:qurani_22/views/tabs_screen/widgets/header_widget.dart';

class QuranTafserPage extends StatelessWidget {
  const QuranTafserPage({super.key, required this.index});

  final int index;

  @override
  Widget build(BuildContext context) {
    final quranProvider = Provider.of<QuranController>(context, listen: false);

    return Directionality(
      textDirection: TextDirection.rtl,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: getPageData(index).expand((e) {
              List<Widget> verseWidgets = [];

              if (e["start"] == 1) {
                verseWidgets.add(HeaderWidget(
                  e: e,
                  jsonData: quranProvider.widgejsonData,
                ));

                if (index != 187 && index != 1 && e["surah"] != 9) {
                  verseWidgets.add(const Basmallah(index: 0));
                }

                if (index == 187) {
                  verseWidgets.add(Container(height: 10));
                }
              }

              for (var i = e["start"]; i <= e["end"]; i++) {
                quranProvider.fetchTafsir(surahnum: e["surah"], ayahnum: i);

                verseWidgets.add(
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Text(
                              getVerse(e["surah"], i),
                              textAlign: TextAlign.justify,
                              style: TextStyle(
                                color: Colors.black,
                                fontFamily: "QCF_P${index.toString().padLeft(3, "0")}",
                                fontSize: 20.sp,
                                height: 2.h,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(6),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.blueAccent, width: 1.5),
                            ),
                            child: Text(
                              i.toString(),
                              style: TextStyle(
                                color: Colors.blueAccent,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      /// **Tafsir Section**
                      Consumer<QuranController>(
                        builder: (context, provider, child) {
                          String tafsir = provider.getTafsir(e["surah"], i);
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: tafsir.isNotEmpty
                                ? Text(
                                    tafsir,
                                    textAlign: TextAlign.justify,
                                    style: TextStyle(
                                      color: Colors.green[700],
                                      fontSize: 14.sp,
                                    
                                      height: 1.8,
                                    ),
                                  )
                                : const CircularProgressIndicator(), // Show loader while fetching
                          );
                        },
                      ),

                      Divider(thickness: 1, color: Colors.grey[300]),
                    ],
                  ),
                );
              }
              return verseWidgets;
            }).toList(),
          ),
        ),
      ),
    );
  }
}
