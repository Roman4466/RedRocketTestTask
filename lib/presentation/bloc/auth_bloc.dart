import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../core/error/app_error.dart';
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

  AuthEvent? _lastAction;

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
    on<AuthRetryLastAction>(_onRetryLastAction);
  }

  Future<void> _onLoginRequested(AuthLoginRequested event, Emitter<AuthState> emit) async {
    _lastAction = event;
    emit(const AuthLoading());

    final result = await _loginUseCase.call(event.email, event.password);

    result.fold((error) => emit(AuthError(error: error, lastAction: event)), (user) {
      emit(AuthAuthenticated(user: user));
      _lastAction = null;
    });
  }

  Future<void> _onLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    _lastAction = event;
    emit(const AuthLoading());

    final result = await _logoutUseCase.call();

    result.fold((error) => emit(AuthError(error: error, lastAction: event)), (_) {
      emit(const AuthUnauthenticated());
      _lastAction = null;
    });
  }

  Future<void> _onStatusChecked(AuthStatusChecked event, Emitter<AuthState> emit) async {
    _lastAction = event;

    final authResult = await _checkAuthStatusUseCase.call();

    await authResult.fold(
      (error) async {
        emit(AuthError(error: error, lastAction: event));
      },
      (isAuthenticated) async {
        if (isAuthenticated) {
          final userResult = await _getCurrentUserUseCase.call();
          userResult.fold((error) => emit(AuthError(error: error, lastAction: event)), (user) {
            if (user != null) {
              emit(AuthAuthenticated(user: user));
              _lastAction = null;
            } else {
              emit(const AuthUnauthenticated());
              _lastAction = null;
            }
          });
        } else {
          emit(const AuthUnauthenticated());
          _lastAction = null;
        }
      },
    );
  }

  Future<void> _onUserRequested(AuthUserRequested event, Emitter<AuthState> emit) async {
    _lastAction = event;

    final result = await _getCurrentUserUseCase.call();

    result.fold((error) => emit(AuthError(error: error, lastAction: event)), (user) {
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(const AuthUnauthenticated());
      }
      _lastAction = null;
    });
  }

  Future<void> _onRetryLastAction(AuthRetryLastAction event, Emitter<AuthState> emit) async {
    final lastAction = _lastAction;
    if (lastAction != null) {
      add(lastAction);
    }
  }
}
