
import 'package:flutter_quran/flutter_quran.dart';

class Surah {
  final int index, startPage;
  int endPage;
  final String nameEn, nameAr;
  List<Ayah> ayahs;

  Surah({
    required this.index,
    required this.startPage,
    required this.endPage,
    required this.nameEn,
    required this.nameAr,
    required this.ayahs,
  });

  factory Surah.fromJson(Map<String, dynamic> json) => Surah(
        index: json['index'],
        startPage: json['start_page'],
        endPage: json['end_page'],
        nameEn: json['name_en'],
        nameAr: json['name_ar'],
        ayahs: json['ayahs'].map<Ayah>((ayah) => Ayah.fromJson(ayah)).toList(),
      );

  Map<String, dynamic> toJson() => {
        "index": index,
        "start_page": startPage,
        "end_page": endPage,
        "name_en": nameEn,
        "name_ar": nameAr,
        "ayahs": ayahs.map((ayah) => ayah.toJson()).toList(),
      };
}
