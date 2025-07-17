import 'package:flutter/material.dart';
import '../models/animal_model.dart';
import 'package:provider/provider.dart';
import '../providers/animal_data_provider.dart';

class EditAnimalFormWidget extends StatefulWidget {
  final AnimalModel animal;
  final int index;

  const EditAnimalFormWidget({super.key, required this.animal, required this.index});

  @override
  State<EditAnimalFormWidget> createState() => _EditAnimalFormWidgetState();
}

class _EditAnimalFormWidgetState extends State<EditAnimalFormWidget> {
  late TextEditingController nameController;
  late TextEditingController breedController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.animal.name);
    breedController = TextEditingController(text: widget.animal.breed);
  }

  @override
  void dispose() {
    nameController.dispose();
    breedController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final animalProvider = Provider.of<AnimalDataProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Profile picture with edit icon
              Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage(widget.animal.image),
                  ),
                  CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.edit, size: 20, color: Colors.black),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Editable fields
              _buildTextField("Name", nameController),
              _buildReadOnlyTile("Age", "${widget.animal.age}"),
              _buildReadOnlyTile("Species", widget.animal.species),
              _buildTextField("Breed", breedController),
              _buildReadOnlyTile("Gender", widget.animal.gender),

              const SizedBox(height: 40),

              // Save button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    animalProvider.updateAnimal(
                      index: widget.index,
                      name: nameController.text,
                      breed: breedController.text,
                    );
                    Navigator.pop(context);
                  },
                  child: const Text("Save", style: TextStyle(color: Colors.white, fontSize: 16)),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          labelStyle: const TextStyle(color: Colors.black87),
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildReadOnlyTile(String label, String value) {
    return Container(
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4)],
      ),
      child: ListTile(
        title: Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        trailing: Text(value, style: const TextStyle(color: Colors.black87)),
      ),
    );
  }
}
