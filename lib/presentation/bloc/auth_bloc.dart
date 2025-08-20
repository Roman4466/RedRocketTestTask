import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../domain/entities/user.dart';
import '../../domain/use_case/check_auth_status_use_case.dart';
import '../../domain/use_case/get_current_user_use_case.dart';
import '../../domain/use_case/login_use_case.dart';
import '../../domain/use_case/logout_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final LogoutUseCase _logoutUseCase;
  final CheckAuthStatusUseCase _checkAuthStatusUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  AuthBloc(
    this._loginUseCase,
    this._logoutUseCase,
    this._checkAuthStatusUseCase,
    this._getCurrentUserUseCase,
  ) : super(const AuthInitial()) {
    on<AuthLoginRequested>(_onLoginRequested);
    on<AuthLogoutRequested>(_onLogoutRequested);
    on<AuthStatusChecked>(_onStatusChecked);
    on<AuthUserRequested>(_onUserRequested);
  }

  Future<void> _onLoginRequested(AuthLoginRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    try {
      final user = await _loginUseCase.call(event.email, event.password);
      emit(AuthAuthenticated(user: user));
    } on ArgumentError catch (e) {
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: _getErrorMessage(e)));
    }
  }

  Future<void> _onLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    emit(const AuthLoading());

    try {
      await _logoutUseCase.call();
      emit(const AuthUnauthenticated());
    } catch (e) {
      // Even if logout fails, clear the local state
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onStatusChecked(AuthStatusChecked event, Emitter<AuthState> emit) async {
    try {
      final isAuthenticated = await _checkAuthStatusUseCase.call();

      if (isAuthenticated) {
        final user = await _getCurrentUserUseCase.call();
        if (user != null) {
          emit(AuthAuthenticated(user: user));
        } else {
          emit(const AuthUnauthenticated());
        }
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(const AuthUnauthenticated());
    }
  }

  Future<void> _onUserRequested(AuthUserRequested event, Emitter<AuthState> emit) async {
    try {
      final user = await _getCurrentUserUseCase.call();
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(const AuthUnauthenticated());
      }
    } catch (e) {
      emit(const AuthUnauthenticated());
    }
  }

  String _getErrorMessage(dynamic error) {
    if (error is Exception) {
      final message = error.toString();
      if (message.startsWith('Exception: ')) {
        return message.substring(11); // Remove 'Exception: ' prefix
      }
      return message;
    }
    return 'An unexpected error occurred';
  }

  // Helper methods for easy state checking
  bool get isAuthenticated => state is AuthAuthenticated;

  bool get isLoading => state is AuthLoading;

  bool get hasError => state is AuthError;

  String? get errorMessage => state is AuthError ? (state as AuthError).message : null;

  // Helper method to get current user if authenticated
  User? get currentUser => state is AuthAuthenticated ? (state as AuthAuthenticated).user : null;
}
