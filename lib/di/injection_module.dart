import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import '../core/interceptors/auth_token_interceptor.dart';
import '../core/interceptors/http_logger_interceptor.dart';
import '../core/interceptors/mock_auth_interceptor.dart';
import 'injection_module.config.dart';

final getIt = GetIt.instance;

@InjectableInit(initializerName: 'init', preferRelativeImports: true, asExtension: true)
void configureDependencies() => getIt.init();

@module
abstract class RegisterModule {
  @singleton
  Dio get dio {
    final dio = Dio(
      BaseOptions(
        baseUrl: dotenv.env['API_BASE_URL'] ?? 'https://jsonplaceholder.typicode.com',
        connectTimeout: Duration(milliseconds: int.parse(dotenv.env['API_TIMEOUT'] ?? '30000')),
        receiveTimeout: Duration(milliseconds: int.parse(dotenv.env['API_TIMEOUT'] ?? '30000')),
        sendTimeout: Duration(milliseconds: int.parse(dotenv.env['API_TIMEOUT'] ?? '30000')),
        headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
      ),
    );

    // Add interceptors
    dio.interceptors.add(
      LogInterceptor(
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
        logPrint: (obj) => print(obj),
      ),
    );

    dio.interceptors.add(AuthTokenInterceptor());

    dio.interceptors.add(MockAuthInterceptor());
    dio.interceptors.add(HttpLoggerInterceptor());

    return dio;
  }

  @singleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();
}
