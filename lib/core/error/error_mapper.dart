import 'package:dio/dio.dart';

import 'app_error.dart';
import 'error_codes.dart';

class ErrorMapper {
  static AppError mapDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const AppError(
          code: AppErrorCode.connectionTimeout,
          message: 'Request timeout',
          isRetryable: true,
        );

      case DioExceptionType.connectionError:
        return const AppError(
          code: AppErrorCode.noConnection,
          message: 'No internet connection',
          isRetryable: true,
        );

      case DioExceptionType.badResponse:
        return _mapBadResponse(error);

      case DioExceptionType.cancel:
        return const AppError(
          code: AppErrorCode.unknown,
          message: 'Request was cancelled',
          isRetryable: false,
        );

      default:
        return AppError(
          code: AppErrorCode.unknown,
          message: error.message ?? 'Unknown network error',
          originalError: error,
          isRetryable: false,
        );
    }
  }

  static AppError _mapBadResponse(DioException error) {
    final statusCode = error.response?.statusCode;

    switch (statusCode) {
      case 400:
        return const AppError(
          code: AppErrorCode.invalidCredentials,
          message: 'Bad request',
          isRetryable: false,
        );

      case 401:
        return const AppError(
          code: AppErrorCode.invalidCredentials,
          message: 'Invalid credentials',
          isRetryable: false,
        );

      case 403:
        return const AppError(
          code: AppErrorCode.unauthorizedAccess,
          message: 'Access forbidden',
          isRetryable: false,
        );

      case 404:
        return const AppError(
          code: AppErrorCode.accountNotFound,
          message: 'Account not found',
          isRetryable: false,
        );

      case 429:
        return const AppError(
          code: AppErrorCode.rateLimitExceeded,
          message: 'Too many requests',
          isRetryable: true,
        );

      case 500:
      case 502:
      case 503:
        return const AppError(
          code: AppErrorCode.serverError,
          message: 'Server error',
          isRetryable: true,
        );

      default:
        return AppError(
          code: AppErrorCode.unknown,
          message: 'HTTP Error $statusCode',
          originalError: error,
          isRetryable: statusCode != null && statusCode >= 500,
        );
    }
  }

  static AppError mapException(Exception exception) {
    if (exception is DioException) {
      return mapDioError(exception);
    }

    if (exception is ArgumentError) {
      return _mapArgumentError(exception as ArgumentError);
    }

    return AppError(
      code: AppErrorCode.unknown,
      message: exception.toString(),
      originalError: exception,
      isRetryable: false,
    );
  }

  static AppError mapArgumentError(ArgumentError error) {
    final message = error.message.toString().toLowerCase();

    if (message.contains('email')) {
      if (message.contains('empty')) {
        return const AppError(
          code: AppErrorCode.emailRequired,
          message: 'Email is required',
          isRetryable: false,
        );
      } else if (message.contains('format') || message.contains('invalid')) {
        return const AppError(
          code: AppErrorCode.invalidEmail,
          message: 'Invalid email format',
          isRetryable: false,
        );
      }
    }

    if (message.contains('password')) {
      if (message.contains('empty')) {
        return const AppError(
          code: AppErrorCode.passwordRequired,
          message: 'Password is required',
          isRetryable: false,
        );
      } else if (message.contains('6 characters') || message.contains('short')) {
        return const AppError(
          code: AppErrorCode.weakPassword,
          message: 'Password must be at least 6 characters',
          isRetryable: false,
        );
      }
    }

    return AppError(
      code: AppErrorCode.unknown,
      message: error.message.toString(),
      originalError: error,
      isRetryable: false,
    );
  }

  static AppError _mapArgumentError(ArgumentError error) {
    final message = error.message.toString().toLowerCase();

    if (message.contains('email')) {
      if (message.contains('empty')) {
        return const AppError(
          code: AppErrorCode.emailRequired,
          message: 'Email is required',
          isRetryable: false,
        );
      } else if (message.contains('format') || message.contains('invalid')) {
        return const AppError(
          code: AppErrorCode.invalidEmail,
          message: 'Invalid email format',
          isRetryable: false,
        );
      }
    }

    if (message.contains('password')) {
      if (message.contains('empty')) {
        return const AppError(
          code: AppErrorCode.passwordRequired,
          message: 'Password is required',
          isRetryable: false,
        );
      } else if (message.contains('6 characters') || message.contains('short')) {
        return const AppError(
          code: AppErrorCode.weakPassword,
          message: 'Password must be at least 6 characters',
          isRetryable: false,
        );
      }
    }

    return AppError(
      code: AppErrorCode.unknown,
      message: error.message.toString(),
      originalError: error,
      isRetryable: false,
    );
  }
}
