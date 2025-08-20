import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/app_error.dart';
import '../../data/storage/secure_storage.dart';
import '../entities/user.dart';

@injectable
class GetCurrentUserUseCase {
  final SecureStorage _secureStorage;

  const GetCurrentUserUseCase(this._secureStorage);

  Future<Either<AppError, User?>> call() async {
    final tokenResult = await _secureStorage.getToken();

    return tokenResult.fold((error) => Left(error), (token) {
      if (token == null || token.isEmpty) {
        return const Right(null);
      }

      return const Right(User(id: 1, email: 'user@example.com', name: 'Current User'));
    });
  }
}
