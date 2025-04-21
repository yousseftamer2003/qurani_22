// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:qurani_22/controllers/lang_controller.dart';
import 'package:qurani_22/controllers/user_controller.dart';
import 'dart:math' as math;

import 'package:qurani_22/models/for_you_page.dart';

class ForYouPageController with ChangeNotifier {
  ForYouPage? _forYouPage;
  List<Map<String, dynamic>> _randomizedContent = [];

  ForYouPage? get forYouPage => _forYouPage;
  List<Map<String, dynamic>> get randomizedContent => _randomizedContent;

  bool isForYouPageLoaded = false;

  Future<void> getForYouPage(BuildContext context) async {
    try {
      final userProvider = Provider.of<UserController>(context, listen: false);
      final uuid = userProvider.uuid;
      final response = await http.get(
        Uri.parse('https://talk-to-quran.com/api/user/foryouPage'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Device-UUID': uuid!,
        },
      );
      
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        _forYouPage = ForYouPage.fromJson(responseData);
        isForYouPageLoaded = true;
        // Create randomized content list
        _createRandomizedContentList(context);
        
        notifyListeners();
      } else {
        log('Failed to fetch for you page: ${response.statusCode}');
        log('Failed to fetch for you page: ${response.body}');
      }
    } catch (e) {
      log('Error fetching for you page: $e');
    }
  }

  void _createRandomizedContentList(BuildContext context) {
    final langServices = Provider.of<LangServices>(context,listen: false);
    if (_forYouPage == null) return;
    
    _randomizedContent = [];
    
    // Add ayat with content type
    _forYouPage!.ayat.forEach((aya) {
      _randomizedContent.add({
        'id': aya.id,
        'arabic': aya.ayaAr,
        'english': aya.ayaEn,
        'note' : aya.note,
        'type': langServices.isArabic ? 'ايه' : 'aya'
      });
    });
    
    // Add ad3ya with content type
    _forYouPage!.ad3ya.forEach((duaa) {
      _randomizedContent.add({
        'id': duaa.id,
        'arabic': duaa.duaaAr,
        'english': duaa.duaaEn,
        'note' : duaa.note,
        'type': langServices.isArabic ? 'دعاء' : 'Duaa'
      });
    });
    
    // Add ahadith with content type
    _forYouPage!.ahadith.forEach((hadith) {
      _randomizedContent.add({
        'id': hadith.id,
        'arabic': hadith.hadithAr,
        'english': hadith.hadithEn,
        'note' : hadith.note,
        'type': langServices.isArabic ? 'حديث' : 'hadith'
      });
    });
    
    _randomizedContent.shuffle(math.Random());
  }
}