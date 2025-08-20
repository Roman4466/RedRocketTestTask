import '../models/login_response_dto/login_response_dto.dart';

abstract class AuthApi {
  Future<LoginResponseDto> login(String email, String password);
  Future<void> logout(String token);
}