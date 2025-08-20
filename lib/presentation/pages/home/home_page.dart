import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:red_rocket_test_task/core/app_routes.dart';
import 'package:red_rocket_test_task/l10n/l10n.dart';

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
          backgroundColor: Colors.deepPurple,
          foregroundColor: Colors.white,
          elevation: 0,
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
              return const Center(child: CircularProgressIndicator());
            } else {
              return Center(child: Text(l10n.somethingWentWrong));
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
              gradient: LinearGradient(
                colors: [Colors.deepPurple, Colors.deepPurple.shade300],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(16.r),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.welcomeBackComma,
                  style: TextStyle(fontSize: 16.sp, color: Colors.white70),
                ),
                SizedBox(height: 4.h),
                Text(
                  user.name,
                  style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(height: 8.h),
                Row(
                  children: [
                    Icon(Icons.email_outlined, size: 16.w, color: Colors.white70),
                    SizedBox(width: 8.w),
                    Text(
                      user.email,
                      style: TextStyle(fontSize: 14.sp, color: Colors.white70),
                    ),
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),

          Text(
            l10n.quickActions,
            style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold, color: Colors.grey[800]),
          ),
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
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.red,
                side: const BorderSide(color: Colors.red),
                padding: EdgeInsets.symmetric(vertical: 12.h),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
              ),
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
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12.r),
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32.w, color: Colors.deepPurple),
              SizedBox(height: 8.h),
              Text(
                title,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[800],
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                subtitle,
                style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
                textAlign: TextAlign.center,
              ),
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
          actions: [
            TextButton(onPressed: () => Navigator.of(context).pop(), child: Text(l10n.ok)),
          ],
        );
      },
    );
  }
}