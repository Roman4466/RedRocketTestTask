import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/app_error.dart';
import '../../core/error/error_codes.dart';
import '../../data/api/auth_api.dart';
import '../../data/storage/secure_storage.dart';

@injectable
class LogoutUseCase {
  final AuthApi _authApi;
  final SecureStorage _secureStorage;

  const LogoutUseCase(this._authApi, this._secureStorage);

  Future<Either<AppError, Unit>> call() async {
    final tokenResult = await _secureStorage.getToken();

    return tokenResult.fold((error) => Left(error), (token) async {
      AppError? apiError;

      if (token != null && token.isNotEmpty) {
        final logoutResult = await _authApi.logout(token);
        if (logoutResult.isLeft()) {
          apiError = logoutResult.fold((error) => error, (_) => null);
        }
      }

      final clearResult = await _secureStorage.clearTokens();

      return clearResult.fold((error) => Left(error), (_) {
        if (apiError != null) {
          if (apiError.code == AppErrorCode.noConnection ||
              apiError.code == AppErrorCode.connectionTimeout) {
            return const Right(unit);
          }
          return Left(apiError);
        }
        return const Right(unit);
      });
    });
  }
}
