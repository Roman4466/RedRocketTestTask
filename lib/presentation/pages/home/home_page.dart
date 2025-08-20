import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:red_rocket_test_task/l10n/l10n.dart';

import '../../../core/app_routes.dart';
import '../../../core/thema/app_colors.dart';
import '../../bloc/auth_bloc.dart';
import 'widgets/home_content.dart';
import 'widgets/logout_dialog.dart';

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
              return HomeContent(user: state.user);
            } else if (state is AuthLoading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            } else {
              return const Center(child: CircularProgressIndicator(color: AppColors.primary));
            }
          },
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(context: context, builder: (context) => const LogoutDialog());
  }
}
