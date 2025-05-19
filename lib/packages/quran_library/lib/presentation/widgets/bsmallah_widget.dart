
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:quran_library/core/utils/assets_path.dart';
import 'package:quran_library/data/models/styles_models/basmala_style.dart';

/// A widget that displays the Basmallah (بِسْمِ ٱللَّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ).
///
/// This widget is typically used at the beginning of a text or a section
/// to invoke the name of Allah, the Most Gracious, the Most Merciful.
class BasmallahWidget extends StatelessWidget {
  /// A widget that displays the Basmallah (In the name of Allah) image.
  ///
  /// The image displayed depends on the [surahNumber]. If the [surahNumber] is 95 or 97,
  /// a specific Basmallah image is shown. Otherwise, a default Basmallah image is displayed.
  ///
  /// The appearance of the Basmallah image can be customized using the [basmalaStyle].
  ///
  /// Example usage:
  ///
  /// ```dart
  /// BasmallahWidget(
  ///   surahNumber: 1,
  ///   basmalaStyle: BasmalaStyle(
  ///     basmalaWidth: 200,
  ///     basmalaHeight: 50,
  ///     basmalaColor: Colors.black,
  ///   ),
  /// )
  /// ```
  ///
  /// The [BasmalaStyle] class allows you to specify the width, height, and color of the Basmallah image.
  const BasmallahWidget({
    super.key,
    required this.surahNumber,
    this.basmalaStyle,
  });

  /// The number of the Surah (chapter) in the Quran.
  ///
  /// This is used to identify and reference a specific Surah.
  ///
  /// Example:
  /// ```dart
  /// final int surahNumber = 1; // Al-Fatiha
  /// ```
  final int surahNumber;

  /// The style to be applied to the Basmala text.
  ///
  /// This property allows you to customize the appearance of the Basmala text
  /// by providing a [BasmalaStyle] object. If no style is provided, the default
  /// style will be used.
  ///
  final BasmalaStyle? basmalaStyle;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SvgPicture.asset(
        surahNumber == 95 || surahNumber == 97
            ? AssetsPath().besmAllah2
            : AssetsPath().besmAllah,
        width: basmalaStyle?.basmalaWidth ?? 150,
        height: basmalaStyle?.basmalaHeight ?? 40,
        colorFilter: ColorFilter.mode(
          basmalaStyle?.basmalaColor ?? Colors.black,
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
