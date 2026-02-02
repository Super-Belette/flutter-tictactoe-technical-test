import 'dart:math';
import '../../domain/entities/board.dart';
import '../../domain/repositories/ai_strategy.dart';

class RandomAiStrategy implements AiStrategy {
  final Random _random = Random();

  @override
  Future<int?> nextMove(Board board) async {
    // Artificial delay to make it feel like the AI is "thinking"
    // and to let the user see the animation. UX Best Practice.
    await Future.delayed(const Duration(milliseconds: 600));

    // Get all available indices (where grid[i] is null)
    final availableMoves = <int>[];
    for (int i = 0; i < board.grid.length; i++) {
      if (board.grid[i] == null) {
        availableMoves.add(i);
      }
    }

    if (availableMoves.isEmpty) return null;

    // Pick a random index
    return availableMoves[_random.nextInt(availableMoves.length)];
  }
}
