
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import '../state/quiz_controller.dart';
import '../config/app_theme.dart';

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

    context.go('/home', extra: name);
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          Container(
            width: double.infinity,
            color: AppColors.primary,

            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: screenWidth * 0.04,
                  vertical: screenHeight * 0.02,
                ),

                child: Column(
                  children: [
                    Text(
                      'KUIS ASAH OTAK',
                      textAlign: TextAlign.center,
                      style: AppTextStyles.appTitle.copyWith(
                        color: AppColors.text,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.02),

          Container(
            child: Text(
              'SELAMAT DATANG!',
              textAlign: TextAlign.center,
              style: AppTextStyles.pageTitle.copyWith(
                color: AppColors.text,
              ),
            ),
          ),

          SizedBox(height: screenHeight * 0.02),

          Container(
            child: Image.asset(
              'assets/images/anak_sd.png',
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
                              style: AppTextStyles.pageTitle,
                            ),

                            SizedBox(
                              height: screenHeight * 0.02,
                            ),

                            // Petunjuk
                            Text(
                              'Sebelum lanjut, masukkan nama kamu dulu.',
                              textAlign: TextAlign.center,
                              style: AppTextStyles.instruction,
                            ),

                            SizedBox(
                              height: screenHeight * 0.04,
                            ),

                            // Input nama
                            TextField(
                              maxLength: 30,
                              textCapitalization:
                              TextCapitalization.words,
                              style: AppTextStyles.answer,

                              onChanged: (value) {
                                setState(() {
                                  _name = value;
                                  _showError = false;
                                });
                              },

                              decoration: InputDecoration(
                                hintText: 'Masukkan nama',
                                hintStyle:
                                AppTextStyles.instruction.copyWith(
                                  color: Colors.grey.shade400,
                                ),


                                filled: true,
                                fillColor: AppColors.surface,

                                prefixIcon: const Icon(
                                  Icons.person_outline,
                                  color: AppColors.accent,
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
                                style: AppTextStyles.instruction
                                    .copyWith(
                                  color: Colors.red,
                                ),
                              ),

                            SizedBox(
                              height: screenHeight * 0.03,
                            ),

                            // Tombol lanjut
                            SizedBox(
                              width: double.infinity,
                              height: screenHeight * 0.06,

                              child: ElevatedButton(
                                onPressed: _continueToHome,

                                style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                  AppColors.primary,
                                  foregroundColor:
                                  AppColors.surface,

                                  shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(
                                      screenWidth * 0.1,
                                    ),
                                  ),
                                ),

                                child: Text(
                                  'Lanjut',
                                  style: AppTextStyles.answer
                                      .copyWith(
                                    color: AppColors.text,
                                  ),
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
