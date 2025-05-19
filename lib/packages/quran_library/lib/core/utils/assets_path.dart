
class AssetsPath {
  final surahSvgBanner = 'packages/quran_library/assets/svg/surah_banner.svg';
  final surahSvgBannerDark =
      'packages/quran_library/assets/svg/surah_banner_dark.svg';
  final besmAllah2 = 'packages/quran_library/assets/svg/besmAllah2.svg';
  final besmAllah = 'packages/quran_library/assets/svg/besmAllah.svg';
  final ayahBookmarked =
      'packages/quran_library/assets/svg/ayah_bookmarked.svg';
  final sajdaIcon = 'packages/quran_library/assets/svg/sajda_icon.svg';
  final suraNum = 'packages/quran_library/assets/svg/sora_num.svg';

  ///Singleton factory
  static final AssetsPath _instance = AssetsPath._internal();

  factory AssetsPath() {
    return _instance;
  }

  AssetsPath._internal();
}
