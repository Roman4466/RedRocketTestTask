import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:red_rocket_test_task/presentation/bloc/auth_bloc.dart';

import 'presentation/pages/home_page.dart';
import 'presentation/pages/login_page.dart';
import 'presentation/pages/splash_page.dart';

class AppRouter {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String home = '/home';

  static GoRouter router = GoRouter(
    initialLocation: splash,
    redirect: (context, state) {
      final authState = context.read<AuthBloc>().state;
      final isOnSplash = state.uri.path == splash;
      final isOnLogin = state.uri.path == login;
      final isOnHome = state.uri.path == home;

      if (isOnSplash) return null;

      if (authState is AuthAuthenticated) {
        return isOnHome ? null : home;
      }

      if (authState is AuthUnauthenticated) {
        return isOnLogin ? null : login;
      }

      return null;
    },
    routes: [
      GoRoute(path: splash, name: 'splash', builder: (context, state) => const SplashPage()),
      GoRoute(path: login, name: 'login', builder: (context, state) => const LoginPage()),
      GoRoute(path: home, name: 'home', builder: (context, state) => const HomePage()),
    ],
  );
}
