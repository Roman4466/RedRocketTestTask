import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:red_rocket_test_task/l10n/l10n.dart';

import '../../../../core/thema/app_text_styles.dart';
import '../../../../domain/entities/user.dart';
import 'feature_grid.dart';
import 'logout_button.dart';
import 'user_welcome_card.dart';

class HomeContent extends StatelessWidget {
  final User user;

  const HomeContent({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          UserWelcomeCard(user: user),
          SizedBox(height: 32.h),
          Text(l10n.quickActions, style: AppTextStyles.h4),
          SizedBox(height: 16.h),
          const Expanded(child: FeatureGrid()),
          const LogoutButton(),
        ],
      ),
    );
  }
}
