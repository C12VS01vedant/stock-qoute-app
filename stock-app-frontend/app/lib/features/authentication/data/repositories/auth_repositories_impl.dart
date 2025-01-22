import 'package:app/features/authentication/data/datasources/auth_api_service.dart';
import 'package:app/features/authentication/data/models/user_model.dart';
import 'package:app/features/authentication/domain/repositories/auth_repositories.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthApiService apiService;

  AuthRepositoryImpl(this.apiService);

  @override
  Future<void> signup(String username, String email, String password) async {
    await apiService.signup({
      "username": username,
      "email": email,
      "password": password,
    });
  }

  @override
  Future<String> login(String email, String password) async {
    return await apiService.login({
      "email": email,
      "password": password,
    });
  }

  @override
  Future<UserModel> getUser(String token) async {
    return await apiService.getUser("Bearer $token");
  }

  @override
  Future<void> logout(String token) async {
    await apiService.logout("Bearer $token");
  }
}