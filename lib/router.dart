import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:red_rocket_test_task/presentation/bloc/auth_bloc.dart';

import 'core/app_routes.dart';
import 'presentation/pages/home/home_page.dart';
import 'presentation/pages/login/login_page.dart';
import 'presentation/pages/splash/splash_page.dart';

class AppRouter {
  static GoRouter router = GoRouter(
    initialLocation: AppRoutePaths.splash,
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final isOnSplash = state.uri.path == AppRoutePaths.splash;
      final isOnLogin = state.uri.path == AppRoutePaths.login;
      final isOnHome = state.uri.path == AppRoutePaths.home;

      if (isOnSplash) return null;

      if (authState is AuthAuthenticated) {
        return isOnHome ? null : AppRoutePaths.home;
      }

      if (authState is AuthUnauthenticated) {
        return isOnLogin ? null : AppRoutePaths.login;
      }

      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutePaths.splash,
        name: AppRouteNames.splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: AppRoutePaths.login,
        name: AppRouteNames.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutePaths.home,
        name: AppRouteNames.home,
        builder: (context, state) => const HomePage(),
      ),
    ],
  );
}
