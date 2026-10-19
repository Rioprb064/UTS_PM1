import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../state/theme_controller.dart';

class ThemeToggleButton extends StatelessWidget {
  final bool compact;

  const ThemeToggleButton({super.key, this.compact = false});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = context.watch<ThemeController>().isDarkMode;
    return IconButton(
      padding: compact ? EdgeInsets.zero : null,
      constraints: compact
          ? const BoxConstraints(minWidth: 40, minHeight: 40)
          : null,
      onPressed: () => context.read<ThemeController>().toggleTheme(),
      icon: Icon(
        isDarkMode ? Icons.light_mode : Icons.dark_mode,
        color: Theme.of(context).colorScheme.onSurface,
        size: 28,
      ),
      tooltip: isDarkMode ? 'Aktifkan Mode Terang' : 'Aktifkan Mode Gelap',
    );
  }
}
