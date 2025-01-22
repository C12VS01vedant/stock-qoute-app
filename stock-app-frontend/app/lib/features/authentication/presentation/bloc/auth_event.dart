part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

// Login Event
class LoginEvent extends AuthEvent {
  final String email;
  final String password;

  LoginEvent(this.email, this.password);

  @override
  List<Object?> get props => [email, password];
}

// Signup Event
class SignupEvent extends AuthEvent {
  final String username;
  final String email;
  final String password;

  SignupEvent(this.username, this.email, this.password);

  @override
  List<Object?> get props => [username, email, password];
}
