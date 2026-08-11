import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasky/core/router/app_router.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/theme/app_theme.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/features/profile/controllers/user_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await PreferencesManager().init();

  ThemeController.loadTheme();

  final String? userName = PreferencesManager().getUserName();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserController(PreferencesManager()),
        ),
      ],
      child: MyApp(name: userName),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.name});

  final String? name;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<ThemeMode>(
      valueListenable: ThemeController.themeMode,
      builder: (context, themeMode, child) => MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: themeMode,
        home:
            //WelcomeScreen(),
            AppRouter.getStartScreen(name: name),
      ),
    );
  }
}
