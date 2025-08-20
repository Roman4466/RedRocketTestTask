import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/app_error.dart';
import '../../core/error/error_codes.dart';
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
  Future<Either<AppError, LoginResponseDto>> login(String email, String password) async {
    try {
      final requestData = LoginRequestDto(email: email, password: password);
      final response = await _dio.post('$_route/login', data: requestData.toJson());

      final loginResponse = LoginResponseDto.fromJson(response.data);
      return Right(loginResponse);
    } on DioException catch (e) {
      return Left(ErrorMapper.mapDioError(e));
    } catch (e) {
      return Left(AppError(code: AppErrorCode.unknown, originalError: e, isRetryable: false));
    }
  }

  @override
  Future<Either<AppError, Unit>> logout(String token) async {
    try {
      final requestData = LogoutRequestDto(token: token);

      await _dio.post(
        '$_route/logout',
        data: requestData.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      return const Right(unit);
    } on DioException catch (e) {
      return Left(ErrorMapper.mapDioError(e));
    } catch (e) {
      return Left(AppError(code: AppErrorCode.unknown, originalError: e, isRetryable: false));
    }
  }
}
