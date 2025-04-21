// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'auth_event.dart';
// import 'auth_state.dart';
// import '../repositories/auth_repository.dart';

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   final AuthRepository authRepository;

//   AuthBloc({required this.authRepository}) : super(AuthInitial()) {
//     on<SignUpRequested>((event, emit) async {
//       emit(AuthLoading());
//       try {
//         await authRepository.signUp(email: event.email, password: event.password);
//         emit(AuthAuthenticated());
//       } catch (e) {
//         emit(AuthError(message: e.toString()));
//       }
//     });

//     on<LogInRequested>((event, emit) async {
//       emit(AuthLoading());
//       try {
//         await authRepository.logIn(email: event.email, password: event.password);
//         emit(AuthAuthenticated());
//       } catch (e) {
//         emit(AuthError(message: e.toString()));
//       }
//     });

//     on<LogOutRequested>((event, emit) async {
//       emit(AuthLoading());
//       await authRepository.logOut();
//       emit(AuthInitial());
//     });
//   }
// }

import 'package:flutter_bloc/flutter_bloc.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../repositories/auth_repository.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository authRepository;

  AuthBloc({required this.authRepository}) : super(AuthInitial()) {
    on<AppStarted>((event, emit) async {
      final isLoggedIn = await authRepository.isLoggedIn();
      if (isLoggedIn) {
        emit(AuthAuthenticated());
      } else {
        emit(AuthInitial());
      }
    });

    on<SignUpRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.signUp(
            email: event.email,
            password: event.password,
            fullName: event.name,
            phoneNo: event.phoneNo);
        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    on<LogInRequested>((event, emit) async {
      emit(AuthLoading());
      try {
        await authRepository.logIn(
            email: event.email, password: event.password);
        emit(AuthAuthenticated());
      } catch (e) {
        emit(AuthError(message: e.toString()));
      }
    });

    on<LogOutRequested>((event, emit) async {
      emit(AuthLoading());
      await authRepository.logOut();
      emit(AuthInitial());
    });
  }
}
