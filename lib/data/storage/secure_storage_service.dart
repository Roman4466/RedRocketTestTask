import 'package:dartz/dartz.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/app_error.dart';
import '../../core/error/error_codes.dart';
import 'secure_storage.dart';

@Injectable(as: SecureStorage)
class SecureStorageService implements SecureStorage {
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';

  final FlutterSecureStorage _storage;

  const SecureStorageService(this._storage);

  @override
  Future<Either<AppError, Unit>> saveToken(String token) async {
    try {
      await _storage.write(key: _tokenKey, value: token);
      return const Right(unit);
    } catch (e) {
      return Left(
        AppError(code: AppErrorCode.tokenSaveError, originalError: e, isRetryable: false),
      );
    }
  }

  @override
  Future<Either<AppError, Unit>> saveRefreshToken(String refreshToken) async {
    try {
      await _storage.write(key: _refreshTokenKey, value: refreshToken);
      return const Right(unit);
    } catch (e) {
      return Left(
        AppError(code: AppErrorCode.tokenSaveError, originalError: e, isRetryable: false),
      );
    }
  }

  @override
  Future<Either<AppError, String?>> getToken() async {
    try {
      final token = await _storage.read(key: _tokenKey);
      return Right(token);
    } catch (e) {
      return Left(AppError(code: AppErrorCode.storageError, originalError: e, isRetryable: true));
    }
  }

  @override
  Future<Either<AppError, String?>> getRefreshToken() async {
    try {
      final token = await _storage.read(key: _refreshTokenKey);
      return Right(token);
    } catch (e) {
      return Left(AppError(code: AppErrorCode.storageError, originalError: e, isRetryable: true));
    }
  }

  @override
  Future<Either<AppError, Unit>> clearTokens() async {
    try {
      await _storage.delete(key: _tokenKey);
      await _storage.delete(key: _refreshTokenKey);
      return const Right(unit);
    } catch (e) {
      return Left(AppError(code: AppErrorCode.storageError, originalError: e, isRetryable: true));
    }
  }

  @override
  Future<Either<AppError, Unit>> clearAllData() async {
    try {
      await _storage.deleteAll();
      return const Right(unit);
    } catch (e) {
      return Left(AppError(code: AppErrorCode.storageError, originalError: e, isRetryable: true));
    }
  }
}
