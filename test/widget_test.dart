
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:uts_pm1/main.dart';

void main() {
  testWidgets('QuizApp initialization test', (
      WidgetTester tester,
      ) async {
    await tester.pumpWidget(const QuizApp());

    expect(find.text('Quiz App'), findsOneWidget);
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
