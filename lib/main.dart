
import 'package:flutter/material.dart';

import 'config/app_theme.dart';
import 'config/routes.dart';

void main() {
  runApp(const QuizApp());
}

class QuizApp extends StatelessWidget {
  const QuizApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'Kuis Interaktif',
      theme: AppTheme.lightTheme,
      routerConfig: appRouter,
    );
  }
}
