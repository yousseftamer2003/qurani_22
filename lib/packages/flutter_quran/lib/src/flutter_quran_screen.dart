import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_quran/flutter_quran.dart';
import 'package:flutter_quran/src/app_bloc.dart';
import 'package:flutter_quran/src/controllers/bookmarks_controller.dart';
import 'package:flutter_quran/src/controllers/quran_controller.dart';
import 'package:flutter_quran/src/models/quran_page.dart';
import 'package:flutter_quran/src/widgets/bsmallah_widget.dart';
import 'package:flutter_quran/src/widgets/default_drawer.dart';
import 'package:flutter_quran/src/widgets/quran_line.dart';
import 'package:flutter_quran/src/widgets/surah_header_widget.dart';


class FlutterQuranScreen extends StatelessWidget {
  const FlutterQuranScreen(
      {this.showBottomWidget = true,
      this.useDefaultAppBar = true,
      this.bottomWidget,
      this.appBar,
      this.onPageChanged,
      this.onLongPress,
      super.key});

  final bool showBottomWidget;

  final bool useDefaultAppBar;

  final Widget? bottomWidget;

  final PreferredSizeWidget? appBar;

  final Function(int)? onPageChanged;

  final GestureLongPressCallback? onLongPress;

  @override
  Widget build(BuildContext context) {
    final deviceSize = MediaQuery.of(context).size;
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    return MultiBlocProvider(
      providers: AppBloc.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false,
        ),
        home: Directionality(
          textDirection: TextDirection.rtl,
          child: Scaffold(
            appBar: appBar ??
                (useDefaultAppBar
                    ? AppBar(
                        elevation: 0,
                        backgroundColor: Colors.transparent,
                        iconTheme: const IconThemeData(color: Colors.black),
                      )
                    : null),
            drawer: appBar == null && useDefaultAppBar
                ? const DefaultDrawer()
                : null,
            body: BlocBuilder<QuranCubit, List<QuranPage>>(
              builder: (ctx, pages) {
                return pages.isEmpty
                    ? const Center(child: CircularProgressIndicator())
                    : SafeArea(
                        child: PageView.builder(
                          itemCount: pages.length,
                          controller: AppBloc.quranCubit.pageController,
                          onPageChanged: (page) {
                            if (onPageChanged != null) onPageChanged!(page);
                            AppBloc.quranCubit.saveLastPage(page + 1);
                          },
                          pageSnapping: true,
                          itemBuilder: (ctx, index) {
                            List<String> newSurahs = [];
                            return Container(
                                height: deviceSize.height * 0.8,
                                padding: const EdgeInsets.all(16.0),
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: index == 0 || index == 1

                                          /// This is for first 2 pages of Quran: Al-Fatihah and Al-Baqarah
                                          ? Center(
                                              child: SingleChildScrollView(
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SurahHeaderWidget(pages[index]
                                                        .ayahs[0]
                                                        .surahNameAr),
                                                    if (index == 1)
                                                      BasmallahWidget(pages[index]
                                                          .ayahs[0].surahNumber),
                                                    ...pages[index]
                                                        .lines
                                                        .map((line) {
                                                      return BlocBuilder<
                                                          BookmarksCubit,
                                                          List<Bookmark>>(
                                                        builder:
                                                            (context, bookmarks) {
                                                          final bookmarksAyahs =
                                                              bookmarks
                                                                  .map((bookmark) =>
                                                                      bookmark
                                                                          .ayahId)
                                                                  .toList();
                                                          return Column(
                                                            children: [
                                                              SizedBox(
                                                                  width: deviceSize
                                                                          .width -
                                                                      32,
                                                                  child:
                                                                      QuranLine(
                                                                    line,
                                                                    bookmarksAyahs,
                                                                    bookmarks,
                                                                    boxFit: BoxFit
                                                                        .scaleDown,
                                                                  )),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }),
                                                  ],
                                                ),
                                              ),
                                            )

                                          /// Other Quran pages
                                          : LayoutBuilder(
                                              builder: (context, constraints) {
                                              return ListView(
                                                  physics: currentOrientation ==
                                                          Orientation.portrait
                                                      ? const NeverScrollableScrollPhysics()
                                                      : null,
                                                  children: [
                                                    ...pages[index]
                                                        .lines
                                                        .map((line) {
                                                      bool firstAyah = false;
                                                      if (line.ayahs[0]
                                                                  .ayahNumber ==
                                                              1 &&
                                                          !newSurahs.contains(line
                                                              .ayahs[0]
                                                              .surahNameAr)) {
                                                        newSurahs.add(line
                                                            .ayahs[0]
                                                            .surahNameAr);
                                                        firstAyah = true;
                                                      }
                                                      return BlocBuilder<
                                                          BookmarksCubit,
                                                          List<Bookmark>>(
                                                        builder:
                                                            (context, bookmarks) {
                                                          final bookmarksAyahs =
                                                              bookmarks
                                                                  .map((bookmark) =>
                                                                      bookmark.ayahId)
                                                                  .toList();
                                                          return Column(
                                                            children: [
                                                              if (firstAyah)
                                                                SurahHeaderWidget(line
                                                                    .ayahs[0]
                                                                    .surahNameAr),
                                                              if (firstAyah &&
                                                                  (line.ayahs[0]
                                                                          .surahNumber !=
                                                                      9))
                                                                BasmallahWidget(line.ayahs[0].surahNumber),
                                                              SizedBox(
                                                                width: deviceSize
                                                                        .width -
                                                                    30,
                                                                height: ((currentOrientation ==
                                                                                Orientation
                                                                                    .portrait
                                                                            ? constraints
                                                                                .maxHeight
                                                                            : deviceSize
                                                                                .width) -
                                                                        (pages[index]
                                                                                .numberOfNewSurahs *
                                                                            (line.ayahs[0].surahNumber != 9
                                                                                ? 110
                                                                                : 80))) *
                                                                    0.95 /
                                                                    pages[index]
                                                                        .lines
                                                                        .length,
                                                                child: QuranLine(
                                                                  onLongPress: onLongPress,
                                                                  line,
                                                                  bookmarksAyahs,
                                                                  bookmarks,
                                                                  boxFit: line
                                                                          .ayahs
                                                                          .last
                                                                          .centered
                                                                      ? BoxFit
                                                                          .scaleDown
                                                                      : BoxFit
                                                                          .fill,
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }),
                                                  ]);
                                            }),
                                    ),
                                    
                                  ],
                                ));
                          },
                        ),
                      );
              },
            ),
          ),
        ),
      ),
    );
  }
}
