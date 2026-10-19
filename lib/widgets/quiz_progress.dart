import 'package:flutter/material.dart';

class QuizProgress extends StatelessWidget {
  final int answeredCount;
  final int totalQuestions;

  const QuizProgress({
    super.key,
    required this.answeredCount,
    required this.totalQuestions,
  });

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.sizeOf(context).height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          '$answeredCount dari $totalQuestions soal terjawab',
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodyMedium,
        ),
        SizedBox(height: screenHeight * 0.02),
        LinearProgressIndicator(
          value: totalQuestions == 0 ? 0.0 : answeredCount / totalQuestions,
          backgroundColor: Theme.of(context).colorScheme.surface,
          color: Theme.of(context).colorScheme.tertiary,
          minHeight: 10,
          borderRadius: BorderRadius.circular(10),
        ),
      ],
    );
  }
}
