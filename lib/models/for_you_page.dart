
import 'package:qurani_22/models/ayat_model.dart';
import 'package:qurani_22/models/duaa_model.dart';
import 'package:qurani_22/models/hadith_model.dart';

class ForYouPage {
  final List<Aya> ayat;
  final List<Duaa> ad3ya;
  final List<Hadith> ahadith;

  ForYouPage({required this.ayat, required this.ad3ya, required this.ahadith});

  factory ForYouPage.fromJson(Map<String, dynamic> json) {
    return ForYouPage(
      ayat: (json['randomAyat'] as List).map((e) => Aya.fromJson(e)).toList(),
      ad3ya: (json['randomAd3ya'] as List).map((e) => Duaa.fromJson(e)).toList(),
      ahadith: (json['randomAhadeth'] as List).map((e) => Hadith.fromJson(e)).toList(),
    );
  }
}