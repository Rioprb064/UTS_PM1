
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF8AD6D1);
  static const Color secondary = Color(0xFFFFF0C5);
  static const Color accent = Color(0xFFFF8C52);

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
    fontStyle: FontStyle.normal,
    color: AppColors.text,
  );

  // Pilihan jawaban
  static const TextStyle answer = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 19,
    fontWeight: FontWeight.w600,
    fontStyle: FontStyle.normal,
    color: AppColors.text,
  );

  // Petunjuk atau deskripsi
  static const TextStyle instruction = TextStyle(
    fontFamily: 'Nunito',
    fontSize: 17,
    fontWeight: FontWeight.w400,
    fontStyle: FontStyle.normal,
    color: AppColors.text,
  );
}

class AppTheme {
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Nunito',

      scaffoldBackgroundColor: AppColors.background,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primary,
      ).copyWith(
        primary: AppColors.primary,
        secondary: AppColors.secondary,
        tertiary: AppColors.accent,
        surface: AppColors.surface,
        onSurface: AppColors.text,
      ),

      textTheme: const TextTheme(
        displayLarge: AppTextStyles.appTitle,
        headlineMedium: AppTextStyles.pageTitle,
        titleLarge: AppTextStyles.question,
        bodyLarge: AppTextStyles.answer,
        bodyMedium: AppTextStyles.instruction,
      ),
    );
  }
}