import 'package:flutter/material.dart';
import 'package:exchange_rates/models/rate.dart';

class RateProvider extends ChangeNotifier {
  late Rate currentrate;

  void setCurrentRate(Rate rate) {
    try {
      this.currentrate = rate;
      notifyListeners();
    } catch (e) {
      //
    }
  }
}
