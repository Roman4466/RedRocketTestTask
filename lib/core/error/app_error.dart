import 'package:equatable/equatable.dart';

import 'error_codes.dart';

class AppError extends Equatable {
  final AppErrorCode code;
  final dynamic originalError;
  final bool isRetryable;

  const AppError({required this.code, this.originalError, this.isRetryable = false});

  const AppError.noConnection()
    : code = AppErrorCode.noConnection,
      originalError = null,
      isRetryable = true;

  const AppError.connectionTimeout()
    : code = AppErrorCode.connectionTimeout,
      originalError = null,
      isRetryable = true;

  const AppError.invalidCredentials()
    : code = AppErrorCode.invalidCredentials,
      originalError = null,
      isRetryable = false;

  const AppError.serverError()
    : code = AppErrorCode.serverError,
      originalError = null,
      isRetryable = true;

  const AppError.unknown(String errorMessage)
    : code = AppErrorCode.unknown,
      originalError = null,
      isRetryable = false;

  @override
  List<Object?> get props => [code, originalError, isRetryable];

  @override
  String toString() => 'AppError(code: $code, isRetryable: $isRetryable)';
}
