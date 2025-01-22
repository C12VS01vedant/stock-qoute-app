import 'package:app/features/authentication/domain/repositories/auth_repositories.dart';

class Login {
  final AuthRepository repository;

  Login(this.repository);

  Future<String> call(String email, String password) {
    return repository.login(email, password);
  }
}
