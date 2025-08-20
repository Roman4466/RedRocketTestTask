// lib/data/api/auth_api_client.dart
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import '../../core/error/error_mapper.dart';
import '../models/login_request_dto/login_request_dto.dart';
import '../models/login_response_dto/login_response_dto.dart';
import '../models/logout_request_dto/logout_request_dto.dart';
import 'auth_api.dart';

@Injectable(as: AuthApi)
class AuthApiClient implements AuthApi {
  final Dio _dio;
  static const String _route = '/auth';

  AuthApiClient(this._dio);

  @override
  Future<LoginResponseDto> login(String email, String password) async {
    try {
      final requestData = LoginRequestDto(email: email, password: password);

      final response = await _dio.post('$_route/login', data: requestData.toJson());

      return LoginResponseDto.fromJson(response.data);
    } on DioException catch (e) {
      final appError = ErrorMapper.mapDioError(e);
      throw Exception(appError.message);
    } catch (e) {
      throw Exception('Unexpected error during login: ${e.toString()}');
    }
  }

  @override
  Future<void> logout(String token) async {
    try {
      final requestData = LogoutRequestDto(token: token);

      await _dio.post(
        '$_route/logout',
        data: requestData.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
    } on DioException catch (e) {
      final appError = ErrorMapper.mapDioError(e);
      throw Exception(appError.message);
    } catch (e) {
      throw Exception('Unexpected error during logout: ${e.toString()}');
    }
  }
}