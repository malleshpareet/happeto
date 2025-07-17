import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/animal_data_provider.dart';
import '../widgets/edit_animal_form_widget.dart';

class EditAnimalScreen extends StatelessWidget {
  final int animalIndex;

  const EditAnimalScreen({super.key, required this.animalIndex});

  @override
  Widget build(BuildContext context) {
    final animalProvider = Provider.of<AnimalDataProvider>(context);
    final animal = animalProvider.animals[animalIndex];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: const BackButton(color: Colors.black),
        centerTitle: true,
        title: const Text('Edit pet infos', style: TextStyle(color: Colors.black)),
      ),
      body: EditAnimalFormWidget(animal: animal, index: animalIndex),
    );
  }
}
