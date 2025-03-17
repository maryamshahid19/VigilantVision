import 'package:flutter/material.dart';
import 'package:vigilant_vision/mainlayout.dart';
import 'package:vigilant_vision/screens/alerts_screen.dart';
import 'package:vigilant_vision/screens/assigned_alerts_screen.dart';
import 'package:vigilant_vision/screens/generate_alerts_screen.dart';
import 'package:vigilant_vision/screens/login_screen.dart';
import 'package:vigilant_vision/screens/signup_screen.dart';
import 'package:vigilant_vision/screens/splash_screen.dart';
//import 'package:vigilant_vision/screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Vigilant Vision',
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/signup': (context) => const SignUpScreen(),
        '/login': (context) => const LogInScreen(),
        '/home': (context) => const MainLayout(),
      },
    );
  }
}
