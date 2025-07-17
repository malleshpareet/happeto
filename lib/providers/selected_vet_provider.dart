import 'package:flutter/material.dart';

class SelectedVetProvider with ChangeNotifier {
  String _name = 'Dr. Spoorthi Madhu';
  String _image = 'assets/images/doctor1.png';
  double _fee = 929.0;

  String get name => _name;
  String get image => _image;
  double get fee => _fee;

  void setVet(String name, String image, double fee) {
    _name = name;
    _image = image;
    _fee = fee;
    notifyListeners();
  }
}
