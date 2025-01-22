import 'package:app/core/constant/api_uri.dart';
import 'package:app/features/authentication/data/models/user_model.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';


part 'auth_api_service.g.dart';

@RestApi(baseUrl: Url.BASE_URL)
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @POST(Url.SIGN_UP)
  Future<void> signup(@Body() Map<String, dynamic> body);

  @POST(Url.LOGIN)
  Future<String> login(@Body() Map<String, dynamic> body);

  @GET(Url.GET_DATA)
  Future<UserModel> getUser(@Header("Authorization") String token);

  @POST(Url.LOGOUT)
  Future<void> logout(@Header("Authorization") String token);
}
