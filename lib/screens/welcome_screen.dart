import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
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
        // backgroundColor: const Color(0xff181818),
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
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Full Name',
                            style: TextStyle(
                              color: Color(0xFFFFFCFC),
                              fontSize: 16,
                            ),
                          ),
                        ),

                        TextFormField(
                          controller: _nameController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Enter your name';
                            }

                            if (value.trim().length < 2) {
                              return 'Name must contain at least 2 letters';
                            }

                            return null;
                          },
                          cursorColor: const Color(0xFFFFFCFC),
                          style: const TextStyle(color: Color(0xFFFFFCFC)),
                          decoration: InputDecoration(
                            hintText: 'e.g. Ahmed Goda',
                            hintStyle: const TextStyle(
                              color: Color(0xFF6D6D6D),
                            ),
                            filled: true,
                            fillColor: const Color(0xFF282828),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(16),
                              borderSide: BorderSide.none,
                            ),
                            contentPadding: const EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: 16,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 24),

                    SizedBox(
                      height: 40,
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            /// Give me a copy of the SharedPrefrences stored on the device
                            final pref = await SharedPreferences.getInstance();

                            /// Instead of reading the text twice.
                            final name = _nameController.text.trim();

                            /// pref -> He still holds the application's storage file.
                            await pref.setString('userName', name);

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
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(0xFF15B86C),
                          foregroundColor: const Color(0xFFFFFCFC),
                        ),
                        child: const Text(
                          "Let’s Get Started",
                          style: TextStyle(fontSize: 14),
                        ),
                      ),
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
