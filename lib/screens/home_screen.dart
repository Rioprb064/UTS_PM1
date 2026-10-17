
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

      // header
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: screenHeight * 0.09 ,
        title: Text(
          'KUIS ASAH OTAK',
          textAlign: TextAlign.center,
          style: AppTextStyles.appTitle,
        ),
      ),

      // body
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(
            horizontal: (screenWidth * 0.06)
                .clamp(16.0, 40.0)
                .toDouble(),
            vertical: (screenHeight * 0.03)
                .clamp(12.0, 28.0)
                .toDouble(),
          ),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Halo, $userName!',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.pageTitle,
                  ),

                  SizedBox(height: screenHeight * 0.01),

                  Text(
                    'Sudah siap untuk memulai kuis?',
                    textAlign: TextAlign.center,
                    style: AppTextStyles.instruction,
                  ),

                  SizedBox(height: screenHeight * 0.01),

                  Image.asset(
                    'assets/images/home.png',
                    width: double.infinity,
                    height: screenHeight * 0.3,
                    fit: BoxFit.contain,
                  ),

                  SizedBox(height: screenHeight * 0.02),

                  // tombol mulai
                  SizedBox(
                    height: (screenHeight * 0.07)
                        .clamp(48.0, 60.0)
                        .toDouble(),
                    child: ElevatedButton(
                      onPressed: () => context.go('/quiz'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.accent,
                        foregroundColor: AppColors.text,
                      ),
                      child: Text(
                        'Mulai Kuis',
                        style: AppTextStyles.answer,
                      ),
                    ),
                  ),

                  SizedBox(
                    height: (screenHeight * 0.015)
                        .clamp(6.0, 14.0)
                        .toDouble(),
                  ),

                  // tombol ganti nama
                  OutlinedButton(
                    onPressed: () => context.go('/'),
                    child: Text(
                      'Ganti Nama',
                      style: AppTextStyles.answer,
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
