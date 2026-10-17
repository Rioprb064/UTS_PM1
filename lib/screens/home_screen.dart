
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

    final spacing =
    (screenHeight * 0.03).clamp(12.0, 28.0).toDouble();
    final horizontalPadding =
    (screenWidth * 0.06).clamp(16.0, 40.0).toDouble();

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          // HEADER
          Container(
            width: double.infinity,
            color: AppColors.primary,
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: spacing,
                ),
                child: Text(
                  'KUIS ASAH OTAK',
                  textAlign: TextAlign.center,
                  style: AppTextStyles.appTitle,
                ),
              ),
            ),
          ),

          // BODY
          Expanded(
            child: SafeArea(
              top: false,
              child: SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: horizontalPadding,
                  vertical: spacing,
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

                        SizedBox(height: spacing * 0.3),

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

                        SizedBox(
                          height: (screenHeight * 0.07)
                              .clamp(48.0, 60.0)
                              .toDouble(),
                          child: ElevatedButton(
                            onPressed: () {},
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

                        SizedBox(height: spacing * 0.5),

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
          ),
        ],
      ),
    );
  }
}
