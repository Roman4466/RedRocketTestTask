import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

import '../../core/error/app_error.dart';
import '../../data/storage/secure_storage.dart';

@injectable
class CheckAuthStatusUseCase {
  final SecureStorage _secureStorage;

  const CheckAuthStatusUseCase(this._secureStorage);

  Future<Either<AppError, bool>> call() async {
    final tokenResult = await _secureStorage.getToken();

    return tokenResult.fold(
      (error) => Left(error),
      (token) => Right(token != null && token.isNotEmpty),
    );
  }
}
