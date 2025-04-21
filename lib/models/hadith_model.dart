class Hadith {
  final int id;
  final String hadithEn;
  final String hadithAr;
  final String status;
  final String? note;

  Hadith(
      {required this.id,
      required this.hadithEn,
      required this.hadithAr,
      required this.status,
      required this.note});

  factory Hadith.fromJson(Map<String, dynamic> json) {
    return Hadith(
      id: json['id'],
      hadithEn: json['ahadeth_en'],
      hadithAr: json['ahadeth_ar'],
      status: json['status'],
      note: json['note'],
    );
  }
}

class Ahadith {
  final List<dynamic> ahadiths;

  Ahadith({required this.ahadiths});

  factory Ahadith.fromJson(Map<String, dynamic> json) {
    return Ahadith(ahadiths: json['ahadeth']);
  }
}
