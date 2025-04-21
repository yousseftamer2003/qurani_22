import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;
import 'package:qurani_22/controllers/user_controller.dart';
import 'package:qurani_22/models/azkar_model.dart';

class AzkarController with ChangeNotifier {
  List<Category> _categories = [];
  List<Category> get categories => _categories;

  List<Zekr> _azkar = [];
  List<Zekr> get azkar => _azkar;

  bool isCategoryLoaded = false;
  bool isAzkarLoaded = false;

  Future<void> getCategories(BuildContext context) async{
    try{
      final userProvider = Provider.of<UserController>(context, listen: false);
      final uuid = userProvider.uuid;
      final response = await http.get(Uri.parse('https://talk-to-quran.com/api/user/getCategories'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Device-UUID': uuid!,
      },
      );
      if(response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        Categories categories = Categories.fromJson(responseData);
        _categories = categories.categories.map((e) => Category.fromJson(e)).toList();
        isCategoryLoaded = true;
        notifyListeners();
      }else{
        log('Failed to fetch categories: ${response.statusCode}');
        log('Failed to fetch categories: ${response.body}');
      }
    }catch(e){
      log('Error fetching categories: $e');
    }
  }

  Future<void> getAzkarByCategory(BuildContext context,int id) async{
    try {
      final userProvider = Provider.of<UserController>(context, listen: false);
      final uuid = userProvider.uuid;
      final response = await http.get(Uri.parse('https://talk-to-quran.com/api/user/getAzkarCategory/$id'),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'Device-UUID': uuid!,
        },
      );
      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        Azkar azkars = Azkar.fromJson(responseData);
        _azkar = azkars.azkar.map((e) => Zekr.fromJson(e)).toList();
        isAzkarLoaded = true;
        notifyListeners();
      } else {
        log('Failed to fetch azkar by category: ${response.statusCode}');
        log('Failed to fetch azkar by category: ${response.body}');
      }
      }
    catch (e) {
      log('Error fetching azkar by category: $e');
    }
  }
}