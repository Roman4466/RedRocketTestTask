import 'package:dartz/dartz.dart';

import '../../core/error/app_error.dart';

abstract class SecureStorage {
  Future<Either<AppError, Unit>> saveToken(String token);

  Future<Either<AppError, Unit>> saveRefreshToken(String refreshToken);

  Future<Either<AppError, String?>> getToken();

  Future<Either<AppError, String?>> getRefreshToken();

  Future<Either<AppError, Unit>> clearTokens();

  Future<Either<AppError, Unit>> clearAllData();
}
