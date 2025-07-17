import 'package:cards_happeto/providers/animal_data_provider.dart';
import 'package:cards_happeto/providers/appointment_provider.dart';
import 'package:cards_happeto/providers/article_provider.dart';
import 'package:cards_happeto/providers/chat_provider.dart';
import 'package:cards_happeto/providers/doctor_provider.dart';
import 'package:cards_happeto/providers/selected_vet_provider.dart';
import 'package:cards_happeto/providers/symptom_provider.dart';
import 'package:cards_happeto/providers/vet_review_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'providers/pet_provider.dart';
import 'screens/pet_home_screen.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => PetProvider()),
        ChangeNotifierProvider(create: (_) => AnimalDataProvider()),
        ChangeNotifierProvider(create: (_) => ArticleProvider()),
        ChangeNotifierProvider(create: (_) => SymptomProvider()),
        ChangeNotifierProvider(create: (_) => VetProvider()),
        ChangeNotifierProvider(create: (_) => AppointmentProvider()),
        ChangeNotifierProvider(create: (_) => SelectedVetProvider()),
        ChangeNotifierProvider(create: (_) => VetReviewProvider()),
        ChangeNotifierProvider(create: (_) => ChatProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const PetHomeScreen(),
    );
  }
}
