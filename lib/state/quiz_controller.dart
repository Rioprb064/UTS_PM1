import 'package:flutter/material.dart';
import '../data/quiz_questions.dart';

class QuizController extends ChangeNotifier {
  String _userName = '';

  String get userName => _userName;

  void setUserName(String name) {
    _userName = name.trim();
    notifyListeners();
  }

  int _currentIndex = 0;

  final List<int?> _answers =
  List<int?>.filled(quizQuestions.length, null);

  int get currentIndex => _currentIndex;

  int get totalQuestions => quizQuestions.length;

  int get answeredCount =>
      _answers.where((answer) => answer != null).length;

  int? get selectedAnswer => _answers[_currentIndex];

  int? answerAt(int index) => _answers[index];
  // Menyimpan pilihan jawaban
  void selectAnswer(int index) {
    _answers[_currentIndex] = index;
    notifyListeners();
  }

  // Berpindah ke soal berikutnya
  void nextQuestion() {
    if (_currentIndex < totalQuestions - 1) {
      _currentIndex++;
      notifyListeners();
    }
  }

  // Kembali ke soal sebelumnya
  void previousQuestion() {
    if (_currentIndex > 0) {
      _currentIndex--;
      notifyListeners();
    }
  }

  // Memeriksa jawaban saat tombol Selesai ditekan
  bool finishQuiz() {
    final firstUnanswered = _answers.indexOf(null);

    if (firstUnanswered != -1) {
      _currentIndex = firstUnanswered;
      notifyListeners();
      return false;
    }

    return true;
  }


  // Menghitung jumlah jawaban benar
  int get correctCount {
    int count = 0;

    for (int i = 0; i < quizQuestions.length; i++) {
      if (_answers[i] == quizQuestions[i].correctIndex) {
        count++;
      }
    }

    return count;
  }

  // Menghitung nilai akhir
  int get score =>
      (correctCount / totalQuestions * 100).round();

}
