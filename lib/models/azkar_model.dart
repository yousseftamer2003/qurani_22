class Zekr {
  final String zekrEn;
  final String zekrAr;
  final int id;
  final String status;
  final String? note;
  int count;
  final int categoryId;

  Zekr(
      {required this.zekrEn,
      required this.zekrAr,
      required this.id,
      required this.status,
      required this.count,
      this.note,
      required this.categoryId});

  factory Zekr.fromJson(Map<String, dynamic> json) {
    return Zekr(
      zekrEn: json['azkar_en'],
      zekrAr: json['azkar_ar'],
      note: json['note'],
      id: json['id'],
      status: json['status'],
      count: json['azkar_count'],
      categoryId: json['category_id'],
    );
  }
}

class Azkar {
  final List<dynamic> azkar;

  Azkar({required this.azkar});

  factory Azkar.fromJson(Map<String, dynamic> json) {
    return Azkar(azkar: json['azkar']);
  }
}

class Category {
  final String name;
  final String? nameAr;
  final int id;

  Category({required this.name, required this.nameAr, required this.id});

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
        name: json['category_name'],
        nameAr: json['category_name_ar']?? 'فئة اذكار',
        id: json['id']);
  }
}

class Categories {
  final List<dynamic> categories;

  Categories({required this.categories});

  factory Categories.fromJson(Map<String, dynamic> json) {
    return Categories(categories: json['categories']);
  }
}
