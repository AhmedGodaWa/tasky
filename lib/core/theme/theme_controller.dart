import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';

class ThemeController {
  ThemeController._();

  // A place to store the theme state.
  static final ValueNotifier<ThemeMode> themeMode = ValueNotifier(
    ThemeMode.dark,
  );

  // How to change the status.
  static Future<void> toggleTheme(bool isDark) async {
    themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;

    await PreferencesManager().saveTheme(isDark);
  }

  static void loadTheme() {
    final isDark = PreferencesManager().getTheme();

    themeMode.value = isDark ? ThemeMode.dark : ThemeMode.light;
  }
}
