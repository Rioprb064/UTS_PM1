
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/app_theme.dart';
import '../data/quiz_questions.dart';
import '../state/quiz_controller.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final quiz = context.watch<QuizController>();
    final question = quizQuestions[quiz.currentIndex];

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          'KUIS ASAH OTAK',
          style: AppTextStyles.appTitle,
        ),
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
                    style: AppTextStyles.instruction,
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  LinearProgressIndicator(
                    value: quiz.answeredCount / quiz.totalQuestions,
                    backgroundColor: AppColors.surface,
                    color: AppColors.accent,
                    minHeight: 10,
                    borderRadius: BorderRadius.circular(10),
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // NOMOR SOAL
                  Text(
                    'Pertanyaan ${quiz.currentIndex + 1}',
                    style: AppTextStyles.pageTitle,
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // PERTANYAAN
                  Text(
                    question.question,
                    style: AppTextStyles.question,
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
                              ? AppColors.primary
                              : AppColors.surface,
                          foregroundColor: AppColors.text,
                          padding: EdgeInsets.symmetric(
                            horizontal: screenWidth * 0.04,
                            vertical: screenHeight * 0.02,
                          ),
                        ),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(
                            '${String.fromCharCode(65 + i)}. ${question.options[i]}',
                            style: AppTextStyles.answer,
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
                            style: AppTextStyles.answer,
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
                            backgroundColor: AppColors.accent,
                            foregroundColor: AppColors.text,
                          ),
                          child: Text(
                            'Selanjutnya',
                            style: AppTextStyles.answer,
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
                                style: AppTextStyles.pageTitle,
                              ),
                              content: Text(
                                'Apakah kamu sudah yakin dengan jawabanmu?',
                                style: AppTextStyles.instruction,
                              ),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop(false);
                                  },
                                  child: Text(
                                    'Belum',
                                    style: AppTextStyles.answer,
                                  ),
                                ),
                                ElevatedButton(
                                  onPressed: () {
                                    Navigator.of(dialogContext).pop(true);
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: AppColors.accent,
                                    foregroundColor: AppColors.text,
                                  ),
                                  child: Text(
                                    'Sudah',
                                    style: AppTextStyles.answer,
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
                        backgroundColor: AppColors.accent,
                        foregroundColor: AppColors.text,
                      ),
                      child: Text(
                        'Selesai',
                        style: AppTextStyles.answer,
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
