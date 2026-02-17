import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../domain/entities/game_status.dart';
import '../../domain/entities/player.dart';
import '../../domain/repositories/ai_strategy_provider.dart';
import 'game_state.dart';

part 'game_controller.g.dart';

@riverpod
class GameController extends _$GameController {
  Timer? _timer;

  @override
  GameState build() {
    ref.onDispose(() {
      _timer?.cancel();
    });
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

    _resetTimer();
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
      final strategy = ref.read(aiStrategyProvider);

      // Ask the strategy for the best move
      final aiMoveIndex = await strategy.nextMove(state.board);

      // If AI found a move (should always be true unless board full)
      if (aiMoveIndex != null) {
        _applyMove(aiMoveIndex, Player.o);
      }
    } finally {
      // Release UI block
      state = state.copyWith(isAiThinking: false);
    }
  }

  void _resetTimer() async {
    _timer?.cancel();
    state = state.copyWith(timeLeft: 5);
    _timer = Timer.periodic(const Duration(milliseconds: 1), (timer) {
      if (state.timeLeft > 0) {
        state = state.copyWith(timeLeft: state.timeLeft - 1);
      } else {
        _onTimerEnd();
      }
    });
  }

  void _onTimerEnd() {
    final playing = state.status.maybeMap(
      playing: (_) => true,
      orElse: () => false,
    );

    if (playing) {
      _timer?.cancel();
      final activePlayer = state.currentTurn;
      state = state.copyWith(status: GameStatus.victory(activePlayer.opponent));
    }
  }
}
