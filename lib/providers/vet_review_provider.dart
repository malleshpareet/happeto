import 'package:flutter/material.dart';
import '../models/vet_review.dart';

class VetReviewProvider with ChangeNotifier {
  final List<VetReview> _allReviews = [
    VetReview(
      name: "Khushi",
      time: "2d ago",
      rating: 5,
      review: "So impressed with the care my dog Bella has received. Amazing surgical skills and high compassion.",
    ),
    VetReview(
      name: "Darshan",
      time: "7d ago",
      rating: 2,
      review: "My dog Keisha hated going to the vet. She was shaking. Thankfully the vet helped quickly.",
    ),
    VetReview(
      name: "Harshit",
      time: "12d ago",
      rating: 4,
      review: "Got a sprocker puppy. The vet handled him professionally. Would recommend!",
    ),
    VetReview(
      name: "Mallesh",
      time: "1d ago",
      rating: 1,
      review: "Vet was unavailable at scheduled time. Disappointed.",
    ),
  ];

  List<VetReview> get allReviews => _allReviews;

  List<VetReview> filterReviews(String filter) {
    if (filter == "Critical") {
      return _allReviews.where((r) => r.rating <= 2).toList();
    } else if (filter == "Favourable") {
      return _allReviews.where((r) => r.rating >= 4).toList();
    } else {
      return _allReviews;
    }
  }

  void addReview(VetReview newReview) {
    _allReviews.insert(0, newReview);
    notifyListeners();
  }
}
