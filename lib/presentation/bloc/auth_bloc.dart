import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

import '../../core/error/app_error.dart';
import '../../core/error/error_codes.dart';
import '../../core/error/error_mapper.dart';
import '../../domain/entities/user.dart';
import '../../domain/use_case/check_auth_status_use_case.dart';
import '../../domain/use_case/get_current_user_use_case.dart';
import '../../domain/use_case/login_use_case.dart';
import '../../domain/use_case/logout_use_case.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@injectable
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

    try {
      final user = await _loginUseCase.call(event.email, event.password);
      emit(AuthAuthenticated(user: user));
      _lastAction = null;
    } catch (e) {
      final appError = _mapToAppError(e);
      emit(AuthError(error: appError, lastAction: event));
    }
  }

  Future<void> _onLogoutRequested(AuthLogoutRequested event, Emitter<AuthState> emit) async {
    _lastAction = event;
    emit(const AuthLoading());

    try {
      await _logoutUseCase.call();
      emit(const AuthUnauthenticated());
      _lastAction = null;
    } catch (e) {
      final appError = _mapToAppError(e);
      if (appError.code == AppErrorCode.noConnection ||
          appError.code == AppErrorCode.connectionTimeout) {
        emit(const AuthUnauthenticated());
        _lastAction = null;
      } else {
        emit(AuthError(error: appError, lastAction: event));
      }
    }
  }

  Future<void> _onStatusChecked(AuthStatusChecked event, Emitter<AuthState> emit) async {
    _lastAction = event;

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
      _lastAction = null;
    } catch (e) {
      final appError = _mapToAppError(e);
      emit(AuthError(error: appError, lastAction: event));
    }
  }

  Future<void> _onUserRequested(AuthUserRequested event, Emitter<AuthState> emit) async {
    _lastAction = event;

    try {
      final user = await _getCurrentUserUseCase.call();
      if (user != null) {
        emit(AuthAuthenticated(user: user));
      } else {
        emit(const AuthUnauthenticated());
      }
      _lastAction = null;
    } catch (e) {
      final appError = _mapToAppError(e);
      emit(AuthError(error: appError, lastAction: event));
    }
  }

  Future<void> _onRetryLastAction(AuthRetryLastAction event, Emitter<AuthState> emit) async {
    final lastAction = _lastAction;
    if (lastAction != null) {
      add(lastAction);
    }
  }

  AppError _mapToAppError(dynamic error) {
    if (error is Exception) {
      return ErrorMapper.mapException(error);
    } else if (error is ArgumentError) {
      return ErrorMapper.mapArgumentError(error);
    } else {
      return AppError.unknown(error.toString());
    }
  }
}
