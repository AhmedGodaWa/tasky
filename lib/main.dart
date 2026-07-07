import 'package:flutter/material.dart';
import 'package:tasky/core/app_router.dart';
import 'package:tasky/core/services/preferences_manager.dart';

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
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFF181818),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF181818),
          foregroundColor: Color(0xFFFFFCFC),
          centerTitle: false,
          titleTextStyle: TextStyle(fontSize: 22),
        ),
      ),
      home: AppRouter.getStartScreen(name: name),
    );
  }
}
