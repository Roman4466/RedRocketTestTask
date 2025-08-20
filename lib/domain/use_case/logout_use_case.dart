import 'package:injectable/injectable.dart';
import '../../data/api/auth_api.dart';
import '../../data/storage/secure_storage.dart';

@injectable
class LogoutUseCase {
  final AuthApi _authApi;
  final SecureStorage _secureStorage;

  const LogoutUseCase(this._authApi, this._secureStorage);

  Future<void> call() async {
    try {
      final token = await _secureStorage.getToken();

      if (token != null && token.isNotEmpty) {
        await _authApi.logout(token);
      }
    } catch (e) {
      print('API logout failed: ${e.toString()}');
    } finally {
      await _secureStorage.clearTokens();
    }
  }
}