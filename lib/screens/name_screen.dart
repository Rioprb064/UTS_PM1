import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../state/quiz_controller.dart';
import '../widgets/theme_toggle_button.dart';
import '../config/app_assets.dart';

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
      setState(() {
        _showError = true;
      });
      return;
    }

    final name = _name.trim();

    context.read<QuizController>().setUserName(name);

    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: Theme.of(context).colorScheme.primary,

            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.02,
                ),

                child: SizedBox(
                  width: double.infinity,
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
                      Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: const ThemeToggleButton(compact: true),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.02),

          Container(
            child: Text(
              'SELAMAT DATANG!',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),

          SizedBox(height: screenHeight * 0.02),

          Container(
            child: Image.asset(
              AppAssets.welcome,
              width: screenWidth * 0.5,
              height: screenHeight * 0.18,
              fit: BoxFit.contain,
            ),
          ),

          Expanded(
            child: SafeArea(
              top: false,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  final isLargeScreen =
                      constraints.maxWidth > 600;

                  final contentWidth = isLargeScreen
                      ? 420.0
                      : constraints.maxWidth;

                  return SingleChildScrollView(
                    child: Center(
                      child: Container(
                        width: contentWidth,
                        padding: EdgeInsets.symmetric(
                          horizontal: screenWidth * 0.06,
                          vertical: screenHeight * 0.05,
                        ),

                        child: Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.stretch,
                          children: [

                            // Judul input
                            Text(
                              'Siapa nama kamu?',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.headlineMedium,
                            ),

                            SizedBox(
                              height: screenHeight * 0.02,
                            ),

                            // Petunjuk
                            Text(
                              'Sebelum lanjut, masukkan nama kamu dulu.',
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),

                            SizedBox(
                              height: screenHeight * 0.04,
                            ),

                            // Input nama
                            TextField(
                              maxLength: 30,
                              textCapitalization:
                              TextCapitalization.words,
                              style: Theme.of(context).textTheme.bodyLarge,

                              onChanged: (value) {
                                setState(() {
                                  _name = value;
                                  _showError = false;
                                });
                              },

                              decoration: InputDecoration(
                                hintText: 'Masukkan nama',
                                hintStyle:
                                Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                                ),


                                filled: true,
                                fillColor: Theme.of(context).colorScheme.surface,

                                prefixIcon: Icon(
                                  Icons.person_outline,
                                  color: Theme.of(context).colorScheme.tertiary,
                                ),

                                border: OutlineInputBorder(
                                  borderRadius:
                                  BorderRadius.circular(
                                    screenWidth * 0.1,
                                  ),
                                ),
                              ),
                            ),

                            // Pesan kesalahan
                            if (_showError)
                              Text(
                                'Nama tidak boleh kosong',
                                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                  color: Theme.of(context).colorScheme.error,
                                ),
                              ),

                            SizedBox(
                              height: screenHeight * 0.03,
                            ),

                            // Tombol lanjut
                            SizedBox(
                              width: double.infinity,
                              height: (screenHeight * 0.06).clamp(48.0, 60.0).toDouble(),

                              child: ElevatedButton(
                                onPressed: _continueToHome,

                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  Theme.of(context).colorScheme.primary,
                                  foregroundColor:
                                  Theme.of(context).colorScheme.onSurface,

                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                      screenWidth * 0.1,
                                    ),
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
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
