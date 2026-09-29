import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'data/app_data.dart';
import 'screens/about_teacher_screen.dart';
import 'screens/admin_screen.dart';
import 'screens/exam_screen.dart';
import 'screens/home_screen.dart';
import 'screens/login_screen.dart';
import 'screens/results_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key, required this.prefs});

  final SharedPreferences prefs;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'برنامج محمد القاضي التعليمي',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF1B7A4A),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF5F7F4),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1B7A4A),
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
        cardTheme: CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18),
          ),
        ),
      ),
      routes: {
        '/login': (context) => const LoginScreen(),
        '/home': (context) => const HomeScreen(),
        '/about': (context) => const AboutTeacherScreen(),
        '/admin': (context) => const AdminScreen(),
        '/results': (context) => const ResultsScreen(),
      },
      home: LoginScreen(),
    );
  }
}
