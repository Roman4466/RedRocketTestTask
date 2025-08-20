import 'package:equatable/equatable.dart';
import 'error_codes.dart';

class AppError extends Equatable {
  final AppErrorCode code;
  final String message;
  final dynamic originalError;
  final bool isRetryable;
  final Map<String, dynamic>? metadata;

  const AppError({
    required this.code,
    required this.message,
    this.originalError,
    this.isRetryable = false,
    this.metadata,
  });

  const AppError.noConnection()
      : code = AppErrorCode.noConnection,
        message = 'No internet connection',
        originalError = null,
        isRetryable = true,
        metadata = null;

  const AppError.connectionTimeout()
      : code = AppErrorCode.connectionTimeout,
        message = 'Connection timeout',
        originalError = null,
        isRetryable = true,
        metadata = null;

  const AppError.invalidCredentials()
      : code = AppErrorCode.invalidCredentials,
        message = 'Invalid email or password',
        originalError = null,
        isRetryable = false,
        metadata = null;

  const AppError.serverError()
      : code = AppErrorCode.serverError,
        message = 'Server error occurred',
        originalError = null,
        isRetryable = true,
        metadata = null;

  const AppError.unknown(String errorMessage)
      : code = AppErrorCode.unknown,
        message = errorMessage,
        originalError = null,
        isRetryable = false,
        metadata = null;

  @override
  List<Object?> get props => [code, message, originalError, isRetryable, metadata];

  @override
  String toString() => 'AppError(code: $code, message: $message, isRetryable: $isRetryable)';
}