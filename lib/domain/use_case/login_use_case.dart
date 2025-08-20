import 'package:injectable/injectable.dart';
import '../../data/api/auth_api.dart';
import '../../data/storage/secure_storage.dart';
import '../entities/user.dart';

@injectable
class LoginUseCase {
  final AuthApi _authApi;
  final SecureStorage _secureStorage;

  const LoginUseCase(this._authApi, this._secureStorage);

  Future<User> call(String email, String password) async {
    if (email.isEmpty) {
      throw ArgumentError('Email cannot be empty');
    }

    if (password.isEmpty) {
      throw ArgumentError('Password cannot be empty');
    }

    if (!_isValidEmail(email)) {
      throw ArgumentError('Invalid email format');
    }

    if (password.length < 6) {
      throw ArgumentError('Password must be at least 6 characters');
    }

    try {
      final response = await _authApi.login(email, password);

      await _secureStorage.saveToken(response.token);
      await _secureStorage.saveRefreshToken(response.refreshToken);

      return User(
        id: response.user.id,
        email: response.user.email,
        name: response.user.name,
      );
    } catch (e) {
      throw Exception('Login failed: ${e.toString()}');
    }
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }
}