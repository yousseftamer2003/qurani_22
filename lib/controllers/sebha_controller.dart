import 'package:flutter/material.dart';

class SebhaController with ChangeNotifier {

  Map<String, int> sebhaCounters = {
    'الحمد لله': 0,
    'الله اكبر': 0,
    'سبحان الله': 0,
    'استغفر الله': 0,
  };

  String? selectedPhrase;

  void setSelectedPhrase(String? phrase) {
    selectedPhrase = phrase;
    notifyListeners();
  }

  // Increment the counter for a specific phrase
  void increment(String phrase) {
    if (sebhaCounters.containsKey(phrase)) {
      sebhaCounters[phrase] = sebhaCounters[phrase]! + 1;
      notifyListeners();
    }
  }

  // Reset the counter for a specific phrase
  void reset(String phrase) {
    if (sebhaCounters.containsKey(phrase)) {
      sebhaCounters[phrase] = 0;
      notifyListeners();
    }
  }

  // Reset all counters
  void resetAll() {
    sebhaCounters.updateAll((key, value) => 0);
    notifyListeners();
  }
}
