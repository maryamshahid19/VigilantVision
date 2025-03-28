import 'package:equatable/equatable.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class SignUpRequested extends AuthEvent {
  final String email;
  final String password;

  SignUpRequested({required this.email, required this.password});
}

class LogInRequested extends AuthEvent {
  final String email;
  final String password;

  LogInRequested({required this.email, required this.password});
}

class LogOutRequested extends AuthEvent {}
