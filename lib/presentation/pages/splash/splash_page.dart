import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:red_rocket_test_task/l10n/l10n.dart';

import '../../../core/app_routes.dart';
import '../../../core/thema/app_colors.dart';
import '../../../core/thema/app_text_styles.dart';
import '../../bloc/auth_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void initState() {
    super.initState();
    context.read<AuthBloc>().add(const AuthStatusChecked());
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthAuthenticated) {
          Future.delayed(const Duration(milliseconds: 1500), () {
            if (mounted) context.go(AppRoutePaths.home);
          });
        } else if (state is AuthUnauthenticated) {
          Future.delayed(const Duration(milliseconds: 1500), () {
            if (mounted) context.go(AppRoutePaths.login);
          });
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.rocket_launch,
                size: 80.w,
                color: AppColors.textOnPrimary,
              ),
              SizedBox(height: 20.h),
              Text(
                context.l10n.redRocket,
                style: AppTextStyles.splashTitle,
              ),
              SizedBox(height: 8.h),
              Text(
                context.l10n.testTask,
                style: AppTextStyles.splashSubtitle,
              ),
              SizedBox(height: 40.h),
              const CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.textOnPrimary),
              ),
            ],
          ),
        ),
      ),
    );
  }
}