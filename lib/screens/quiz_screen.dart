import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/app_theme.dart';
import '../data/quiz_questions.dart';
import '../state/quiz_controller.dart';
import '../state/theme_controller.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final quiz = context.watch<QuizController>();
    final question = quizQuestions[quiz.currentIndex];
    final isDarkMode = context.watch<ThemeController>().isDarkMode;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        scrolledUnderElevation: 0,
        leading: const SizedBox(width: 56),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'KUIS ASAH OTAK',
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              context.read<ThemeController>().toggleTheme();
            },
            icon: Icon(
              isDarkMode ? Icons.light_mode : Icons.dark_mode,
              color: Theme.of(context).colorScheme.onSurface,
              size: 28,
            ),
            tooltip: isDarkMode
                ? 'Aktifkan Mode Terang'
                : 'Aktifkan Mode Gelap',
          ),
          const SizedBox(width: 8),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.03,
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // JUMLAH SOAL TERJAWAB
                  Text(
                    '${quiz.answeredCount} dari ${quiz.totalQuestions} soal terjawab',
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  LinearProgressIndicator(
                    value: quiz.answeredCount / quiz.totalQuestions,
                    backgroundColor: Theme.of(context).colorScheme.surface,
                    color: Theme.of(context).colorScheme.tertiary,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // NOMOR SOAL
                  Text(
                    'Pertanyaan ${quiz.currentIndex + 1}',
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // PERTANYAAN
                  Text(
                    question.question,
                    style: Theme.of(context).textTheme.titleLarge,
                  ),

                  SizedBox(height: screenHeight * 0.03),

                  // PILIHAN JAWABAN
                  for (int i = 0; i < question.options.length; i++)
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: screenHeight * 0.015,
                      ),
                      child: OutlinedButton(
                        onPressed: () {
                          context.read<QuizController>().selectAnswer(i);
                        },
                        style: OutlinedButton.styleFrom(
                          backgroundColor: quiz.selectedAnswer == i
                              ? Theme.of(context).colorScheme.primary
                              : Theme.of(context).colorScheme.surface,
                          foregroundColor:
                          Theme.of(context).colorScheme.onSurface,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04,
                            vertical: screenHeight * 0.02,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${String.fromCharCode(65 + i)}. ${question.options[i]}',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),
                    ),

                  SizedBox(height: screenHeight * 0.03),


// NAVIGASI SOAL
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: quiz.currentIndex > 0
                              ? () => quiz.previousQuestion()
                              : null,
                          child: Text(
                            'Sebelumnya',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                        ),
                      ),

                      SizedBox(width: screenWidth * 0.03),

                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (quiz.currentIndex < quiz.totalQuestions - 1) {
                              quiz.nextQuestion();
                            } else {
                              quiz.finishQuiz();
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Theme.of(context).colorScheme.tertiary,
                            foregroundColor: isDarkMode
                                ? AppColors.darkBackground
                                : AppColors.text,
                          ),
                          child: Text(
                            'Selanjutnya',
                            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                              color: isDarkMode
                                  ? AppColors.darkBackground
                                  : AppColors.text,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: screenHeight * 0.03),

// TOMBOL SELESAI
                  if (quiz.answeredCount == quiz.totalQuestions)
                    ElevatedButton(
                      onPressed: () async {
                        final confirmed = await showDialog<bool>(
                          context: context,
                          builder: (dialogContext) {
                            return AlertDialog(
                              title: Text(
                                'Selesaikan Kuis?',
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                              content: Text(
                                'Apakah kamu sudah yakin dengan jawabanmu?',
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop(false);
                                  },
                                  child: Text(
                                    'Belum',
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop(true);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Theme.of(dialogContext)
                                        .colorScheme.tertiary,
                                    foregroundColor: isDarkMode
                                        ? AppColors.darkBackground
                                        : AppColors.text,
                                  ),
                                  child: Text(
                                    'Sudah',
                                    style: Theme.of(dialogContext)
                                        .textTheme.bodyLarge?.copyWith(
                                      color: isDarkMode
                                          ? AppColors.darkBackground
                                          : AppColors.text,
                                    ),
                                  ),
                                ),
                              ],
                            );
                          },
                        );

                        if (!context.mounted) return;

                        if (confirmed == true) {
                          context.go('/result');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Theme.of(context).colorScheme.tertiary,
                        foregroundColor: isDarkMode
                            ? AppColors.darkBackground
                            : AppColors.text,
                      ),
                      child: Text(
                        'Selesai',
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                          color: isDarkMode
                              ? AppColors.darkBackground
                              : AppColors.text,
                        ),
                      ),
                    ),

                  SizedBox(height: screenHeight * 0.03),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
