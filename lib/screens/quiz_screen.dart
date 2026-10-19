import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../config/app_theme.dart';
import '../data/quiz_questions.dart';
import '../state/quiz_controller.dart';
import '../widgets/theme_toggle_button.dart';
import '../state/theme_controller.dart';
import '../widgets/answer_option.dart';
import '../widgets/quiz_progress.dart';
import '../widgets/responsive_container.dart';
import '../widgets/primary_button.dart';

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
          const ThemeToggleButton(),
          const SizedBox(width: 8),
        ],
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: screenWidth * 0.06,
            vertical: screenHeight * 0.03,
          ),
          child: ResponsiveContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // JUMLAH SOAL TERJAWAB
                QuizProgress(
                  answeredCount: quiz.answeredCount,
                  totalQuestions: quiz.totalQuestions,
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
                  AnswerOption(
                    index: i,
                    answer: question.options[i],
                    isSelected: quiz.selectedAnswer == i,
                    onPressed: () => quiz.selectAnswer(i),
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
                if (quiz.isComplete)
                  PrimaryButton(
                    label: 'Selesai',
                    onPressed: () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (dialogContext) => AlertDialog(
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
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(false),
                              child: Text(
                                'Belum',
                                style: Theme.of(context).textTheme.bodyLarge,
                              ),
                            ),
                            ElevatedButton(
                              onPressed: () =>
                                  Navigator.of(dialogContext).pop(true),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Theme.of(dialogContext)
                                    .colorScheme.tertiary,
                                foregroundColor: isDarkMode
                                    ? AppColors.darkBackground
                                    : AppColors.text,
                              ),
                              child: Text(
                                'Sudah',
                                style: Theme.of(context).textTheme.bodyLarge
                                    ?.copyWith(
                                  color: isDarkMode
                                      ? AppColors.darkBackground
                                      : AppColors.text,
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                      if (!context.mounted) return;
                      if (confirmed == true && quiz.finishQuiz()) {
                        context.go('/result');
                      }
                    },
                  ),

                SizedBox(height: screenHeight * 0.03),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
