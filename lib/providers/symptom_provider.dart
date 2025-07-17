import 'package:flutter/material.dart';
import '../models/symptom_article.dart';

class SymptomProvider with ChangeNotifier {
  String _query = "";

  final List<String> _petImages = [
    'assets/images/dog1.png',
    'assets/images/dog2.png',
    'assets/images/dog1.png',
  ];

  final List<SymptomArticle> _allArticles = [
    SymptomArticle(
      title: "What are the signs of sick dog?",
      description:
      "If your dog is sick, it's important that you know what warning signs to look out for so you can take appropriate steps.",
    ),
    SymptomArticle(
      title: "Top 10 Signs Your Dog May Be Sick",
      description:
      "Regardless of your dog’s age, you play a key role in helping her combat illness and remain as healthy as possible.",
    ),
    SymptomArticle(
      title: "Caring for your Sick Dog",
      description:
      "If your dog or puppy is being sick or has diarrhoea these are common signs of illness that shouldn't be ignored.",
    ),
    SymptomArticle(
      title: "Caring for your Sick Dog",
      description:
      "If your dog or puppy is being sick or has diarrhoea these are common signs of illness that shouldn't be ignored.",
    ),
    SymptomArticle(
      title: "Caring for your Sick Dog",
      description:
      "If your dog or puppy is being sick or has diarrhoea these are common signs of illness that shouldn't be ignored.",
    ),
    SymptomArticle(
      title: "Caring for your Sick Dog",
      description:
      "If your dog or puppy is being sick or has diarrhoea these are common signs of illness that shouldn't be ignored.",
    ),
    SymptomArticle(
      title: "Caring for your Sick Dog",
      description:
      "If your dog or puppy is being sick or has diarrhoea these are common signs of illness that shouldn't be ignored.",
    ),
    // Add more articles as needed
  ];

  String get query => _query;

  List<SymptomArticle> get filteredArticles => _query.isEmpty
      ? _allArticles
      : _allArticles
      .where((article) =>
  article.title.toLowerCase().contains(_query.toLowerCase()) ||
      article.description.toLowerCase().contains(_query.toLowerCase()))
      .toList();

  List<String> get petImages => _petImages;

  void setQuery(String value) {
    _query = value;
    notifyListeners();
  }
}
