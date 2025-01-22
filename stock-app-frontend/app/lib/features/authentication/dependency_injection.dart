import 'package:app/core/dependency_injection/service_locator.dart';
import 'package:app/features/authentication/data/datasources/auth_api_service.dart';
import 'package:app/features/authentication/data/repositories/auth_repositories_impl.dart';
import 'package:app/features/authentication/domain/repositories/auth_repositories.dart';
import 'package:app/features/authentication/domain/usecase/login_use_case.dart';
import 'package:app/features/authentication/domain/usecase/sign_up_use_case.dart';
import 'package:app/features/authentication/presentation/bloc/auth_bloc.dart';

void authModule() {
  // Register API service
  sl.registerLazySingleton<AuthApiService>(() => AuthApiService(sl()));

  // Register Repository
  sl.registerLazySingleton<AuthRepository>(() => AuthRepositoryImpl(sl()));

  // Register Use Cases
  sl.registerLazySingleton(() => Login(sl()));
  sl.registerLazySingleton(() => Signup(sl())); 

  // Register BLoC
  sl.registerFactory(() => AuthBloc(sl(), sl()));
}
