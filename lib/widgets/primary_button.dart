import 'package:flutter/material.dart';
import '../config/app_theme.dart';
import '../state/theme_controller.dart';
import 'package:provider/provider.dart';

class PrimaryButton extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? height;

  const PrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeController>().isDarkMode;
    final foreground =
    isDarkMode ? AppColors.darkBackground : AppColors.text;
    return SizedBox(
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Theme.of(context).colorScheme.tertiary,
          foregroundColor: foreground,
        ),
        child: Text(
          label,
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
            color: foreground,
          ),
        ),
      ),
    );
  }
}
