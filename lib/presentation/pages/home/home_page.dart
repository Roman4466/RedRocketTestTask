import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:red_rocket_test_task/l10n/l10n.dart';

import '../../../core/app_routes.dart';
import '../../../core/thema/app_colors.dart';
import '../../../core/thema/app_text_styles.dart';
import '../../../domain/entities/user.dart';
import '../../bloc/auth_bloc.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;

    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthUnauthenticated) {
          context.go(AppRoutePaths.login);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.home),
          actions: [
            IconButton(
              onPressed: () => _showLogoutDialog(context),
              icon: const Icon(Icons.logout),
              tooltip: l10n.logout,
            ),
          ],
        ),
        body: BlocBuilder<AuthBloc, AuthState>(
          builder: (context, state) {
            if (state is AuthAuthenticated) {
              return _buildHomeContent(context, state.user);
            } else if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            } else {
              return Center(child: Text(l10n.somethingWentWrong, style: AppTextStyles.bodyLarge));
            }
          },
        ),
      ),
    );
  }

  Widget _buildHomeContent(BuildContext context, User user) {
    final l10n = context.l10n;

    return Padding(
      padding: EdgeInsets.all(24.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(24.w),
            decoration: BoxDecoration(
              gradient: AppColors.welcomeGradient,
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(l10n.welcomeBackComma, style: AppTextStyles.welcomeBackStyle),
                SizedBox(height: 4.h),
                Text(user.name, style: AppTextStyles.userNameStyle),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.email_outlined, size: 16.w, color: AppColors.textOnSecondary),
                    SizedBox(width: 8.w),
                    Text(user.email, style: AppTextStyles.userEmailStyle),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          Text(l10n.quickActions, style: AppTextStyles.h4),
          SizedBox(height: 16.h),
          Expanded(
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 16.w,
              mainAxisSpacing: 16.h,
              children: [
                _buildFeatureCard(
                  icon: Icons.person_outline,
                  title: l10n.profile,
                  subtitle: l10n.viewProfile,
                  onTap: () => _showFeatureDialog(context, l10n.profile),
                ),
                _buildFeatureCard(
                  icon: Icons.settings_outlined,
                  title: l10n.settings,
                  subtitle: l10n.appSettings,
                  onTap: () => _showFeatureDialog(context, l10n.settings),
                ),
                _buildFeatureCard(
                  icon: Icons.analytics_outlined,
                  title: l10n.analytics,
                  subtitle: l10n.viewStats,
                  onTap: () => _showFeatureDialog(context, l10n.analytics),
                ),
                _buildFeatureCard(
                  icon: Icons.help_outline,
                  title: l10n.help,
                  subtitle: l10n.getSupport,
                  onTap: () => _showFeatureDialog(context, l10n.help),
                ),
              ],
            ),
          ),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _showLogoutDialog(context),
              icon: const Icon(Icons.logout),
              label: Text(l10n.logout),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFeatureCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32.w, color: AppColors.primary),
              SizedBox(height: 8.h),
              Text(title, style: AppTextStyles.cardTitle),
              SizedBox(height: 4.h),
              Text(subtitle, style: AppTextStyles.cardSubtitle, textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    final l10n = context.l10n;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(l10n.logoutConfirmTitle),
          content: Text(l10n.logoutConfirmMessage),
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.cancel)),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                context.read<AuthBloc>().add(const AuthLogoutRequested());
              },
              child: Text(l10n.logout),
            ),
          ],
        );
      },
    );
  }

  void _showFeatureDialog(BuildContext context, String feature) {
    final l10n = context.l10n;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(feature),
          content: Text(l10n.featureComingSoon(feature)),
          actions: [TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.ok))],
        );
      },
    );
  }
}
