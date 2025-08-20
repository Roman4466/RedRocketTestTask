import 'package:dio/dio.dart';

import '../../data/storage/secure_storage.dart';
import '../../di/injection_module.dart';

class AuthTokenInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    if (options.path.contains('/auth/login')) {
      return handler.next(options);
    }

    try {
      final secureStorage = getIt<SecureStorage>();
      final tokenResult = await secureStorage.getToken();

      tokenResult.fold(
        (error) {
          print('Error getting auth token: $error');
        },
        (token) {
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
        },
      );
    } catch (e) {
      print('Error adding auth token: $e');
    }

    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      _clearTokensOnUnauthorized();
    }

    handler.next(err);
  }

  void _clearTokensOnUnauthorized() async {
    try {
      final secureStorage = getIt<SecureStorage>();
      await secureStorage.clearTokens();
    } catch (e) {
      print('Error clearing tokens on 401: $e');
    }
  }
}
