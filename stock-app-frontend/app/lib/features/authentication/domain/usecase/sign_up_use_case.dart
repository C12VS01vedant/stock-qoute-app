import 'package:app/features/authentication/domain/repositories/auth_repositories.dart';

class Signup {
  final AuthRepository repository;

  Signup(this.repository);

  Future<void> call(String username, String email, String password) async {
    await repository.signup(username, email, password);
  }
}