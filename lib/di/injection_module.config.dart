// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:logger/logger.dart' as _i974;

import '../core/interceptors/http_logger_interceptor.dart' as _i1072;
import '../core/logger/logger_abstract.dart' as _i405;
import '../core/logger/logger_impl.dart' as _i592;
import '../data/api/auth_api.dart' as _i17;
import '../data/api/auth_api_client.dart' as _i410;
import '../data/storage/secure_storage.dart' as _i579;
import '../data/storage/secure_storage_service.dart' as _i182;
import '../domain/use_case/check_auth_status_use_case.dart' as _i884;
import '../domain/use_case/get_current_user_use_case.dart' as _i432;
import '../domain/use_case/login_use_case.dart' as _i772;
import '../domain/use_case/logout_use_case.dart' as _i235;
import 'injection_module.dart' as _i212;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.singleton<_i361.Dio>(() => registerModule.dio);
    gh.singleton<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage,
    );
    gh.lazySingleton<_i405.LoggerAbstract>(
      () => _i592.LoggerImpl(logger: gh<_i974.Logger>()),
    );
    gh.factory<_i17.AuthApi>(() => _i410.AuthApiClient(gh<_i361.Dio>()));
    gh.factoryParam<
      _i1072.HttpLoggerInterceptor,
      _i405.LoggerAbstract?,
      dynamic
    >((logger, _) => _i1072.HttpLoggerInterceptor(logger: logger));
    gh.factory<_i579.SecureStorage>(
      () => _i182.SecureStorageService(gh<_i558.FlutterSecureStorage>()),
    );
    gh.factory<_i884.CheckAuthStatusUseCase>(
      () => _i884.CheckAuthStatusUseCase(gh<_i579.SecureStorage>()),
    );
    gh.factory<_i432.GetCurrentUserUseCase>(
      () => _i432.GetCurrentUserUseCase(gh<_i579.SecureStorage>()),
    );
    gh.factory<_i772.LoginUseCase>(
      () => _i772.LoginUseCase(gh<_i17.AuthApi>(), gh<_i579.SecureStorage>()),
    );
    gh.factory<_i235.LogoutUseCase>(
      () => _i235.LogoutUseCase(gh<_i17.AuthApi>(), gh<_i579.SecureStorage>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i212.RegisterModule {}
