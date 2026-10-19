
import 'package:flutter/material.dart';

class AppColors {
  // terang
  static const Color primary = Color(0xFFA8D8FF);
  static const Color secondary = Color(0xFFFFF0C5);
  static const Color accent = Color(0xFFFF8C52);

  static const Color background = Color(0xFFF7F8FF);
  static const Color surface = Color(0xFFFFFFFF);
  static const Color text = Color(0xFF243049);

  // gelap
  static const Color darkPrimary = Color(0xFF365D82);
  static const Color darkSecondary = Color(0xFFF5D68C);
  static const Color darkAccent = Color(0xFFFFAD76);

  static const Color darkBackground = Color(0xFF151D2B);
  static const Color darkSurface = Color(0xFF253148);
  static const Color darkText = Color(0xFFF3F6FF);
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
  // LIGHT THEME
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Nunito',
      brightness: Brightness.light,

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

  // DARK THEME
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      fontFamily: 'Nunito',
      brightness: Brightness.dark,

      scaffoldBackgroundColor: AppColors.darkBackground,

      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.darkPrimary,
        brightness: Brightness.dark,
      ).copyWith(
        primary: AppColors.darkPrimary,
        onPrimary: AppColors.darkText,
        secondary: AppColors.darkSecondary,
        onSecondary: AppColors.darkBackground,
        tertiary: AppColors.darkAccent,
        onTertiary: AppColors.darkBackground,
        surface: AppColors.darkSurface,
        onSurface: AppColors.darkText,
      ),

      textTheme: TextTheme(
        displayLarge: AppTextStyles.appTitle.copyWith(
          color: AppColors.darkText,
        ),
        headlineMedium: AppTextStyles.pageTitle.copyWith(
          color: AppColors.darkText,
        ),
        titleLarge: AppTextStyles.question.copyWith(
          color: AppColors.darkText,
        ),
        bodyLarge: AppTextStyles.answer.copyWith(
          color: AppColors.darkText,
        ),
        bodyMedium: AppTextStyles.instruction.copyWith(
          color: AppColors.darkText,
        ),
      ),
    );
  }
}
