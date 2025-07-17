import 'package:flutter/material.dart';

class AppointmentProvider extends ChangeNotifier {
  DateTime _selectedDay = DateTime.now();
  String _selectedTime = "09:30 AM";
  String _doctorName = "";
  String _doctorImage = "";

  DateTime get selectedDay => _selectedDay;
  String get selectedTime => _selectedTime;
  String get doctorName => _doctorName;
  String get doctorImage => _doctorImage;

  void setSelectedDay(DateTime day) {
    _selectedDay = day;
    notifyListeners();
  }

  void setSelectedTime(String time) {
    _selectedTime = time;
    notifyListeners();
  }

  void setDoctor(String name, String image) {
    _doctorName = name;
    _doctorImage = image;
    notifyListeners();
  }
}
