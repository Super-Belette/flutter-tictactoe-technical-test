import '../repositories/user_repository.dart';

/// UseCase responsible for deleting a user.
class DeleteUserUseCase {
  final UserRepository _repository;

  DeleteUserUseCase(this._repository);

  Future<void> call() {
    return _repository.deleteUser();
  }
}
