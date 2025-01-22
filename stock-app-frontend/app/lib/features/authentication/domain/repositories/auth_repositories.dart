import 'package:app/features/authentication/data/models/user_model.dart';

abstract class AuthRepository {
  Future<void> signup(String username, String email, String password);
  Future<String> login(String email, String password);
  Future<UserModel> getUser(String token);
  Future<void> logout(String token);
}