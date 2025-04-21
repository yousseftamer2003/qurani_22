import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:http/http.dart' as http;
import 'package:qurani_22/controllers/user_controller.dart';
import 'package:qurani_22/models/duaa_model.dart';

class DuaaController with ChangeNotifier {
  List<Duaa> _duaaList = [];
  List<Duaa> get duaaList => _duaaList;

  bool isduaaLoaded = false;

  Future<void> getDuaaList(BuildContext context) async {
    final userProvider = Provider.of<UserController>(context, listen: false);
    final uuid = userProvider.uuid;
    try {
      final response = await http.get(Uri.parse('https://talk-to-quran.com/api/user/getAd3ya'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Device-UUID': uuid!,
      },
      );
      if(response.statusCode == 200){
        final responseData = jsonDecode(response.body);
        Duaas duas = Duaas.fromJson(responseData);
        _duaaList = duas.duaaList.map((e) => Duaa.fromJson(e)).toList();
        _duaaList = _duaaList.where((e) => e.status == '1',).toList();
        isduaaLoaded = true;
        notifyListeners();
      }else{
        log('Failed to fetch duaa list: ${response.statusCode}');
        log('Failed to fetch duaa list: ${response.body}');
      }
    } catch (e) {
      log('Error fetching duaa list: $e');
    }
  }
}