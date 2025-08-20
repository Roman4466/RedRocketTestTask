import 'package:dio/dio.dart';

class MockAuthInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (options.path.contains('/auth/login')) {
      final requestData = options.data as Map<String, dynamic>?;
      final email = requestData?['email'] ?? 'test@example.com';

      if (email == 'invalid@test.com') {
        Future.delayed(const Duration(milliseconds: 800), () {
          handler.reject(
            DioException(
              requestOptions: options,
              response: Response(
                requestOptions: options,
                statusCode: 401,
                data: {'message': 'Invalid credentials'},
              ),
              type: DioExceptionType.badResponse,
            ),
          );
        });
        return;
      }

      final responseData = {
        'token': 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
        'refreshToken': 'mock_refresh_token_${DateTime.now().millisecondsSinceEpoch}',
        'user': {
          'id': 1,
          'email': email,
          'name': 'Test User',
        }
      };

      Future.delayed(const Duration(milliseconds: 800), () {
        handler.resolve(
          Response(
            requestOptions: options,
            data: responseData,
            statusCode: 200,
          ),
        );
      });
      return;
    }

    if (options.path.contains('/auth/logout')) {
      Future.delayed(const Duration(milliseconds: 500), () {
        handler.resolve(
          Response(
            requestOptions: options,
            statusCode: 200,
            data: {'message': 'Logged out successfully'},
          ),
        );
      });
      return;
    }

    super.onRequest(options, handler);
  }
}