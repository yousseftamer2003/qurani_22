class Aya {
  final String ayaEn;
  final String ayaAr;
  final String status;
  final String? note;
  final int id;

  Aya(
      {required this.ayaEn,
      required this.ayaAr,
      required this.status,
      required this.note,
      required this.id});

  factory Aya.fromJson(Map<String, dynamic> json) {
    return Aya(
      ayaEn: json['ayat_en'],
      ayaAr: json['ayat_ar'],
      status: json['status'],
      note: json['note'],
      id: json['id'],
    );
  }
}

class Ayat{
  final List<dynamic> ayat;

  Ayat({required this.ayat});

  factory Ayat.fromJson(Map<String, dynamic> json) {
    return Ayat(
      ayat: json['ayat'],
    );
  }
}
