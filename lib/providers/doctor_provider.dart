import 'package:flutter/material.dart';
import '../models/vet_model.dart';

class VetProvider with ChangeNotifier {
  final List<Veterinarian> _vets = [
    Veterinarian(
      name: 'Dr. Meenakshi S',
      specialty: 'Veterinary',
      rating: 4.5,
      reviews: 220,
      fee: 499,
      image: 'assets/images/doctor5.png',
    ),
    Veterinarian(
      name: 'Dr. Madhu K',
      specialty: 'Veterinary',
      rating: 4.0,
      reviews: 124,
      fee: 929,
      image: 'assets/images/doctor4.png',
    ),
    Veterinarian(
      name: 'Dr. Madhu K',
      specialty: 'Veterinary',
      rating: 5.0,
      reviews: 32,
      fee: 299,
      image: 'assets/images/doctor3.png',
    ),
    Veterinarian(
      name: 'Dr. Sanju V',
      specialty: 'Veterinary',
      rating: 4.0,
      reviews: 385,
      fee: 99,
      image: 'assets/images/doctor5.png',
    ),
    Veterinarian(
      name: 'Dr. Meenakshi S',
      specialty: 'Veterinary',
      rating: 4.5,
      reviews: 220,
      fee: 499,
      image: 'assets/images/doctor4.png',
    ),
  ];

  List<Veterinarian> get vets => _vets;
}
