import 'package:equatable/equatable.dart';
import 'error_codes.dart';

class AppError extends Equatable {
  final AppErrorCode code;
  final dynamic originalError;
  final bool isRetryable;
  final Map<String, dynamic>? metadata;

  const AppError({
    required this.code,
    this.originalError,
    this.isRetryable = false,
    this.metadata,
  });

  const AppError.noConnection()
      : code = AppErrorCode.noConnection,
        originalError = null,
        isRetryable = true,
        metadata = null;

  const AppError.connectionTimeout()
      : code = AppErrorCode.connectionTimeout,
        originalError = null,
        isRetryable = true,
        metadata = null;

  const AppError.invalidCredentials()
      : code = AppErrorCode.invalidCredentials,
        originalError = null,
        isRetryable = false,
        metadata = null;

  const AppError.serverError()
      : code = AppErrorCode.serverError,
        originalError = null,
        isRetryable = true,
        metadata = null;

  const AppError.unknown(String errorMessage)
      : code = AppErrorCode.unknown,
        originalError = null,
        isRetryable = false,
        metadata = null;

  @override
  List<Object?> get props => [code, originalError, isRetryable, metadata];

  @override
  String toString() => 'AppError(code: $code, isRetryable: $isRetryable)';
}