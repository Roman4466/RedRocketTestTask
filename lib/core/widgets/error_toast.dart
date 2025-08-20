import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../core/error/app_error.dart';
import '../../core/error/error_localizer.dart';
import '../../core/thema/app_colors.dart';
import '../../core/thema/app_text_styles.dart';
import '../error/error_codes.dart';

class ErrorToast {
  static void show(
    BuildContext context, {
    required AppError error,
    VoidCallback? onRetry,
    Duration duration = const Duration(seconds: 6),
  }) {
    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;

    overlayEntry = OverlayEntry(
      builder: (context) =>
          _ErrorToastWidget(error: error, onRetry: onRetry, onDismiss: () => overlayEntry.remove()),
    );

    overlay.insert(overlayEntry);

    Future.delayed(duration, () {
      if (overlayEntry.mounted) {
        overlayEntry.remove();
      }
    });
  }
}

class _ErrorToastWidget extends StatefulWidget {
  final AppError error;
  final VoidCallback? onRetry;
  final VoidCallback onDismiss;

  const _ErrorToastWidget({required this.error, this.onRetry, required this.onDismiss});

  @override
  State<_ErrorToastWidget> createState() => _ErrorToastWidgetState();
}

class _ErrorToastWidgetState extends State<_ErrorToastWidget> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.elasticOut));

    _fadeAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localizedMessage = ErrorLocalizer.getLocalizedMessage(context, widget.error);
    final retryText = ErrorLocalizer.getRetryButtonText(context, widget.error);

    return Positioned(
      top: MediaQuery.of(context).padding.top + 16.h,
      left: 16.w,
      right: 16.w,
      child: SlideTransition(
        position: _slideAnimation,
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Material(
            color: Colors.transparent,
            child: Container(
              padding: EdgeInsets.all(16.w),
              decoration: BoxDecoration(
                color: _getBackgroundColor(),
                borderRadius: BorderRadius.circular(16.r),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.2),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
                border: Border.all(color: _getBorderColor(), width: 1),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(
                        padding: EdgeInsets.all(8.w),
                        decoration: BoxDecoration(
                          color: _getIconBackgroundColor(),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        child: Icon(_getErrorIcon(), color: _getIconColor(), size: 20.w),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Text(
                          localizedMessage,
                          style: AppTextStyles.h6.copyWith(
                            color: _getTextColor(),
                            fontSize: 14.sp,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: _dismiss,
                        child: Container(
                          padding: EdgeInsets.all(4.w),
                          child: Icon(
                            Icons.close,
                            size: 16.w,
                            color: _getTextColor().withValues(alpha: 0.6),
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (widget.error.isRetryable && widget.onRetry != null) ...[
                    SizedBox(height: 12.h),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              _dismiss();
                              widget.onRetry?.call();
                            },
                            child: Container(
                              padding: EdgeInsets.symmetric(vertical: 10.h),
                              decoration: BoxDecoration(
                                color: _getRetryButtonColor(),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(Icons.refresh, size: 16.w, color: Colors.white),
                                  SizedBox(width: 6.w),
                                  Text(
                                    retryText,
                                    style: AppTextStyles.bodySmall.copyWith(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600,
                                      fontSize: 12.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void _dismiss() async {
    await _controller.reverse();
    widget.onDismiss();
  }

  IconData _getErrorIcon() {
    switch (widget.error.code) {
      case AppErrorCode.noConnection:
      case AppErrorCode.connectionTimeout:
        return Icons.wifi_off_rounded;
      case AppErrorCode.invalidCredentials:
        return Icons.lock_outline_rounded;
      case AppErrorCode.serverError:
        return Icons.error_outline_rounded;
      default:
        return Icons.warning_rounded;
    }
  }

  Color _getBackgroundColor() {
    if (widget.error.isRetryable) {
      return AppColors.warning.withValues(alpha: 0.95);
    }
    return AppColors.error.withValues(alpha: 0.95);
  }

  Color _getBorderColor() {
    if (widget.error.isRetryable) {
      return AppColors.warning.withValues(alpha: 0.3);
    }
    return AppColors.error.withValues(alpha: 0.3);
  }

  Color _getIconBackgroundColor() {
    return Colors.white.withValues(alpha: 0.2);
  }

  Color _getIconColor() {
    return Colors.white;
  }

  Color _getTextColor() {
    return Colors.white;
  }

  Color _getRetryButtonColor() {
    return Colors.white.withValues(alpha: 0.2);
  }
}
