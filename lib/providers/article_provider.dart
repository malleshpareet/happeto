import 'package:flutter/cupertino.dart';

import '../models/article.dart';

class ArticleProvider with ChangeNotifier {
  Article _article = Article(
    title: "Top 10 signs your dog may be sick",
    imagePath: 'assets/images/article.png',
    overview:
    "As is the case with people, a dog’s health changes with age. Unfortunately, our pets age much faster than we do.",
    symptoms:
    "Regardless of your dog’s age, you play a key role in helping her combat illness and remain as healthy as possible. Remember, your dog cannot describe symptoms to you, but she can show you signs of disease. Awareness of signs of dog illness is one way to be a responsible dog owner and take the best care of your pet.",
  );

  Article get article => _article;

  void setArticle(Article newArticle) {
    _article = newArticle;
    notifyListeners(); // Important to notify the UI to rebuild if needed
  }
}
