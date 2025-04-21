// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:quran/quran.dart' as quran;
import 'package:qurani_22/constants/colors.dart';
import 'package:qurani_22/generated/l10n.dart';
import 'package:qurani_22/json/quran_provider.dart';
import 'package:qurani_22/views/tabs_screen/widgets/custom_floating_bar.dart';
import 'package:qurani_22/views/tabs_screen/widgets/quran_tafser_page.dart';
import 'package:qurani_22/views/tabs_screen/widgets/quran_text_widget.dart';

class MushafPageView extends StatefulWidget {
  const MushafPageView({super.key, required this.pageNumber});
  final int pageNumber;

  @override
  State<MushafPageView> createState() => _MushafPageViewState();
}

class _MushafPageViewState extends State<MushafPageView> {
  late PageController _pageController;
  int index = 0;
  List<dynamic> pageData = [];
  bool isTafseerPage = false;
  bool isSavedPage = false;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.pageNumber);
    index = widget.pageNumber;
    pageData = quran.getPageData(index);
    final quranProvider = Provider.of<QuranController>(context,listen: false);
    quranProvider.loadSavedPage();
    quranProvider.saveLastRead(widget.pageNumber);
    isSavedPage = index == quranProvider.savedPage;
  }
  void showGoToDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (context) {
      return Consumer<QuranNavigationController>(
        builder: (context, controller, child) {
          return AlertDialog(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            title: Text(S.of(context).Goto, textAlign: TextAlign.center),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(S.of(context).surah, style: const TextStyle(fontWeight: FontWeight.bold)),
                    Text(S.of(context).verse, style: const TextStyle(fontWeight: FontWeight.bold)),
                  ],
                ),
                const Divider(color: Colors.black),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButton<int>(
                        value: controller.selectedSurah,
                        isExpanded: true,
                        items: List.generate(114, (index) {
                          return DropdownMenuItem(
                            value: index + 1,
                            child: Text("${index + 1} - ${quran.getSurahNameArabic(index + 1)}"),
                          );
                        }),
                        onChanged: (value) {
                          if (value != null) {
                            controller.updateSurah(value);
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    SizedBox(
                      width: 50,
                      child: TextFormField(
                        initialValue: controller.selectedAyah.toString(),
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                          contentPadding: const EdgeInsets.symmetric(vertical: 8),
                        ),
                        onChanged: (value) {
                          controller.updateAyah(value);
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
            actions: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                  int page = quran.getPageNumber(controller.selectedSurah, controller.selectedAyah);
                  _pageController.jumpToPage(page);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: darkBlue,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: Text(S.of(context).go, style: const TextStyle(color: Colors.white)),
              ),
            ],
          );
        },
      );
    },
  );
}



  @override
  Widget build(BuildContext context) {
    final quranProvider = Provider.of<QuranController>(context,listen: false);

    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            if(isSavedPage) Positioned(
              top: 0,
              left: 75,
              child: SvgPicture.asset('assets/images/save.svg')),
            Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: PopupMenuButton<int>(
                        icon: const Icon(Icons.menu, color: Colors.black),
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onSelected: (value) {
                          if (value == 1) {
                            // Save Page
                            quranProvider.savePage(context,index);
                            setState(() {
                              isSavedPage = true;
                            });
                          } else if (value == 2) {
                            // Go to Marked Page
                            _pageController.jumpToPage(quranProvider.savedPage!);
                          } else if (value == 3) {
                            setState(() {
                              isTafseerPage = !isTafseerPage;
                            });
                          } else if (value == 4) {
                            showFloatingSnackBar(context, S.of(context).holdVerseToListen);
                          }
                        },
                        itemBuilder: (context) => [
                          PopupMenuItem(
                            value: 1,
                            child: Text(S.of(context).savePage, style: const TextStyle(color: Colors.black)),
                          ),
                          const PopupMenuDivider(),
                          PopupMenuItem(
                            value: 2,
                            child: Text(S.of(context).GoToSavedPage, style: const TextStyle(color: Colors.black)),
                          ),
                          const PopupMenuDivider(),
                          PopupMenuItem(
                            value: 3,
                            child: Text(S.of(context).pageForm, style: const TextStyle(color: Colors.black)),
                          ),
                          const PopupMenuDivider(),
                          PopupMenuItem(
                            value: 4,
                            child: Text(S.of(context).listenToQuran, style: const TextStyle(color: Colors.black)),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        Row(
                          children: [
                            Text('${S.of(context).juz} ${quran.getJuzNumber(pageData[0]['surah'], pageData[0]['start'])}',
                                style: const TextStyle(color: lightBlue)),
                            const SizedBox(width: 10),
                            Text('${S.of(context).page} $index', style: const TextStyle(color: lightBlue)),
                          ],
                        ),
                        Text(
                          '${S.of(context).surah} ${quran.getSurahNameArabic(pageData[0]['surah'])}',
                          style: const TextStyle(color: lightBlue),
                        )
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: InkWell(
                        onTap: () {
                          showGoToDialog(context);
                          log(index.toString());
                        },
                        child: SvgPicture.asset('assets/images/searchmushaf.svg',width: 25,),
                      ),
                    ),
                  ],
                ),
                const Divider(),
                Expanded(
                  child: PageView.builder(
                    reverse: true,
                    controller: _pageController,
                    itemCount: 605,
                    onPageChanged: (a) {
                      setState(() {
                        quranProvider.saveLastRead(a);
                        index = a;
                        pageData = quran.getPageData(index);
                        if(index == quranProvider.savedPage){
                          isSavedPage = true;
                        }else{
                          isSavedPage = false;
                        }
                      });
                    },
                    itemBuilder: (context, pageIndex) {
                      if (pageIndex == 0) {
                        return Container(
                          color: Colors.white,
                          child: Image.asset(
                            "assets/images/mushaf_blue.png",
                            fit: BoxFit.contain,
                          ),
                        );
                      }
                      return Container(
                        padding: const EdgeInsets.all(0.0),
                        child: isTafseerPage ? QuranTafserPage(index: pageIndex) : QuranTextWidget(index: pageIndex),
                      );
                    },
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
