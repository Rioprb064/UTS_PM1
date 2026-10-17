
import 'package:flutter/material.dart';

class QuizController extends ChangeNotifier {
  String _userName = '';

  String get userName => _userName;

  void setUserName(String name) {
    _userName = name.trim();
    notifyListeners();
  }
}
