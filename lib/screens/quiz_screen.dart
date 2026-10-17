
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/app_theme.dart';
import '../state/quiz_controller.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final userName = context.watch<QuizController>().userName;

    return Scaffold(
      backgroundColor: AppColors.background,

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth * 0.06,
              vertical: screenHeight * 0.04,
            ),

            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 420,
              ),

              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [

                  // Judul aplikasi
                  Text(
                    'KUIS ASAH OTAK',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.appTitle,
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // Menampilkan nama dari Provider
                  Text(
                    'Halo, $userName!',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.pageTitle,
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Teks petunjuk
                  Text(
                    'Sudah siap menguji pengetahuanmu?',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.instruction,
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // Gambar
                  Image.asset(
                    'assets/images/anak_sd.png',
                    height: (screenHeight * 0.25)
                        .clamp(100.0, 220.0)
                        .toDouble(),
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: screenHeight * 0.04),

                  // Tombol mulai kuis
                  SizedBox(
                    width: double.infinity,
                    height: (screenHeight * 0.07)
                        .clamp(48.0, 60.0)
                        .toDouble(),

                    child: ElevatedButton(
                      onPressed: null,

                      child: Text(
                        'Mulai Kuis',
                        style: AppTextStyles.answer,
                      ),
                    ),
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // Tombol kembali
                  TextButton(
                    onPressed: () {
                      context.go('/');
                    },

                    child: Text(
                      'Ganti Nama',
                      style: AppTextStyles.answer.copyWith(
                        color: AppColors.text,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
