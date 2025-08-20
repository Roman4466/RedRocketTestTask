// lib/presentation/widgets/error_toast.dart
import 'package:flutter/material.dart';

import '../../core/error/app_error.dart';
import '../../core/error/error_localizer.dart';
import '../../core/thema/app_colors.dart';

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
        content: Text(localizedMessage),
        backgroundColor: AppColors.error,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        action: error.isRetryable && onRetry != null
            ? SnackBarAction(
                label: retryText,
                textColor: Colors.white,
                onPressed: () {
                  ScaffoldMessenger.of(context).hideCurrentSnackBar();
                  onRetry();
                },
              )
            : null,
      ),
    );
  }
}
