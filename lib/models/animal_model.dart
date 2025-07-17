class AnimalModel {
  final String name;
  final int age;
  final String image;
  final String species;
  final String breed;
  final String gender;

  AnimalModel({
    required this.name,
    required this.age,
    required this.image,
    required this.species,
    required this.breed,
    required this.gender,
  });

  AnimalModel copyWith({String? name, String? breed}) {
    return AnimalModel(
      name: name ?? this.name,
      age: age,
      image: image,
      species: species,
      breed: breed ?? this.breed,
      gender: gender,
    );
  }
}
