import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigilant_vision/bloc/auth_bloc.dart';
import 'package:vigilant_vision/mainlayout.dart';
import 'package:vigilant_vision/repositories/auth_repository.dart';
import 'package:vigilant_vision/screens/login_screen.dart';
import 'package:vigilant_vision/screens/signup_screen.dart';
import 'package:vigilant_vision/screens/splash_screen.dart';
//import 'package:vigilant_vision/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(authRepository: AuthRepository()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vigilant Vision',
        initialRoute: '/',
        routes: {
          '/': (context) => const SplashScreen(),
          '/signup': (context) => const SignUpScreen(),
          '/login': (context) => const LogInScreen(),
          '/home': (context) => const MainLayout(),
        },
      ),
    );
  }
}
