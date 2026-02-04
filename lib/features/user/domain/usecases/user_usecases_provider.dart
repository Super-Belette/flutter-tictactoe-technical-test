import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:tic_tac_toe/features/user/domain/usecases/delete_user_usecase.dart';

import '../../data/repositories/user_repository_provider.dart';
import 'get_user_usecase.dart';
import 'save_user_usecase.dart';

part 'user_usecases_provider.g.dart';

@riverpod
GetUserUseCase getUserUseCase(Ref ref) {
  // We inject the repository implementation into the UseCase
  final repository = ref.watch(userRepositoryProvider);
  return GetUserUseCase(repository);
}

@riverpod
SaveUserUseCase saveUserUseCase(Ref ref) {
  final repository = ref.watch(userRepositoryProvider);
  return SaveUserUseCase(repository);
}

@riverpod
DeleteUserUseCase deleteUserUseCase(Ref ref) {
  final repository = ref.watch(userRepositoryProvider);
  return DeleteUserUseCase(repository);
}
