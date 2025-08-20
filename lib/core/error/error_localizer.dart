import 'package:flutter/material.dart';
import '../../l10n/l10n.dart';
import 'app_error.dart';
import 'error_codes.dart';

class ErrorLocalizer {
  static String getLocalizedMessage(BuildContext context, AppError error) {
    final l10n = context.l10n;

    switch (error.code) {
    // Network Errors
      case AppErrorCode.noConnection:
        return l10n.errorNoConnection;
      case AppErrorCode.connectionTimeout:
        return l10n.errorConnectionTimeout;
      case AppErrorCode.serverTimeout:
        return l10n.errorServerTimeout;
      case AppErrorCode.serverError:
        return l10n.errorServerError;

    // Authentication Errors
      case AppErrorCode.invalidCredentials:
        return l10n.errorInvalidCredentials;
      case AppErrorCode.accountLocked:
        return l10n.errorAccountLocked;
      case AppErrorCode.accountNotFound:
        return l10n.errorAccountNotFound;
      case AppErrorCode.tokenExpired:
        return l10n.errorTokenExpired;
      case AppErrorCode.unauthorizedAccess:
        return l10n.errorUnauthorizedAccess;

    // Validation Errors
      case AppErrorCode.invalidEmail:
        return l10n.invalidEmailFormat;
      case AppErrorCode.weakPassword:
        return l10n.passwordMinLength;
      case AppErrorCode.emailRequired:
        return l10n.emailRequired;
      case AppErrorCode.passwordRequired:
        return l10n.passwordRequired;

    // General Errors
      case AppErrorCode.serviceUnavailable:
        return l10n.errorServiceUnavailable;
      case AppErrorCode.rateLimitExceeded:
        return l10n.errorRateLimitExceeded;
      case AppErrorCode.storageError:
        return l10n.errorStorageError;
      case AppErrorCode.tokenSaveError:
        return l10n.errorTokenSaveError;

      case AppErrorCode.unknown:
      default:
        return l10n.errorUnknown;
    }
  }

  static String getRetryButtonText(BuildContext context, AppError error) {
    final l10n = context.l10n;

    switch (error.code) {
      case AppErrorCode.noConnection:
      case AppErrorCode.connectionTimeout:
        return l10n.retryConnection;
      case AppErrorCode.serverError:
      case AppErrorCode.serverTimeout:
        return l10n.retryRequest;
      case AppErrorCode.rateLimitExceeded:
        return l10n.tryAgainLater;
      default:
        return l10n.retry;
    }
  }
}