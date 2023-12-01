import 'package:flutter/material.dart';

class ComboBoxValueProvider with ChangeNotifier {
  String _selectedValue = "Week";

  String get selectedValue => _selectedValue;

  void updateSelectedValue(String newValue) {
    _selectedValue = newValue;
    notifyListeners();
  }
}