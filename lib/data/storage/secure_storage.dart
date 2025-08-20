abstract class SecureStorage {
  Future<void> saveToken(String token);
  Future<void> saveRefreshToken(String refreshToken);
  Future<String?> getToken();
  Future<String?> getRefreshToken();
  Future<void> clearTokens();
  Future<void> clearAllData();
}