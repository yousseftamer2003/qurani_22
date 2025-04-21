import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quran/quran.dart' as quran;
import 'package:qurani_22/constants/colors.dart';
import 'package:qurani_22/generated/l10n.dart';
import 'package:qurani_22/json/quran_provider.dart';
import 'package:qurani_22/views/tabs_screen/screens/mushaf_page_view.dart';
import 'package:qurani_22/views/tabs_screen/widgets/custom_floating_bar.dart';


class QuranPage extends StatefulWidget {
  const QuranPage({super.key});

  @override
  State<QuranPage> createState() => _QuranPageState();
}

class _QuranPageState extends State<QuranPage> {
  @override
  void initState() {
    Provider.of<QuranController>(context, listen: false).loadSavedPage();
    Provider.of<QuranController>(context, listen: false).loadLastRead();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final quranProvider = Provider.of<QuranController>(context,listen: false);
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(S.of(context).Mushaf,style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: lightBlue),),
        actions: quranProvider.savedPage == null ? null : [
          TextButton(
          onPressed: (){
            if(quranProvider.savedPage != null){
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => MushafPageView(
                    pageNumber: Provider.of<QuranController>(context, listen: false).savedPage!,
                  ),
                ),
              );
            }else{
              showFloatingSnackBar(context, S.of(context).NoSavedPage);
            }
          }, 
          child: Text(S.of(context).GoToSavedPage,style: const TextStyle(color: lightBlue),))
        ],
      ),
      body: Consumer<QuranController>(
        builder: (context, quranProvider, _) {
          return Column(
          children: [
            if(quranProvider.lastReadPage != null)
            GestureDetector(
              onTap: (){
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MushafPageView(
                      pageNumber: quranProvider.lastReadPage!,
                    ),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const Icon(Icons.history, color: lightBlue),
                      const SizedBox(width: 16),
                      Text(S.of(context).continueUrLastRead,style: const TextStyle(color: lightBlue),),
                      const SizedBox(width: 16),
                    ],
                  ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                itemCount: 114,
                itemBuilder: (context, index) {
                  int surahNumber = index + 1;
                  return GestureDetector(
              onTap: () {
                int pageNumber = quran.getPageNumber(surahNumber, 1);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => MushafPageView(pageNumber: pageNumber),
                  ),
                );
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Number Badge
                    Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        border: Border.all(color: lightBlue, width: 2),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text(
                        "$surahNumber",
                        style: const TextStyle(
                          color: lightBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Surah Info
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // English + Verses
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                quran.getSurahName(surahNumber),
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              Text(
                                "${quran.getVerseCount(surahNumber)} ${S.of(context).verse}",
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          // Arabic + Revelation Place
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                quran.getPlaceOfRevelation(surahNumber),
                                style: const TextStyle(
                                  color: Colors.grey,
                                  fontSize: 13,
                                ),
                              ),
                              Text(
                                quran.getSurahNameArabic(surahNumber),
                                style: const TextStyle(
                                  fontFamily: 'Amiri', // Optional custom Arabic font
                                  fontSize: 18,
                                  color: lightBlue,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
                  );
                },
              ),
            ),
          ],
        );
        },
      ),
    );
  }
}
