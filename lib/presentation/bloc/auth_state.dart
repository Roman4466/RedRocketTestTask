part of 'auth_bloc.dart';

@immutable
abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {
  const AuthInitial();
}

class AuthLoading extends AuthState {
  const AuthLoading();
}

class AuthAuthenticated extends AuthState {
  final User user;

  const AuthAuthenticated({required this.user});

  @override
  List<Object?> get props => [user];
}

class AuthUnauthenticated extends AuthState {
  const AuthUnauthenticated();
}

class AuthError extends AuthState {
  final AppError error;
  final AuthEvent? lastAction; // Store the last action for retry

  const AuthError({required this.error, this.lastAction});

  // Convenience getter for backward compatibility
  String get message => error.message;

  @override
  List<Object?> get props => [error, lastAction];
}
