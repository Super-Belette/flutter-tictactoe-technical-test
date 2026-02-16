import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tic_tac_toe/features/game/domain/entities/player.dart';

part 'game_history.freezed.dart';

@freezed
abstract class GameHistory with _$GameHistory {
  const GameHistory._();

  const factory GameHistory({
    required int victoryCount,
    required int drawCount,
    required int loseCount,
  }) = _GameHistory;

  GameHistory addResult(Player? player) => copyWith(
    victoryCount: player == Player.x ? victoryCount + 1 : victoryCount,
    drawCount: player == null ? drawCount + 1 : drawCount,
    loseCount: player == Player.o ? loseCount + 1 : loseCount,
  );
}
