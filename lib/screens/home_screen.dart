import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/app_assets.dart';
import '../widgets/responsive_container.dart';
import '../widgets/primary_button.dart';
import '../state/quiz_controller.dart';
import '../widgets/theme_toggle_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;
    final userName = context.watch<QuizController>().userName;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,

      // header
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        toolbarHeight: (screenHeight * 0.09).clamp(56.0, 76.0).toDouble(),
        leading: const SizedBox(width: 56),
        title: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            'KUIS ASAH OTAK',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.displayLarge,
          ),
        ),
        actions: [
          const ThemeToggleButton(),
          const SizedBox(width: 8),
        ],
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
          child: ResponsiveContainer(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Halo, $userName!',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium,
                ),

                SizedBox(height: screenHeight * 0.01),

                Text(
                  'Sudah siap untuk memulai kuis?',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),

                SizedBox(height: screenHeight * 0.01),

                Image.asset(
                  AppAssets.home,
                  width: double.infinity,
                  height: screenHeight * 0.3,
                  fit: BoxFit.contain,
                ),

                SizedBox(height: screenHeight * 0.02),

                // tombol mulai
                PrimaryButton(
                  label: 'Mulai Kuis',
                  height: (screenHeight * 0.07).clamp(48.0, 60.0).toDouble(),
                  onPressed: () => context.go('/quiz'),
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
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
