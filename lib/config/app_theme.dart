
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF2866D4);
  static const Color secondary = Color(0xFFF97363);
  static const Color accent = Color(0xFFFFC857);

  static const Color background = Color(0xFFF7F8FF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color text = Color(0xFF243049);
}

class AppTextStyles {
  // Judul aplikasi
  static const TextStyle appTitle = TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 32,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
  );

  // Judul halaman
  static const TextStyle pageTitle = TextStyle(
    fontFamily: 'Fredoka',
    fontSize: 26,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  // Pertanyaan kuis
  static const TextStyle question = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 22,
    fontWeight: FontWeight.w700,
    color: AppColors.text,
  );

  // Pilihan jawaban
  static const TextStyle answer = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 19,
    fontWeight: FontWeight.w600,
    color: AppColors.text,
  );

  // Petunjuk atau deskripsi
  static const TextStyle instruction = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 17,
    fontWeight: FontWeight.w400,
    color: AppColors.text,
  );
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,

      // Default font
      fontFamily: 'Nunito',

      // Global colors
      scaffoldBackgroundColor: AppColors.background,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
      ).copyWith(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.accent,
        surface: AppColors.surface,
        onSurface: AppColors.text,
        onPrimary: Colors.white,
      ),

      // Global typography
      textTheme: const TextTheme(
        displayLarge: AppTextStyles.appTitle,
        headlineMedium: AppTextStyles.pageTitle,
        titleLarge: AppTextStyles.question,
        bodyLarge: AppTextStyles.answer,
        bodyMedium: AppTextStyles.instruction,
      ),

      // AppBar
      appBarTheme: const AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.text,
        centerTitle: true,
        elevation: 0,
        titleTextStyle: AppTextStyles.pageTitle,
      ),

      // Card
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),

      // Filled Button
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          textStyle: AppTextStyles.answer.copyWith(
            color: Colors.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
        ),
      ),

      // Input field
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        hintStyle: AppTextStyles.instruction,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: const BorderSide(
            color: AppColors.primary,
            width: 2,
          ),
        ),
      ),

      // Progress bar
      progressIndicatorTheme:
      const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.background,
      ),
    );
  }
}
