import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tic_tac_toe/features/game/domain/entities/player.dart';

part 'game_status.freezed.dart';

@freezed
sealed class GameStatus with _$GameStatus {
  const factory GameStatus.initial() = _Initial;
  const factory GameStatus.playing(Player turn) = _Playing;
  const factory GameStatus.victory(Player winner) = _Victory;
  const factory GameStatus.draw() = _Draw;
}