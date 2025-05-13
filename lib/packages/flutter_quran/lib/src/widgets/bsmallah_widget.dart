
import 'package:flutter/material.dart';
import 'package:flutter_quran/flutter_quran.dart';

class BasmallahWidget extends StatelessWidget {
  const BasmallahWidget(this.surahNumber, {super.key});
  final int surahNumber;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        surahNumber == 97 || surahNumber == 95
            ? "بِّسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ"
            : 'بِسۡمِ ٱللَّهِ ٱلرَّحۡمَٰنِ ٱلرَّحِيمِ',
        style: FlutterQuran().hafsStyle,
      ),
    );
  }
}
