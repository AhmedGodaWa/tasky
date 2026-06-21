import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final pref = await SharedPreferences.getInstance();
  final String? userName = pref.getString('userName');

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
