import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vigilant_vision/bloc/auth_bloc.dart';
import 'package:vigilant_vision/bloc/auth_event.dart';
import 'package:vigilant_vision/bloc/auth_state.dart';
import 'package:vigilant_vision/mainlayout.dart';
import 'package:vigilant_vision/repositories/auth_repository.dart';
import 'package:vigilant_vision/screens/login_screen.dart';
import 'package:vigilant_vision/screens/signup_screen.dart';
import 'package:vigilant_vision/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp(authRepository: AuthRepository()));
}

class MyApp extends StatelessWidget {
  final AuthRepository authRepository;

  const MyApp({super.key, required this.authRepository});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AuthBloc(authRepository: authRepository)..add(AppStarted()),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Vigilant Vision',
        home: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            //if (state is AuthAuthenticated) {
            //  return const SignUpScreen(); // Navigate to home if authenticated
            //} else {
            return const LogInScreen(); // Otherwise, show login screen
            // }
          },
        ),
        routes: {
          '/signup': (context) => const SignUpScreen(),
          '/login': (context) => const LogInScreen(),
          '/home': (context) => const MainLayout(),
        },
      ),
    );
  }
}
