import 'package:flutter/foundation.dart';
import '../data/quiz_questions.dart';

class QuizController extends ChangeNotifier {
  String _userName = '';
  int _currentIndex = 0;
  final List<int?> _answers = List<int?>.filled(quizQuestions.length, null);

  String get userName => _userName;
  int get currentIndex => _currentIndex;
  int get totalQuestions => quizQuestions.length;
  int get answeredCount => _answers.where((a) => a != null).length;
  bool get isComplete => answeredCount == totalQuestions;
  int? get selectedAnswer => _answers[_currentIndex];
  int? answerAt(int index) => _answers[index];

  void setUserName(String name) {
    final cleaned = name.trim();
    if (cleaned.isEmpty) return;
    _userName = cleaned;
    _clearAnswers();
    notifyListeners();
  }

  void selectAnswer(int optionIndex) {
    final count = quizQuestions[_currentIndex].options.length;
    if (optionIndex < 0 || optionIndex >= count) return;
    _answers[_currentIndex] = optionIndex;
    notifyListeners();
  }

  void nextQuestion() {
    if (_currentIndex >= totalQuestions - 1) return;
    _currentIndex++;
    notifyListeners();
  }

  void previousQuestion() {
    if (_currentIndex <= 0) return;
    _currentIndex--;
    notifyListeners();
  }

  // kembali ke soal yang belum dijawab
  bool finishQuiz() {
    final firstUnanswered = _answers.indexOf(null);
    if (firstUnanswered != -1) {
      _currentIndex = firstUnanswered;
      notifyListeners();
      return false;
    }
    return true;
  }

  int get correctCount {
    var correct = 0;
    for (var i = 0; i < totalQuestions; i++) {
      if (_answers[i] == quizQuestions[i].correctIndex) correct++;
    }
    return correct;
  }

  int get score => totalQuestions == 0
      ? 0
      : (correctCount / totalQuestions * 100).round();

  void _clearAnswers() {
    _currentIndex = 0;
    for (var i = 0; i < _answers.length; i++) {
      _answers[i] = null;
    }
  }

  void resetQuiz() {
    _clearAnswers();
    notifyListeners();
  }
}
