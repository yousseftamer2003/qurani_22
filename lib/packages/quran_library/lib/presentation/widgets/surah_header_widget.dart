
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran_library/core/extensions/surah_info_extension.dart';
import 'package:quran_library/core/utils/assets_path.dart';
import 'package:quran_library/data/models/styles_models/banner_style.dart';
import 'package:quran_library/data/models/styles_models/surah_info_style.dart';
import 'package:quran_library/data/models/styles_models/surah_name_style.dart';
import 'package:quran_library/data/models/styles_models/surah_names_model.dart';
import 'package:quran_library/presentation/controllers/quran/quran_ctrl.dart';

class SurahHeaderWidget extends StatelessWidget {
  SurahHeaderWidget(
    this.surahNumber, {
    super.key,
    this.bannerStyle,
    this.surahNameStyle,
    this.onSurahBannerPress,
    this.surahInfoStyle,
    required this.isDark,
  });

  final int surahNumber;
  final BannerStyle? bannerStyle;
  final SurahNameStyle? surahNameStyle;
  final void Function(SurahNamesModel surah)? onSurahBannerPress;
  final SurahInfoStyle? surahInfoStyle;
  final bool isDark;

  final quranCtrl = QuranCtrl.instance;

  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.sizeOf(context);
    if (bannerStyle?.isImage ?? false) {
      return GestureDetector(
        onTap: () {
          if (onSurahBannerPress != null) {
            onSurahBannerPress!(quranCtrl.surahsList[surahNumber - 1]);
          } else {
            surahInfoBottomSheetWidget(context, surahNumber - 1,
                surahStyle: surahInfoStyle!,
                deviceWidth: deviceWidth,
                isDark: isDark);
          }
        },
        child: Container(
          height: bannerStyle?.bannerImageHeight ?? 50.0,
          width: bannerStyle?.bannerImageWidth ?? double.infinity,
          margin: EdgeInsets.symmetric(
              vertical: quranCtrl.state.fontsSelected2.value == 1 ? 0.0 : 8.0),
          padding: const EdgeInsets.symmetric(vertical: 0.0),
          decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(bannerStyle!.bannerImagePath!),
                fit: BoxFit.fill),
          ),
          alignment: Alignment.center,
          child: SvgPicture.asset(
            'packages/quran_library/assets/svg/surah_name/00$surahNumber.svg',
            width: surahNameStyle?.surahNameWidth ?? 70,
            height: surahNameStyle?.surahNameHeight ?? 37,
            colorFilter: ColorFilter.mode(
                surahNameStyle?.surahNameColor ??
                    (isDark ? Colors.white : Colors.black),
                BlendMode.srcIn),
          ),
        ),
      );
    } else {
      return Center(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: quranCtrl.state.fontsSelected2.value == 1 ? 0.0 : 8.0),
          child: GestureDetector(
            onTap: () {
              if (onSurahBannerPress != null) {
                onSurahBannerPress!(quranCtrl.surahsList[surahNumber - 1]);
              } else {
                surahInfoBottomSheetWidget(context, surahNumber - 1,
                    surahStyle: surahInfoStyle!,
                    deviceWidth: deviceWidth,
                    isDark: isDark);
              }
            },
            child: Stack(
              alignment: Alignment.center,
              children: [
                SvgPicture.asset(
                  bannerStyle?.bannerSvgPath ??
                      (isDark
                          ? AssetsPath().surahSvgBannerDark
                          : AssetsPath().surahSvgBanner),
                  width: bannerStyle?.bannerSvgWidth ?? 150.0,
                  height: bannerStyle?.bannerSvgHeight ?? 40.0,
                ),
                SvgPicture.asset(
                  'packages/quran_library/assets/svg/surah_name/00$surahNumber.svg',
                  width: surahNameStyle?.surahNameWidth ?? 70,
                  height: surahNameStyle?.surahNameHeight ?? 37,
                  colorFilter: ColorFilter.mode(
                      surahNameStyle?.surahNameColor ??
                          (isDark ? Colors.white : Colors.black),
                      BlendMode.srcIn),
                ),
              ],
            ),
          ),
        ),
      );
    }
  }
}
