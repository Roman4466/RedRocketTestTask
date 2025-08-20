import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import '../../core/error/app_error.dart';
import '../../core/error/error_codes.dart';
import '../../data/api/auth_api.dart';
import '../../data/storage/secure_storage.dart';
import '../entities/user.dart';

@injectable
class LoginUseCase {
  final AuthApi _authApi;
  final SecureStorage _secureStorage;

  const LoginUseCase(this._authApi, this._secureStorage);

  Future<Either<AppError, User>> call(String email, String password) async {
    // Input validation
    final validationError = _validateInput(email, password);
    if (validationError != null) {
      return Left(validationError);
    }

    // Call API
    final apiResult = await _authApi.login(email, password);

    return apiResult.fold(
          (error) => Left(error),
          (response) async {
        // Save tokens
        final tokenResult = await _secureStorage.saveToken(response.token);
        if (tokenResult.isLeft()) {
          return tokenResult.fold((error) => Left(error), (_) => throw Exception('Unreachable'));
        }

        final refreshTokenResult = await _secureStorage.saveRefreshToken(response.refreshToken);
        if (refreshTokenResult.isLeft()) {
          return refreshTokenResult.fold((error) => Left(error), (_) => throw Exception('Unreachable'));
        }

        // Return user
        return Right(User(
          id: response.user.id,
          email: response.user.email,
          name: response.user.name,
        ));
      },
    );
  }

  AppError? _validateInput(String email, String password) {
    if (email.isEmpty) {
      return const AppError(
        code: AppErrorCode.emailRequired,
        isRetryable: false,
      );
    }

    if (password.isEmpty) {
      return const AppError(
        code: AppErrorCode.passwordRequired,
        isRetryable: false,
      );
    }

    if (!_isValidEmail(email)) {
      return const AppError(
        code: AppErrorCode.invalidEmail,
        isRetryable: false,
      );
    }

    if (password.length < 6) {
      return const AppError(
        code: AppErrorCode.weakPassword,
        isRetryable: false,
      );
    }

    return null;
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}