class Duaa {
  final String duaaEn;
  final String duaaAr;
  final int id;
  final String status;
  final String? note;

  Duaa(
      {required this.duaaEn,
      required this.duaaAr,
      required this.id,
      required this.status,
      required this.note});

  factory Duaa.fromJson(Map<String, dynamic> json) {
    return Duaa(
        duaaEn: json['ad3ya_en'],
        duaaAr: json['ad3ya_ar'],
        id: json['id'],
        status: json['status'],
        note: json['note']);
  }
}

class Duaas {
  final List<dynamic> duaaList;

  Duaas({required this.duaaList});

  factory Duaas.fromJson(Map<String, dynamic> json) {
    return Duaas(duaaList: json['ad3ya']);
  }
}
