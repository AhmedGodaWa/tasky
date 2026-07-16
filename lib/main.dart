import 'package:flutter/material.dart';
import 'package:tasky/core/app_router.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferencesManager().init();
  final String? userName = PreferencesManager().getUserName();

  runApp(MyApp(name: userName));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.name});

  final String? name;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      home:
          //WelcomeScreen(),
          AppRouter.getStartScreen(name: name),
    );
  }
}
