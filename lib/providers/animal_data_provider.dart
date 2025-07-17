import 'package:flutter/material.dart';
import '../models/animal_model.dart';

class AnimalDataProvider with ChangeNotifier {
  final List<AnimalModel> _animals = [
    AnimalModel(
      name: "Zoro",
      age: 4,
      image: "assets/images/zoro.jpg",
      species: "Dog",
      breed: "Labrador",
      gender: "Male",
    ),
    AnimalModel(
      name: "Tommy",
      age: 2,
      image: "assets/images/Tommy.jpg",
      species: "Dog",
      breed: "Bengal",
      gender: "Male",
    ),
  ];

  List<AnimalModel> get animals => _animals;

  void updateAnimal({
    required int index,
    required String name,
    required String breed,
  }) {
    _animals[index] = _animals[index].copyWith(name: name, breed: breed);
    notifyListeners();
  }
}
