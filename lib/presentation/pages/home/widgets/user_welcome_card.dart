import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:red_rocket_test_task/l10n/l10n.dart';

import '../../../../core/thema/app_colors.dart';
import '../../../../core/thema/app_text_styles.dart';
import '../../../../domain/entities/user.dart';

class UserWelcomeCard extends StatelessWidget {
  final User user;

  const UserWelcomeCard({
    super.key,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(24.w),
      decoration: BoxDecoration(
        gradient: AppColors.welcomeGradient,
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "${l10n.welcomeBackComma} ${user.name}",
            style: AppTextStyles.userNameStyle,
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(
                Icons.email_outlined,
                size: 16.w,
                color: AppColors.textOnSecondary,
              ),
              SizedBox(width: 8.w),
              Text(
                user.email,
                style: AppTextStyles.userEmailStyle,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
