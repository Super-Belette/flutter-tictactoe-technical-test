import 'package:freezed_annotation/freezed_annotation.dart';
import 'player.dart';

part 'board.freezed.dart';

@freezed
class Board with _$Board {
  const Board._();

  const factory Board({required List<Player?> grid}) = _Board;

  factory Board.empty() => Board(grid: List.filled(9, null));

  //Eases the access of the grid
  Player? operator [](int index) => grid[index];

  bool get isFull => !grid.contains(null);

  // List of winning combinations to determine the winner
  Player? get winner {
    const winningLines = [
      [0, 1, 2], [3, 4, 5], [6, 7, 8], // Lines
      [0, 3, 6], [1, 4, 7], [2, 5, 8], // Columns
      [0, 4, 8], [2, 4, 6], // Diagonals
    ];

    for (final line in winningLines) {
      final a = grid[line[0]];
      final b = grid[line[1]];
      final c = grid[line[2]];

      if (a != null && a == b && a == c) {
        return a; // One winner
      }
    }
    return null; // No winner yet
  }
}
