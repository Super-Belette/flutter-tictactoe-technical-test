import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/board.dart';
import '../../domain/entities/game_history.dart';
import '../../domain/entities/game_status.dart';
import '../../domain/entities/player.dart';

part 'game_state.freezed.dart';

@freezed
class GameState with _$GameState {
  const factory GameState({
    required Board board,
    required GameStatus status,
    required Player currentTurn,
    @Default(false) bool isAiThinking,
    required GameHistory history,
  }) = _GameState;

  // Initial state factory
  factory GameState.initial() => GameState(
        board: Board.empty(),
        status: const GameStatus.initial(),
        currentTurn: Player.x, // Player X always starts (Convention)
    history: const GameHistory(victoryCount: 0, drawCount: 0, loseCount: 0),
  );
}
