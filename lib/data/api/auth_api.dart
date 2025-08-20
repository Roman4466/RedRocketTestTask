import 'package:dartz/dartz.dart';

import '../../core/error/app_error.dart';
import '../models/login_response_dto/login_response_dto.dart';

abstract class AuthApi {
  Future<Either<AppError, LoginResponseDto>> login(String email, String password);

  Future<Either<AppError, Unit>> logout(String token);
}
