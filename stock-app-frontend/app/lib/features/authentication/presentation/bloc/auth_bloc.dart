import 'package:app/features/authentication/domain/usecase/login_use_case.dart';
import 'package:app/features/authentication/domain/usecase/sign_up_use_case.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final Login loginUseCase;
  final Signup signupUseCase; // Add Signup use case

  AuthBloc(this.loginUseCase, this.signupUseCase) : super(AuthInitial()) {
    // Login Event
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        final token = await loginUseCase(event.email, event.password);
        emit(AuthAuthenticated(token));
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });

    // Signup Event
    on<SignupEvent>((event, emit) async {
      emit(AuthLoading());
      try {
        await signupUseCase(event.username, event.email, event.password);
        emit(AuthSignupSuccess()); // Custom state for signup success
      } catch (e) {
        emit(AuthError(e.toString()));
      }
    });
  }
}
