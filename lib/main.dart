
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'config/app_theme.dart';
import 'config/routes.dart';
import 'state/quiz_controller.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => QuizController(),
      child: const QuizApp(),
    ),
  );
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
