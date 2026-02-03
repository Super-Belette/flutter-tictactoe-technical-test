import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/minimax_ai_strategy.dart';
import '../../data/datasources/random_ai_strategy.dart';
import 'ai_strategy.dart';

part 'ai_strategy_provider.g.dart';

enum GameDifficulty {
  easy, // Random
  hard, // Minimax
}

final difficultyProvider =
    StateProvider<GameDifficulty>((ref) => GameDifficulty.easy);

@riverpod
AiStrategy aiStrategy(Ref ref) {
  final difficulty = ref.watch(difficultyProvider);

  return switch (difficulty) {
    GameDifficulty.easy => RandomAiStrategy(),
    GameDifficulty.hard => MinimaxAiStrategy(),
  };
}
