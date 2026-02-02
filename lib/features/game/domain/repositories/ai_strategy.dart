import '../entities/board.dart';

/// Interface for AI logic.
/// Following the Strategy Pattern allows us to easily swap
/// between difficulty levels (Random vs Minimax) without changing the UI.
abstract interface class AiStrategy {
  /// Returns the index (0-8) where the AI decides to play.
  /// Returns null if no move is possible (board full).
  Future<int?> nextMove(Board board);
}
