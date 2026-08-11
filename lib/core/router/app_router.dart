import 'package:flutter/material.dart';
import 'package:tasky/features/navigation/screens/main_screen.dart';
import 'package:tasky/features/welcome/screens/welcome_screen.dart';

class AppRouter {
  static Widget getStartScreen({required String? name}) {
    if (name == null || name.isEmpty) {
      return const WelcomeScreen();
    }

    return const MainScreen();
  }
}
