import '../../domain/entities/board.dart';
import '../../domain/entities/player.dart';
import '../../domain/repositories/ai_strategy.dart';

class MinimaxAiStrategy implements AiStrategy {
  // AI is Player O, Human is Player X
  static const aiPlayer = Player.o;
  static const humanPlayer = Player.x;

  @override
  Future<int?> nextMove(Board board) async {
    // Artificial delay for UX (feels like thinking)
    await Future.delayed(const Duration(milliseconds: 500));

    int bestScore = -1000;
    int? bestMove;

    // We loop through all empty cells to find the best immediate move
    for (int i = 0; i < 9; i++) {
      if (board.grid[i] == null) {
        // simulate the move
        final newBoard = _simulateMove(board, i, aiPlayer);

        // calculate score using minimax
        final score = _minimax(newBoard, 0, false);

        if (score > bestScore) {
          bestScore = score;
          bestMove = i;
        }
      }
    }
    return bestMove;
  }

  /// The recursive Minimax function
  int _minimax(Board board, int depth, bool isMaximizing) {
    // 1. Base Cases (Terminal states)
    final winner = board.winner;
    if (winner == aiPlayer) return 10 - depth; // Win sooner is better
    if (winner == humanPlayer) return depth - 10; // Lose later is better
    if (board.isFull) return 0; // Draw

    // 2. Recursive Step
    if (isMaximizing) {
      int bestScore = -1000;
      for (int i = 0; i < 9; i++) {
        if (board.grid[i] == null) {
          final newBoard = _simulateMove(board, i, aiPlayer);
          final score = _minimax(newBoard, depth + 1, false);
          if (score > bestScore) bestScore = score;
        }
      }
      return bestScore;
    } else {
      int bestScore = 1000;
      for (int i = 0; i < 9; i++) {
        if (board.grid[i] == null) {
          final newBoard = _simulateMove(board, i, humanPlayer);
          final score = _minimax(newBoard, depth + 1, true);
          if (score < bestScore) bestScore = score;
        }
      }
      return bestScore;
    }
  }

  Board _simulateMove(Board board, int index, Player player) {
    final newGrid = List<Player?>.from(board.grid);
    newGrid[index] = player;
    return board.copyWith(grid: newGrid);
  }
}
