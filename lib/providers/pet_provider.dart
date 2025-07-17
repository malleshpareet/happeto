import 'package:flutter/material.dart';
import '../models/pet.dart';

class PetProvider with ChangeNotifier {
  final List<Pet> _pets = [
    Pet(
      name: 'Zoro',
      age: 3,
      image: 'assets/images/zoro.jpg',
      articleTitle: 'Is your dog sick?',
      articleDescription: "Learn how to identify common symptoms and take action early. A healthy pet is a happy pet it's important that you know what warning signs to look out for so you can take action...t's important that you know what warning signs to look out for so you can take action..",
    ),
    Pet(
      name: 'Tommy',
      age: 3,
      image: 'assets/images/Tommy.jpg',
      articleTitle: 'What are the signs of sick dog?',
      articleDescription: "Learn how to identify common symptoms and take action early If your dog is sick, it's important that you know what warning signs to look out for so you can take action...t's important that you know what warning signs to look out for so you can take action...",
    ),
  ];

  List<Pet> get pets => _pets;

  void addPet(Pet pet) {
    _pets.add(pet);
    notifyListeners();
  }

  void editPet(int index, Pet newPet) {
    _pets[index] = newPet;
    notifyListeners();
  }
}
