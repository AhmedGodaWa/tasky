import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/core/widgets/primary_button.dart';
import 'package:tasky/screens/main_screen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  final _nameController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: FocusScope.of(context).unfocus,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          'assets/images/tasky_logo.svg',
                          height: 42,
                          width: 42,
                        ),
                        const SizedBox(width: 16),
                        const Text(
                          'Tasky',
                          style: TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.w400,
                            color: Color(0xFFFFFCFC),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 108),
                    const Text(
                      'Welcome To Tasky',
                      style: TextStyle(
                        color: Color(0xFFFFFCFC),
                        fontSize: 24,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'Your productivity journey starts here.',
                      style: TextStyle(
                        color: Color(0xFFFFFCFC),
                        fontSize: 16,
                        letterSpacing: 0.5,
                      ),
                    ),
                    const SizedBox(height: 24),
                    SvgPicture.asset(
                      'assets/images/onboarding_illustration.svg',
                      height: 205,
                      width: 215,
                    ),
                    const SizedBox(height: 24),

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CustomTextFormField(
                          controller: _nameController,
                          title: 'Full Name',
                          hintText: 'e.g. Ahmed Goda',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your name';
                            }

                            if (value.trim().length < 2) {
                              return 'Name must contain at least 2 letters';
                            }

                            return null;
                          },
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    PrimaryButton(
                      text: "Let’s Get Started",
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          /// Instead of reading the text twice.
                          final name = _nameController.text.trim();

                          // PreferencesManager uses the same SharedPreferences instance
                          // to save the username locally.
                          await PreferencesManager().saveUserName(name);

                          if (!context.mounted) return;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const MainScreen(),
                            ),
                          );
                        } else {
                          return;
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
