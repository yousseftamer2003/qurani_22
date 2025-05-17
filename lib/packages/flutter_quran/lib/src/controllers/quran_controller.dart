import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_quran/flutter_quran.dart';
import 'package:flutter_quran/src/models/quran_page.dart';
import 'package:flutter_quran/src/models/surah.dart';
import 'package:flutter_quran/src/repository/quran_repository.dart';


class QuranCubit extends Cubit<List<QuranPage>> {
  QuranCubit({QuranRepository? quranRepository})
      : _quranRepository = quranRepository ?? QuranRepository(),
        super([]);

  final QuranRepository _quranRepository;

  List<QuranPage> staticPages = [];
  List<int> quranStops = [];
  List<int> surahsStart = [];
  List<Surah> surahs = [];
  final List<Ayah> ayahs = [];
  int lastPage = 1;
  int? initialPage;

  PageController _pageController = PageController();

  Future<void> loadQuran({quranPages = QuranRepository.hafsPagesNumber}) async {
    lastPage = await _quranRepository.getLastPage() ?? 1;
    if (lastPage != 0) {
      _pageController = PageController(initialPage: lastPage - 1);
    }
    if (staticPages.isEmpty || quranPages != staticPages.length) {
      staticPages = List.generate(quranPages,
          (index) => QuranPage(pageNumber: index + 1, ayahs: [], lines: []));
      final quranJson = await _quranRepository.getQuran();
      int hizb = 1;
      int surahsIndex = 1;
      List<Ayah> thisSurahAyahs = [];
      for (int i = 0; i < quranJson.length; i++) {
        final ayah = Ayah.fromJson(quranJson[i]);
        if (ayah.surahNumber != surahsIndex) {
          surahs.last.endPage = ayahs.last.page;
          surahs.last.ayahs = thisSurahAyahs;
          surahsIndex = ayah.surahNumber;
          thisSurahAyahs = [];
        }
        ayahs.add(ayah);
        thisSurahAyahs.add(ayah);
        staticPages[ayah.page - 1].ayahs.add(ayah);
        if (ayah.ayah.contains('۞')) {
          staticPages[ayah.page - 1].hizb = hizb++;
          quranStops.add(ayah.page);
        }
        if (ayah.ayah.contains('۩')) {
          staticPages[ayah.page - 1].hasSajda = true;
        }
        if (ayah.ayahNumber == 1) {
          ayah.ayah = ayah.ayah.replaceAll('۞', '');
          staticPages[ayah.page - 1].numberOfNewSurahs++;
          surahs.add(Surah(
              index: ayah.surahNumber,
              startPage: ayah.page,
              endPage: 0,
              nameEn: ayah.surahNameEn,
              nameAr: ayah.surahNameAr,
              ayahs: []));
          surahsStart.add(ayah.page - 1);
        }
      }
      surahs.last.endPage = ayahs.last.page;
      surahs.last.ayahs = thisSurahAyahs;
      for (QuranPage staticPage in staticPages) {
  List<Ayah> lineAyahs = [];

  for (Ayah aya in staticPage.ayahs) {
    if (aya.ayahNumber == 1 && lineAyahs.isNotEmpty) {
      // Start new surah: clear existing line buffer
      lineAyahs.clear();
    }

    if (aya.ayah.contains('\n')) {
      final parts = aya.ayah.split('\n');
      final codeParts = aya.codev2?.split('\n') ?? [];

for (int i = 0; i < parts.length; i++) {
  final partialText = parts[i].trim();
  final partialCode = i < codeParts.length ? codeParts[i] : '';

  final clonedAyah = Ayah.fromAya(
    ayah: aya,
    aya: aya.ayah, // full ayah for metadata
    ayaText: partialText,
    centered: aya.centered && i == parts.length - 2,
  );
  clonedAyah.codev2 = partialCode;

  lineAyahs.add(clonedAyah);

  if (i < parts.length - 1) {
    staticPage.lines.add(Line([...lineAyahs]));
    lineAyahs.clear();
  }
}

    } else {
      // No line break in ayah, just add to current line
      lineAyahs.add(aya);
    }
  }

  // Push any remaining ayahs as the final line of the page
  if (lineAyahs.isNotEmpty) {
    staticPage.lines.add(Line([...lineAyahs]));
    lineAyahs.clear();
  }
}


      emit(staticPages);
    }
  }

  List<Ayah> search(String searchText) {
    if (searchText.isEmpty) {
      return [];
    } else {
      final filteredAyahs = ayahs
          .where((aya) => aya.ayahText.contains(searchText.trim()))
          .toList();
      return filteredAyahs;
    }
  }

  saveLastPage(int lastPage) {
    this.lastPage = lastPage;
    _quranRepository.saveLastPage(lastPage);
  }

  animateToPage(int page) {
    if (_pageController.hasClients) {
      _pageController.animateToPage(page,
          duration: const Duration(milliseconds: 500), curve: Curves.easeOut);
    } else {
      _pageController = PageController(initialPage: page);
    }
  }

  get pageController => _pageController;
}
