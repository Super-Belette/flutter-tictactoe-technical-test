import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/providers/shared_prefs_provider.dart';
import '../../domain/repositories/user_repository.dart';
import 'local_user_repository.dart';

part 'user_repository_provider.g.dart';

@riverpod
UserRepository userRepository(Ref ref) {
  final prefs = ref.watch(sharedPreferencesProvider);

  return LocalUserRepository(prefs);
}
