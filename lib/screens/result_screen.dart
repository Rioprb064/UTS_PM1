import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../config/app_theme.dart';
import '../data/quiz_questions.dart';
import '../state/quiz_controller.dart';
import 'package:go_router/go_router.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final quiz = context.watch<QuizController>();
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,

      appBar: AppBar(
        backgroundColor: AppColors.primary,
        automaticallyImplyLeading: false,
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: Text(
          'HASIL KUIS',
          style: AppTextStyles.appTitle,
        ),
      ),

      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 420),

            child: ListView.builder(
              padding: EdgeInsets.symmetric(
                horizontal: MediaQuery.of(context).size.width * 0.06,
                vertical: MediaQuery.of(context).size.height * 0.03,
              ),
              itemCount: quizQuestions.length + 2,

              itemBuilder: (context, index) {
                // nilai
                if (index == 0) {
                  return Column(
                    children: [
                      Text(
                        'Selamat, ${quiz.userName}!',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.pageTitle,
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),

                      Text(
                        'Nilai Kamu',
                        style: AppTextStyles.question,
                      ),

                      Text(
                        '${quiz.score}',
                        style: AppTextStyles.appTitle.copyWith(
                          fontSize: 60,
                          color: AppColors.accent,
                        ),
                      ),

                      Text(
                        '${quiz.correctCount} dari ${quiz.totalQuestions} soal benar',
                        textAlign: TextAlign.center,
                        style: AppTextStyles.instruction,
                      ),

                      Container(
                        child: Image.asset(
                          'assets/images/trofi.png',
                          width: screenWidth * 0.5,
                          height: screenHeight * 0.18,
                          fit: BoxFit.contain,
                        ),
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.04,
                      ),

                      Text(
                        'Hasil Jawaban',
                        style: AppTextStyles.pageTitle,
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                    ],
                  );
                }


                if (index == quizQuestions.length + 1) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).size.height * 0.03,
                    ),
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.07,
                      child: ElevatedButton(
                        onPressed: () {
                          context.read<QuizController>().resetQuiz();
                          context.go('/home', extra: quiz.userName);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.accent,
                          foregroundColor: AppColors.text,
                        ),
                        child: Text(
                          'Kembali ke Home',
                          style: AppTextStyles.answer,
                        ),
                      ),
                    ),
                  );
                }

                // data setiap soal
                final question = quizQuestions[index - 1];
                final selectedIndex = quiz.answerAt(index - 1);
                final isCorrect =
                    selectedIndex == question.correctIndex;

                return Container(
                  margin: EdgeInsets.only(
                    bottom: MediaQuery.of(context).size.height * 0.02,
                  ),

                  padding: EdgeInsets.all(
                    MediaQuery.of(context).size.width * 0.04,
                  ),

                  decoration: BoxDecoration(
                    color: AppColors.surface,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: isCorrect ? Colors.green : Colors.red,
                      width: 2,
                    ),
                  ),

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // nomor dan status soal
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              'Pertanyaan $index',
                              style: AppTextStyles.pageTitle,
                            ),
                          ),

                          Icon(
                            isCorrect
                                ? Icons.check_circle
                                : Icons.cancel,
                            color: isCorrect
                                ? Colors.green
                                : Colors.red,
                            size: 28,
                          ),
                        ],
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),

                      // teks pertanyaan
                      Text(
                        question.question,
                        style: AppTextStyles.question,
                      ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),

                      // empat opsi jawaban
                      for (int i = 0; i < question.options.length; i++)
                        Container(
                          width: double.infinity,

                          margin: EdgeInsets.only(
                            bottom: MediaQuery.of(context).size.height * 0.01,
                          ),

                          padding: EdgeInsets.symmetric(
                            horizontal: MediaQuery.of(context).size.width * 0.03,
                            vertical: MediaQuery.of(context).size.height * 0.015,
                          ),

                          decoration: BoxDecoration(
                            color: i == question.correctIndex
                                ? Colors.green.shade50
                                : i == selectedIndex
                                ? Colors.red.shade50
                                : AppColors.background,
                            borderRadius: BorderRadius.circular(10),
                          ),

                          child: Row(
                            children: [
                              Icon(
                                i == question.correctIndex
                                    ? Icons.check_circle
                                    : i == selectedIndex
                                    ? Icons.cancel
                                    : Icons.circle_outlined,
                                color: i == question.correctIndex
                                    ? Colors.green
                                    : i == selectedIndex
                                    ? Colors.red
                                    : Colors.grey,
                                size: 22,
                              ),

                              SizedBox(
                                width: MediaQuery.of(context).size.width * 0.02,
                              ),

                              Expanded(
                                child: Text(
                                  '${String.fromCharCode(65 + i)}. ${question.options[i]}',
                                  style: AppTextStyles.answer,
                                ),
                              ),
                            ],
                          ),
                        ),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),

                      // jawaban user
                      Text(
                        selectedIndex == null
                            ? 'Jawaban kamu: Belum dijawab'
                            : 'Jawaban kamu: ${String.fromCharCode(65 + selectedIndex)}. ${question.options[selectedIndex]}',
                        style: AppTextStyles.instruction.copyWith(
                          color: isCorrect
                              ? Colors.green.shade700
                              : Colors.red.shade700,
                        ),
                      ),

                      // tampilkan jawaban jika benar atau salah
                      if (!isCorrect)
                        Padding(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).size.height * 0.01,
                          ),
                          child: Text(
                            'Jawaban benar: ${String.fromCharCode(65 + question.correctIndex)}. ${question.options[question.correctIndex]}',
                            style: AppTextStyles.instruction.copyWith(
                              color: Colors.green.shade700,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
