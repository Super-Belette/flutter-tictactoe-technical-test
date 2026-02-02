import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/random_ai_strategy.dart';
import '../../domain/entities/game_status.dart';
import '../../domain/entities/player.dart';
import '../../domain/repositories/ai_strategy.dart';
import 'game_state.dart';

part 'game_controller.g.dart';

@riverpod
class GameController extends _$GameController {
  // Dependency: The AI Strategy
  late final AiStrategy _aiStrategy;

  @override
  GameState build() {
    // In a real app, we would inject this via a Provider for better testing
    _aiStrategy = RandomAiStrategy();
    return GameState.initial();
  }

  /// Called when a human player taps a cell
  Future<void> makeMove(int index) async {
    // 1. Guard Clauses (Safety first)
    final isPlayable = state.status.maybeMap(
      initial: (_) => true,
      playing: (_) => true,
      orElse: () => false,
    );

    if (!isPlayable) return;
    if (state.isAiThinking) return;
    if (state.board[index] != null) return;

    // 2. Apply the Human Move
    _applyMove(index, Player.x);

    // 3. Trigger AI Turn
    final isAiTurn = state.status.maybeMap(
      playing: (_) => state.currentTurn == Player.o,
      orElse: () => false,
    );

    if (isAiTurn) {
      await _playAiTurn();
    }
  }

  /// Logic to reset the game
  void resetGame() {
    state = GameState.initial();
  }

  /// Internal method to apply a move on the board
  void _applyMove(int index, Player player) {
    // Update the grid (Clean Arch: create a NEW board, don't mutate)
    final newGrid = List<Player?>.from(state.board.grid);
    newGrid[index] = player;

    // Create new Board instance (triggering the logic inside Board)
    final newBoard = state.board.copyWith(grid: newGrid);

    // Check Game Over conditions
    GameStatus newStatus;

    if (newBoard.winner != null) {
      newStatus = GameStatus.victory(newBoard.winner!);
    } else if (newBoard.isFull) {
      newStatus = const GameStatus.draw();
    } else {
      // Game continues
      newStatus = GameStatus.playing(player.opponent);
    }

    // Update State
    state = state.copyWith(
      board: newBoard,
      status: newStatus,
      currentTurn: player.opponent,
    );
  }

  /// Trigger AI logic
  Future<void> _playAiTurn() async {
    // UI Block: AI is thinking
    state = state.copyWith(isAiThinking: true);

    try {
      // Ask the strategy for the best move
      final aiMoveIndex = await _aiStrategy.nextMove(state.board);

      // If AI found a move (should always be true unless board full)
      if (aiMoveIndex != null) {
        _applyMove(aiMoveIndex, Player.o);
      }
    } finally {
      // Release UI block
      state = state.copyWith(isAiThinking: false);
    }
  }
}
