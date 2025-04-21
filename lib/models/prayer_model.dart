class PrayerTimes {
  final String fajr;
  final String sunrise;
  final String dhuhr;
  final String asr;
  final String maghrib;
  final String isha;

  PrayerTimes(
      {required this.fajr,
      required this.sunrise,
      required this.dhuhr,
      required this.asr,
      required this.maghrib,
      required this.isha});

  factory PrayerTimes.fromJson(Map<String, dynamic> json) {
    return PrayerTimes(
      fajr: json['Fajr'] ?? 'N/A',
      sunrise: json['Sunrise'] ?? 'N/A',
      dhuhr: json['Dhuhr']?? 'N/A',
      asr: json['Asr']?? 'N/A',
      maghrib: json['Maghrib']?? 'N/A',
      isha: json['Isha']?? 'N/A',
    );
  }
}

class HijriDate {
  final String day;
  final String monthNameEn;
  final String monthNameAr;
  final String monthNum;
  final String yearAbbreviated;
  final String year;
  final String weekDayEn;
  final String weekDayAr;

  HijriDate(
      {required this.day,
      required this.monthNameEn,
      required this.monthNameAr,
      required this.monthNum,
      required this.yearAbbreviated,
      required this.year,
      required this.weekDayEn,
      required this.weekDayAr});

  factory HijriDate.fromJson(Map<String, dynamic> json) {
    return HijriDate(
      day: json['day']?? 'N/A',
      monthNameEn: json['month']['en']?? 'N/A',
      monthNameAr: json['month']['ar']?? 'N/A',
      monthNum: json['month_number']?? 'N/A',
      yearAbbreviated: json['designation']['abbreviated']?? 'N/A',
      year: json['year']?? 'N/A',
      weekDayEn: json['weekday']['en']?? 'N/A',
      weekDayAr: json['weekday']['ar']?? 'N/A',
    );
  }
}
