
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:quran_library/core/utils/assets_path.dart';
import 'package:quran_library/data/models/ayah_model.dart';
import 'package:quran_library/data/models/styles_models/banner_style.dart';
import 'package:quran_library/data/models/styles_models/basmala_style.dart';
import 'package:quran_library/data/models/styles_models/bookmark.dart';
import 'package:quran_library/data/models/styles_models/surah_info_style.dart';
import 'package:quran_library/data/models/styles_models/surah_name_style.dart';
import 'package:quran_library/data/models/styles_models/surah_names_model.dart';
import 'package:quran_library/presentation/controllers/bookmark/bookmarks_ctrl.dart';
import 'package:quran_library/presentation/controllers/quran/quran_ctrl.dart';
import 'package:quran_library/presentation/controllers/quran/quran_getters.dart';
import 'package:quran_library/presentation/widgets/ayah_long_click_dialog.dart';
import 'package:quran_library/presentation/widgets/bsmallah_widget.dart';
import 'package:quran_library/presentation/widgets/custom_span.dart' show customSpan;
import 'package:quran_library/presentation/widgets/surah_header_widget.dart';

class QuranTextScale extends StatelessWidget {
  QuranTextScale({super.key, 
    required this.context,
    required this.pageIndex,
    this.bookmarkList,
    this.basmalaStyle,
    this.surahNumber,
    this.surahInfoStyle,
    this.surahNameStyle,
    this.bannerStyle,
    this.onSurahBannerPress,
    this.onAyahLongPress,
    this.onAyahPress,
    this.bookmarksColor,
    this.textColor,
    this.ayahIconColor,
    this.showAyahBookmarkedIcon = true,
    required this.bookmarks,
    required this.bookmarksAyahs,
    this.ayahSelectedBackgroundColor,
    this.languageCode,
    this.circularProgressWidget,
    required this.isDark,
    required this.ayahBookmarked,
    this.anotherMenuChild,
    this.anotherMenuChildOnTap,
  });

  final quranCtrl = QuranCtrl.instance;
  final BuildContext context;
  final int pageIndex;
  final List? bookmarkList;
  final BasmalaStyle? basmalaStyle;
  final int? surahNumber;
  final SurahInfoStyle? surahInfoStyle;
  final SurahNameStyle? surahNameStyle;
  final BannerStyle? bannerStyle;
  final List<int> ayahBookmarked;
  final Function(SurahNamesModel surah)? onSurahBannerPress;
  final Function(LongPressStartDetails details, AyahModel ayah)?
      onAyahLongPress;
  final VoidCallback? onAyahPress;
  final Color? bookmarksColor;
  final Color? textColor;
  final Color? ayahIconColor;
  final Map<int, List<BookmarkModel>> bookmarks;
  final List<int> bookmarksAyahs;
  final Color? ayahSelectedBackgroundColor;
  final String? languageCode;
  final Widget? circularProgressWidget;
  final bool isDark;
  final bool showAyahBookmarkedIcon;
  final Widget? anotherMenuChild;
  final void Function(AyahModel ayah)? anotherMenuChildOnTap;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<QuranCtrl>(
      builder: (quranCtrl) => GestureDetector(
        onTap: () {
          if (onAyahPress != null) {
            onAyahPress!();
          }
          quranCtrl.clearSelection();
          quranCtrl.state.overlayEntry?.remove();
          quranCtrl.state.overlayEntry = null;
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: quranCtrl.state.pages.isEmpty
              ? circularProgressWidget ?? CircularProgressIndicator.adaptive()
              : SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: List.generate(
                      quranCtrl
                          .getCurrentPageAyahsSeparatedForBasmalah(pageIndex)
                          .length,
                      (i) {
                        final ayahs =
                            quranCtrl.getCurrentPageAyahsSeparatedForBasmalah(
                                pageIndex)[i];
                        return Column(
                          children: [
                            ayahs.first.ayahNumber == 1 &&
                                    (!quranCtrl.topOfThePageIndex
                                            .contains(pageIndex) ||
                                        quranCtrl.state.fontsSelected2.value ==
                                            0)
                                ? SurahHeaderWidget(
                                    surahNumber ??
                                        quranCtrl
                                            .getSurahDataByAyah(ayahs.first)
                                            .surahNumber,
                                    bannerStyle: bannerStyle ??
                                        BannerStyle(
                                          isImage: false,
                                          bannerSvgPath: isDark
                                              ? AssetsPath().surahSvgBannerDark
                                              : AssetsPath().surahSvgBanner,
                                          bannerSvgHeight: 40.0,
                                          bannerSvgWidth: 150.0,
                                          bannerImagePath: '',
                                          bannerImageHeight: 50,
                                          bannerImageWidth: double.infinity,
                                        ),
                                    surahNameStyle: surahNameStyle ??
                                        SurahNameStyle(
                                          surahNameWidth: 70,
                                          surahNameHeight: 37,
                                          surahNameColor: isDark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                    surahInfoStyle: surahInfoStyle ??
                                        SurahInfoStyle(
                                          ayahCount: 'عدد الآيات',
                                          secondTabText: 'عن السورة',
                                          firstTabText: 'أسماء السورة',
                                          backgroundColor: isDark
                                              ? const Color(0xff1E1E1E)
                                              : const Color(0xfffaf7f3),
                                          closeIconColor: isDark
                                              ? Colors.white
                                              : Colors.black,
                                          indicatorColor: Colors.amber
                                              .withValues(alpha: .2),
                                          primaryColor: Colors.amber
                                              .withValues(alpha: .2),
                                          surahNameColor: isDark
                                              ? Colors.white
                                              : Colors.black,
                                          surahNumberColor: isDark
                                              ? Colors.white
                                              : Colors.black,
                                          textColor: isDark
                                              ? Colors.white
                                              : Colors.black,
                                          titleColor: isDark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                    onSurahBannerPress: onSurahBannerPress,
                                    isDark: isDark,
                                  )
                                : const SizedBox.shrink(),
                            quranCtrl
                                            .getSurahDataByAyah(ayahs.first)
                                            .surahNumber ==
                                        9 ||
                                    quranCtrl
                                            .getSurahDataByAyah(ayahs.first)
                                            .surahNumber ==
                                        1
                                ? const SizedBox.shrink()
                                : Padding(
                                    padding: const EdgeInsets.only(bottom: 8.0),
                                    child: ayahs.first.ayahNumber == 1
                                        ? BasmallahWidget(
                                            surahNumber: quranCtrl
                                                .getSurahDataByAyah(ayahs.first)
                                                .surahNumber,
                                            basmalaStyle: basmalaStyle ??
                                                BasmalaStyle(
                                                  basmalaColor: isDark
                                                      ? Colors.white
                                                      : Colors.black,
                                                  basmalaWidth: 160.0,
                                                  basmalaHeight: 45.0,
                                                ),
                                          )
                                        : const SizedBox.shrink(),
                                  ),
                            Obx(
                              () => RichText(
                                textDirection: TextDirection.rtl,
                                textAlign: TextAlign.center,
                                text: TextSpan(
                                  style: TextStyle(
                                    fontFamily: 'hafs',
                                    fontSize:
                                        20 * quranCtrl.state.scaleFactor.value,
                                    height: 1.7,
                                    // letterSpacing: 2,
                                    fontWeight: FontWeight.bold,
                                    color: textColor ??
                                        (isDark ? Colors.white : Colors.black),
                                    // shadows: [
                                    //   Shadow(
                                    //     blurRadius: 0.5,
                                    //     color: quranCtrl.state.isBold.value == 0
                                    //         ? Colors.black
                                    //         : Colors.transparent,
                                    //     offset: const Offset(0.5, 0.5),
                                    //   ),
                                    // ],
                                    package: 'quran_library',
                                  ),
                                  children:
                                      List.generate(ayahs.length, (ayahIndex) {
                                    final allBookmarks = bookmarks.values
                                        .expand((list) => list)
                                        .toList();
                                    return customSpan(
                                      text: ayahs[ayahIndex].text,
                                      isDark: isDark,
                                      pageIndex: pageIndex,
                                      isSelected: quranCtrl
                                          .selectedAyahsByUnequeNumber
                                          .contains(
                                              ayahs[ayahIndex].ayahUQNumber),
                                      fontSize: 20 *
                                          quranCtrl.state.scaleFactor.value,
                                      surahNum: quranCtrl
                                          .getCurrentSurahByPage(pageIndex)
                                          .surahNumber,
                                      ayahUQNum: ayahs[ayahIndex].ayahUQNumber,
                                      hasBookmark: ayahBookmarked.contains(
                                          ayahs[ayahIndex].ayahUQNumber),
                                      onLongPressStart: (details) {
                                        if (onAyahLongPress != null) {
                                          onAyahLongPress!(
                                              details, ayahs[ayahIndex]);
                                          quranCtrl.toggleAyahSelection(
                                              ayahs[ayahIndex].ayahUQNumber);
                                          quranCtrl.state.overlayEntry
                                              ?.remove();
                                          quranCtrl.state.overlayEntry = null;
                                        } else {
                                          final bookmarkId = allBookmarks.any(
                                                  (bookmark) =>
                                                      bookmark.ayahId ==
                                                      ayahs[ayahIndex]
                                                          .ayahUQNumber)
                                              ? allBookmarks
                                                  .firstWhere((bookmark) =>
                                                      bookmark.ayahId ==
                                                      ayahs[ayahIndex]
                                                          .ayahUQNumber)
                                                  .id
                                              : null;
                                          if (bookmarkId != null) {
                                            BookmarksCtrl.instance
                                                .removeBookmark(bookmarkId);
                                          } else {
                                            quranCtrl.toggleAyahSelection(
                                                ayahs[ayahIndex].ayahUQNumber);
                                            quranCtrl.state.overlayEntry
                                                ?.remove();
                                            quranCtrl.state.overlayEntry = null;

                                            // إنشاء OverlayEntry جديد
                                            final overlay = Overlay.of(context);
                                            final newOverlayEntry =
                                                OverlayEntry(
                                              builder: (context) =>
                                                  AyahLongClickDialog(
                                                context: context,
                                                isDark: isDark,
                                                ayah: ayahs[ayahIndex],
                                                position:
                                                    details.globalPosition,
                                                index: ayahIndex,
                                                pageIndex: pageIndex,
                                                anotherMenuChild:
                                                    anotherMenuChild,
                                                anotherMenuChildOnTap:
                                                    anotherMenuChildOnTap,
                                              ),
                                            );

                                            quranCtrl.state.overlayEntry =
                                                newOverlayEntry;

                                            // إدخال OverlayEntry في Overlay
                                            overlay.insert(newOverlayEntry);
                                          }
                                        }
                                      },
                                      bookmarkList: bookmarkList,
                                      textColor: textColor ??
                                          (isDark
                                              ? Colors.white
                                              : Colors.black),
                                      ayahIconColor: ayahIconColor ??
                                          (isDark
                                              ? Colors.white
                                              : Colors.black),
                                      showAyahBookmarkedIcon:
                                          showAyahBookmarkedIcon,
                                      bookmarks: bookmarks,
                                      bookmarksAyahs: bookmarksAyahs,
                                      bookmarksColor: bookmarksColor,
                                      ayahSelectedBackgroundColor:
                                          ayahSelectedBackgroundColor,
                                      ayahNumber: ayahs[ayahIndex].ayahNumber,
                                      languageCode: languageCode,
                                    );
                                  }),
                                ),
                              ),
                            ),
                            quranCtrl.downThePageIndex.contains(pageIndex) &&
                                    quranCtrl.state.fontsSelected2.value == 1
                                ? SurahHeaderWidget(
                                    surahNumber ??
                                        quranCtrl
                                                .getSurahDataByAyah(ayahs.first)
                                                .surahNumber +
                                            1,
                                    bannerStyle: bannerStyle ??
                                        BannerStyle(
                                          isImage: false,
                                          bannerSvgPath: isDark
                                              ? AssetsPath().surahSvgBannerDark
                                              : AssetsPath().surahSvgBanner,
                                          bannerSvgHeight: 40.0,
                                          bannerSvgWidth: 150.0,
                                          bannerImagePath: '',
                                          bannerImageHeight: 50,
                                          bannerImageWidth: double.infinity,
                                        ),
                                    surahNameStyle: surahNameStyle ??
                                        SurahNameStyle(
                                          surahNameWidth: 70,
                                          surahNameHeight: 37,
                                          surahNameColor: isDark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                    surahInfoStyle: surahInfoStyle ??
                                        SurahInfoStyle(
                                          ayahCount: 'عدد الآيات',
                                          secondTabText: 'عن السورة',
                                          firstTabText: 'أسماء السورة',
                                          backgroundColor: isDark
                                              ? const Color(0xff1E1E1E)
                                              : const Color(0xfffaf7f3),
                                          closeIconColor: isDark
                                              ? Colors.white
                                              : Colors.black,
                                          indicatorColor: Colors.amber
                                              .withValues(alpha: .2),
                                          primaryColor: Colors.amber
                                              .withValues(alpha: .2),
                                          surahNameColor: isDark
                                              ? Colors.white
                                              : Colors.black,
                                          surahNumberColor: isDark
                                              ? Colors.white
                                              : Colors.black,
                                          textColor: isDark
                                              ? Colors.white
                                              : Colors.black,
                                          titleColor: isDark
                                              ? Colors.white
                                              : Colors.black,
                                        ),
                                    onSurahBannerPress: onSurahBannerPress,
                                    isDark: isDark,
                                  )
                                : const SizedBox.shrink(),
                            // context.surahBannerLastPlace(pageIndex, i),
                          ],
                        );
                      },
                    ),
                  ),
                ),
        ),
      ),
    );
  }
}
