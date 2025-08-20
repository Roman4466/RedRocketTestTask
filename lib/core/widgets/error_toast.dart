import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/error/app_error.dart';
import '../../core/error/error_localizer.dart';
import '../error/error_codes.dart';
import '../thema/app_colors.dart';
import '../thema/app_text_styles.dart';

class ErrorToast {
  static void show(
    BuildContext context, {
    required AppError error,
    VoidCallback? onRetry,
    Duration duration = const Duration(seconds: 6),
  }) {
    final localizedMessage = ErrorLocalizer.getLocalizedMessage(context, error);
    final retryText = ErrorLocalizer.getRetryButtonText(context, error);

    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: _ErrorToastContent(
          error: error,
          message: localizedMessage,
          retryText: retryText,
          onRetry: onRetry,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        padding: EdgeInsets.zero,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: EdgeInsets.all(16.w),
      ),
    );
  }
}

class _ErrorToastContent extends StatelessWidget {
  final AppError error;
  final String message;
  final String retryText;
  final VoidCallback? onRetry;

  const _ErrorToastContent({
    required this.error,
    required this.message,
    required this.retryText,
    this.onRetry,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: _getBackgroundColor(),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header with icon and title
          Row(
            children: [
              Icon(_getErrorIcon(), color: _getIconColor(), size: 20.w),
              SizedBox(width: 8.w),
              Expanded(
                child: Text(
                  ErrorLocalizer.getLocalizedMessage(context, error),
                  style: AppTextStyles.h6.copyWith(color: _getTextColor()),
                ),
              ),
              if (error.isRetryable && onRetry != null)
                GestureDetector(
                  onTap: () {
                    ScaffoldMessenger.of(context).hideCurrentSnackBar();
                    onRetry?.call();
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                    decoration: BoxDecoration(
                      color: _getRetryButtonColor(),
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    child: Text(
                      retryText,
                      style: AppTextStyles.bodySmall.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          SizedBox(height: 8.h),
          Text(
            message,
            style: AppTextStyles.bodyMedium.copyWith(color: _getTextColor().withValues(alpha: 0.9)),
          ),

          if (!error.isRetryable && _shouldShowAdditionalActions())
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () => ScaffoldMessenger.of(context).hideCurrentSnackBar(),
                    child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(color: _getTextColor().withValues(alpha: 0.3)),
                        borderRadius: BorderRadius.circular(8.r),
                      ),
                      child: Text(
                        'Dismiss',
                        style: AppTextStyles.bodySmall.copyWith(
                          color: _getTextColor().withValues(alpha: 0.8),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  IconData _getErrorIcon() {
    switch (error.code) {
      case AppErrorCode.noConnection:
      case AppErrorCode.connectionTimeout:
      case AppErrorCode.serverTimeout:
        return Icons.wifi_off;

      case AppErrorCode.invalidCredentials:
      case AppErrorCode.accountLocked:
      case AppErrorCode.unauthorizedAccess:
        return Icons.lock_outline;

      case AppErrorCode.serverError:
      case AppErrorCode.serviceUnavailable:
        return Icons.error_outline;

      case AppErrorCode.rateLimitExceeded:
        return Icons.timer_outlined;

      default:
        return Icons.warning_outlined;
    }
  }

  Color _getBackgroundColor() {
    if (error.isRetryable) {
      return AppColors.warning.withValues(alpha: 0.1);
    }

    switch (error.code) {
      case AppErrorCode.invalidCredentials:
      case AppErrorCode.accountLocked:
        return AppColors.error.withValues(alpha: 0.1);
      default:
        return AppColors.error.withValues(alpha: 0.1);
    }
  }

  Color _getIconColor() {
    if (error.isRetryable) {
      return AppColors.warning;
    }
    return AppColors.error;
  }

  Color _getTextColor() {
    if (error.isRetryable) {
      return AppColors.warning.withValues(alpha: 0.9);
    }
    return AppColors.error.withValues(alpha: 0.9);
  }

  Color _getRetryButtonColor() {
    return error.isRetryable ? AppColors.primary : AppColors.error;
  }

  bool _shouldShowAdditionalActions() {
    return error.code == AppErrorCode.invalidCredentials ||
        error.code == AppErrorCode.accountLocked ||
        error.code == AppErrorCode.accountNotFound;
  }
}
