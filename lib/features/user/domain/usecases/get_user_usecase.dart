import '../entities/user.dart';
import '../repositories/user_repository.dart';

/// UseCase responsible for retrieving the current user session.
/// It acts as a bridge between the Controller (UI) and the Repository (Data).
class GetUserUseCase {
  final UserRepository _repository;

  GetUserUseCase(this._repository);

  Future<User?> call() {
    return _repository.getUser();
  }
}
