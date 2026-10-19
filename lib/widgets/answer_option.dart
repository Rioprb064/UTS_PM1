import 'package:flutter/material.dart';

class AnswerOption extends StatelessWidget {
  final int index;
  final String answer;
  final bool isSelected;
  final VoidCallback onPressed;

  const AnswerOption({
    super.key,
    required this.index,
    required this.answer,
    required this.isSelected,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    return Padding(
      padding: EdgeInsets.only(bottom: screenSize.height * 0.015),
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          backgroundColor: isSelected
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.surface,
          foregroundColor: Theme.of(context).colorScheme.onSurface,
          padding: EdgeInsets.symmetric(
            horizontal: screenSize.width * 0.04,
            vertical: screenSize.height * 0.02,
          ),
        ),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            '${String.fromCharCode(65 + index)}. $answer',
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
