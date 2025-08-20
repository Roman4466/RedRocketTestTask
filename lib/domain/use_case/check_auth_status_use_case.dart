import 'package:injectable/injectable.dart';
import '../../data/storage/secure_storage.dart';

@injectable
class CheckAuthStatusUseCase {
  final SecureStorage _secureStorage;

  const CheckAuthStatusUseCase(this._secureStorage);

  Future<bool> call() async {
    try {
      final token = await _secureStorage.getToken();
      return token != null && token.isNotEmpty;
    } catch (e) {
      return false;
    }
  }
}