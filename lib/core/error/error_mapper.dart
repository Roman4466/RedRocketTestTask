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
          isRetryable: true,
        );

      case DioExceptionType.connectionError:
        return const AppError(
          code: AppErrorCode.noConnection,
          isRetryable: true,
        );

      case DioExceptionType.badResponse:
        return _mapBadResponse(error);

      case DioExceptionType.cancel:
        return const AppError(
          code: AppErrorCode.unknown,
          isRetryable: false,
        );

      default:
        return AppError(
          code: AppErrorCode.unknown,
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
          isRetryable: false,
        );

      case 401:
        return const AppError(
          code: AppErrorCode.invalidCredentials,
          isRetryable: false,
        );

      case 403:
        return const AppError(
          code: AppErrorCode.unauthorizedAccess,
          isRetryable: false,
        );

      case 404:
        return const AppError(
          code: AppErrorCode.accountNotFound,
          isRetryable: false,
        );

      case 429:
        return const AppError(
          code: AppErrorCode.rateLimitExceeded,
          isRetryable: true,
        );

      case 500:
      case 502:
      case 503:
        return const AppError(
          code: AppErrorCode.serverError,
          isRetryable: true,
        );

      default:
        return AppError(
          code: AppErrorCode.unknown,
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
          isRetryable: false,
        );
      } else if (message.contains('format') || message.contains('invalid')) {
        return const AppError(
          code: AppErrorCode.invalidEmail,
          isRetryable: false,
        );
      }
    }

    if (message.contains('password')) {
      if (message.contains('empty')) {
        return const AppError(
          code: AppErrorCode.passwordRequired,
          isRetryable: false,
        );
      } else if (message.contains('6 characters') || message.contains('short')) {
        return const AppError(
          code: AppErrorCode.weakPassword,
          isRetryable: false,
        );
      }
    }

    return AppError(
      code: AppErrorCode.unknown,
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
          isRetryable: false,
        );
      } else if (message.contains('format') || message.contains('invalid')) {
        return const AppError(
          code: AppErrorCode.invalidEmail,
          isRetryable: false,
        );
      }
    }

    if (message.contains('password')) {
      if (message.contains('empty')) {
        return const AppError(
          code: AppErrorCode.passwordRequired,
          isRetryable: false,
        );
      } else if (message.contains('6 characters') || message.contains('short')) {
        return const AppError(
          code: AppErrorCode.weakPassword,
          isRetryable: false,
        );
      }
    }

    return AppError(
      code: AppErrorCode.unknown,
      originalError: error,
      isRetryable: false,
    );
  }
}