import 'package:injectable/injectable.dart';
import '../entities/user.dart';
import '../../data/storage/secure_storage.dart';

@injectable
class GetCurrentUserUseCase {
  final SecureStorage _secureStorage;

  const GetCurrentUserUseCase(this._secureStorage);

  Future<User?> call() async {
    try {
      final token = await _secureStorage.getToken();
      if (token == null || token.isEmpty) return null;
      return const User(
        id: 1,
        email: 'user@example.com',
        name: 'Current User',
      );
    } catch (e) {
      return null;
    }
  }
}