import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

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
      throw _handleDioError(e);
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
      throw _handleDioError(e);
    } catch (e) {
      throw Exception('Unexpected error during logout: ${e.toString()}');
    }
  }

  Exception _handleDioError(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return Exception('Connection timeout. Please check your internet connection.');

      case DioExceptionType.badResponse:
        final statusCode = e.response?.statusCode;
        switch (statusCode) {
          case 401:
            return Exception('Invalid credentials');
          case 403:
            return Exception('Access forbidden');
          case 404:
            return Exception('Service not found');
          case 500:
            return Exception('Server error. Please try again later.');
          default:
            return Exception('Request failed with status: $statusCode');
        }

      case DioExceptionType.cancel:
        return Exception('Request was cancelled');

      case DioExceptionType.connectionError:
        return Exception('No internet connection');

      default:
        return Exception('Network error: ${e.message}');
    }
  }
}
