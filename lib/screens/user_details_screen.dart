import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widgets/custom_text_form_field.dart';
import 'package:tasky/core/widgets/primary_button.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({super.key});

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final _userNameController = TextEditingController();
  final _motivationController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _userNameController.dispose();
    _motivationController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    _loadUserData();
    super.initState();
  }

  Future<void> _loadUserData() async {
    _userNameController.text = PreferencesManager().getUserName() ?? '';
    _motivationController.text =
        PreferencesManager().getMotivation() ??
        'One task at a time. One step closer.';
  }

  Future<void> _saveUserData() async {
    if (!_formKey.currentState!.validate()) return;

    await PreferencesManager().saveUserName(_userNameController.text.trim());
    await PreferencesManager().saveMotivation(
      _motivationController.text.trim(),
    );

    if (!mounted) return;
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(titleSpacing: 0, title: const Text('User Details')),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                CustomTextFormField(
                  controller: _userNameController,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Enter your name';
                    }
                    return null;
                  },
                  title: 'User Name',
                  hintText: 'Ahmed Goda',
                  textInputAction: TextInputAction.next,
                  borderSide: const BorderSide(color: Color(0xFF6E6E6E)),
                ),

                const SizedBox(height: 20),

                CustomTextFormField(
                  maxLines: 5,
                  controller: _motivationController,
                  title: 'Motivation Quote',
                  hintText: 'One task at a time. One step closer.',
                  textInputAction: TextInputAction.done,
                  borderSide: const BorderSide(color: Color(0xFF6E6E6E)),
                ),

                const Spacer(),
                PrimaryButton(text: 'Save Changes', onPressed: _saveUserData),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
