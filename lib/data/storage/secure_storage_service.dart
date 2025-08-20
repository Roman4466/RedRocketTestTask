import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

import 'secure_storage.dart';

@Injectable(as: SecureStorage)
class SecureStorageService implements SecureStorage {
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';

  final FlutterSecureStorage _storage;

  const SecureStorageService(this._storage);

  @override
  Future<void> saveToken(String token) async {
    try {
      await _storage.write(key: _tokenKey, value: token);
    } catch (e) {
      throw Exception('Failed to save token: ${e.toString()}');
    }
  }

  @override
  Future<void> saveRefreshToken(String refreshToken) async {
    try {
      await _storage.write(key: _refreshTokenKey, value: refreshToken);
    } catch (e) {
      throw Exception('Failed to save refresh token: ${e.toString()}');
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      return await _storage.read(key: _tokenKey);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<String?> getRefreshToken() async {
    try {
      return await _storage.read(key: _refreshTokenKey);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> clearTokens() async {
    try {
      await _storage.delete(key: _tokenKey);
      await _storage.delete(key: _refreshTokenKey);
    } catch (e) {
      // Log error but don't throw - clearing tokens should not fail the app
      print('Error clearing tokens: ${e.toString()}');
    }
  }

  @override
  Future<void> clearAllData() async {
    try {
      await _storage.deleteAll();
    } catch (e) {
      print('Error clearing all storage data: ${e.toString()}');
    }
  }
}
