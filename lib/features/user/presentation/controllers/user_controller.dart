import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/user.dart';
import '../../domain/usecases/user_usecases_provider.dart';

part 'user_controller.g.dart';

/// Controller managing the User state.
/// It uses AsyncValue to handle loading/error/data states automatically.
@riverpod
class UserController extends _$UserController {
  @override
  Future<User?> build() async {
    // 1. When the app starts, we try to fetch the existing user
    final getUser = ref.read(getUserUseCaseProvider);
    return await getUser();
  }

  /// Method called by the UI when the user clicks "Start Game"
  Future<void> login(String nickname, String avatarPath) async {
    // 1. Set state to loading
    state = const AsyncValue.loading();

    // 2. Perform the logic
    state = await AsyncValue.guard(() async {
      final user = User(nickname: nickname, avatarPath: avatarPath);

      final saveUser = ref.read(saveUserUseCaseProvider);
      await saveUser(user);

      // 3. Return the new user to update the UI
      return user;
    });
  }

  /// Method to logout (optional, but good for testing)
  Future<void> logout() async {
    // TODO: Implement delete usecase if needed
    // For now, we just reset the state
    state = const AsyncValue.data(null);
  }
}
