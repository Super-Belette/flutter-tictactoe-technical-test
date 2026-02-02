import '../entities/user.dart';
import '../repositories/user_repository.dart';

/// UseCase responsible for creating or updating a user.
class SaveUserUseCase {
  final UserRepository _repository;

  SaveUserUseCase(this._repository);

  Future<void> call(User user) {
    return _repository.saveUser(user);
  }
}
