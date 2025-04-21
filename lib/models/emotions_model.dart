

import 'package:qurani_22/models/ayat_model.dart';
import 'package:qurani_22/models/azkar_model.dart';
import 'package:qurani_22/models/duaa_model.dart';
import 'package:qurani_22/models/hadith_model.dart';

class Emotion {
  final String name;
  final String? nameAr;
  final int id;

  Emotion({
    required this.name,
    required this.id,
    this.nameAr,
  });

  factory Emotion.fromJson(Map<String, dynamic> json) {
    return Emotion(
      name: json['emotion_name'],
      id: json['id'],
      nameAr: json['emotion_name_ar'] ?? 'لا يوجد ترجمة',
    );
  }
}

class Emotions {
  final List<dynamic> emotions;

  Emotions({required this.emotions});

  factory Emotions.fromJson(Map<String, dynamic> json) {
    return Emotions(emotions: json['emotions']);
  }
}

class EmotionResult {
  final List<Duaa> duaas;
  final List<Aya> ayat;
  final List<Hadith> ahadith;
  final List<Zekr> azkar;

  EmotionResult(
      {required this.duaas,
      required this.ayat,
      required this.ahadith,
      required this.azkar});

  factory EmotionResult.fromJson(Map<String, dynamic> json) {
    return EmotionResult(
      duaas: List<Duaa>.from(json['ad3ya'].map((x) => Duaa.fromJson(x))),
      ayat: List<Aya>.from(json['ayat'].map((x) => Aya.fromJson(x))),
      ahadith:
          List<Hadith>.from(json['ahadeth'].map((x) => Hadith.fromJson(x))),
      azkar: List<Zekr>.from(json['azkar'].map((x) => Zekr.fromJson(x))),
    );
  }
}
