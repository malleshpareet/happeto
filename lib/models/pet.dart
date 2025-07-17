class Pet {
  final String name;
  final int age;
  final String image;
  final String? articleTitle;
  final String? articleDescription;

  Pet({
    required this.name,
    required this.age,
    required this.image,
    this.articleTitle,
    this.articleDescription,
  });
}
