import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../config/app_assets.dart';
import '../state/quiz_controller.dart';
import '../widgets/responsive_container.dart';
import '../widgets/theme_toggle_button.dart';

class NameScreen extends StatefulWidget {
  const NameScreen({super.key});

  @override
  State<NameScreen> createState() => _NameScreenState();
}

class _NameScreenState extends State<NameScreen> {
  String _name = '';
  bool _showError = false;

  void _continueToHome() {
    if (_name.trim().isEmpty) {
      setState(() => _showError = true);
      return;
    }

    context.read<QuizController>().setUserName(_name.trim());
    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.sizeOf(context);
    final screenWidth = size.width;
    final screenHeight = size.height;
    final isLandscape = screenWidth > screenHeight;

    return Scaffold(
      // Saat keyboard muncul, viewport scroll mengecil alih-alih membuat
      // Column overflow pada orientasi landscape.
      resizeToAvoidBottomInset: true,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: LayoutBuilder(
        builder: (context, constraints) => SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header tetap di bagian paling atas saat halaman dibuka.
                Container(
                  width: double.infinity,
                  color: Theme.of(context).colorScheme.primary,
                  child: SafeArea(
                    bottom: false,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: screenWidth * 0.04,
                        vertical: (screenHeight * 0.02)
                            .clamp(6.0, 16.0)
                            .toDouble(),
                      ),
                      child: SizedBox(
                        height: (screenHeight * 0.065)
                            .clamp(44.0, 56.0)
                            .toDouble(),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 42),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  'KUIS ASAH OTAK',
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.displayLarge,
                                ),
                              ),
                            ),
                            const Positioned(
                              right: 0,
                              top: 0,
                              bottom: 0,
                              child: ThemeToggleButton(compact: true),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                SafeArea(
                  top: false,
                  child: Column(
                    children: [
                      SizedBox(height: screenHeight * 0.02),
                      Text(
                        'SELAMAT DATANG!',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium,
                      ),
                      SizedBox(height: screenHeight * 0.02),
                      Image.asset(
                        AppAssets.welcome,
                        width: screenWidth * 0.5,
                        height: screenHeight * (isLandscape ? 0.14 : 0.18),
                        fit: BoxFit.contain,
                      ),
                      ResponsiveContainer(
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: (screenWidth * 0.06).clamp(16.0, 32.0).toDouble(),
                            vertical: (screenHeight * 0.05).clamp(12.0, 40.0).toDouble(),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Text(
                                'Siapa nama kamu?',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.headlineMedium,
                              ),
                              SizedBox(height: screenHeight * 0.02),
                              Text(
                                'Sebelum lanjut, masukkan nama kamu dulu.',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.bodyMedium,
                              ),
                              SizedBox(height: screenHeight * 0.04),
                              TextField(
                                maxLength: 30,
                                textCapitalization: TextCapitalization.words,
                                textInputAction: TextInputAction.done,
                                scrollPadding: const EdgeInsets.only(bottom: 80),
                                style: Theme.of(context).textTheme.bodyLarge,
                                onSubmitted: (_) => _continueToHome(),
                                onChanged: (value) {
                                  setState(() {
                                    _name = value;
                                    _showError = false;
                                  });
                                },
                                decoration: InputDecoration(
                                  hintText: 'Masukkan nama',
                                  hintStyle: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                                  filled: true,
                                  fillColor: Theme.of(context).colorScheme.surface,
                                  prefixIcon: Icon(
                                    Icons.person_outline,
                                    color: Theme.of(context).colorScheme.tertiary,
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius:
                                    BorderRadius.circular(screenWidth * 0.1),
                                  ),
                                ),
                              ),
                              if (_showError)
                                Text(
                                  'Nama tidak boleh kosong',
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium
                                      ?.copyWith(
                                    color: Theme.of(context).colorScheme.error,
                                  ),
                                ),
                              SizedBox(height: screenHeight * 0.03),
                              SizedBox(
                                width: double.infinity,
                                height: (screenHeight * 0.06)
                                    .clamp(48.0, 60.0)
                                    .toDouble(),
                                child: ElevatedButton(
                                  onPressed: _continueToHome,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor:
                                    Theme.of(context).colorScheme.primary,
                                    foregroundColor:
                                    Theme.of(context).colorScheme.onSurface,
                                    shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(screenWidth * 0.1),
                                    ),
                                  ),
                                  child: Text(
                                    'Lanjut',
                                    style: Theme.of(context).textTheme.bodyLarge,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
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
