import 'package:flutter/material.dart';
import 'package:tasky/core/theme/app_colors.dart';

class AppTheme {
  AppTheme._();

  static ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,

    scaffoldBackgroundColor: AppColors.lightBackground,

    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      onPrimary: AppColors.white,

      surface: AppColors.lightSurface,
      onSurface: AppColors.lightTextPrimary,

      outline: AppColors.lightBorder,

      error: Colors.red,
      onError: AppColors.white,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.lightBackground,
      foregroundColor: AppColors.lightTextPrimary,
      centerTitle: false,
      titleSpacing: 0,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: AppColors.lightTextPrimary,
      ),
    ),

    disabledColor: AppColors.lightDisabledText,
    dividerColor: AppColors.lightProgressTrack,

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
    ),

    textTheme: const TextTheme(
      displayMedium: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        color: AppColors.lightTextPrimary,
      ),

      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: AppColors.lightTextPrimary,
      ),

      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: AppColors.lightTextPrimary,
      ),

      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.lightTextPrimary,
      ),

      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.lightTextPrimary,
      ),

      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.lightTextPrimary,
      ),

      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.lightTextSecondary,
      ),

      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.lightSurface,

      hintStyle: TextStyle(color: AppColors.lightHintText, fontSize: 14),

      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: AppColors.lightBorder),
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: AppColors.lightBorder),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide(color: AppColors.lightBorder),
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),

        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.lightBackground,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.lightTextSecondary,
    ),

    splashFactory: NoSplash.splashFactory,

    checkboxTheme: CheckboxThemeData(
      side: const BorderSide(color: AppColors.lightBorder, width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }

        return null;
      }),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColors.darkBackground,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.primary,
      onPrimary: AppColors.white,

      surface: AppColors.darkSurface,
      onSurface: AppColors.darkTextPrimary,

      outline: AppColors.darkBorder,

      error: Colors.red,
      onError: AppColors.white,
    ),

    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.darkBackground,
      foregroundColor: AppColors.darkTextPrimary,
      centerTitle: false,
      titleSpacing: 0,
      titleTextStyle: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextPrimary,
      ),
    ),

    disabledColor: AppColors.darkDisabledText,
    dividerColor: AppColors.darkProgressTrack,

    progressIndicatorTheme: const ProgressIndicatorThemeData(
      color: AppColors.primary,
    ),

    textTheme: const TextTheme(
      displayMedium: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextPrimary,
      ),

      headlineLarge: TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextPrimary,
      ),

      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextPrimary,
      ),

      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextPrimary,
      ),

      titleSmall: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextPrimary,
      ),

      bodyLarge: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextPrimary,
      ),

      bodyMedium: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: AppColors.darkTextSecondary,
      ),

      labelLarge: TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: AppColors.white,
      ),
    ),

    inputDecorationTheme: const InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurface,

      hintStyle: TextStyle(color: AppColors.darkHintText, fontSize: 14),

      contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),

      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide.none,
      ),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide.none,
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
        borderSide: BorderSide.none,
      ),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(100)),

        textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: AppColors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
    ),

    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBackground,
      selectedItemColor: AppColors.primary,
      unselectedItemColor: AppColors.darkTextSecondary,
    ),

    splashFactory: NoSplash.splashFactory,

    checkboxTheme: CheckboxThemeData(
      side: const BorderSide(color: AppColors.darkBorder, width: 2),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),

    switchTheme: SwitchThemeData(
      trackColor: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return AppColors.primary;
        }

        return null;
      }),
    ),
  );
}
