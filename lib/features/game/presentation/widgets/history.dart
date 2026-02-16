import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/features/game/presentation/providers/game_controller.dart';

class History extends ConsumerWidget {
  const History({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(
      gameControllerProvider.select((state) => state.history),
    );

    return Row(
      mainAxisAlignment: .spaceEvenly,
      children: [
        Text("WINS: ${history.victoryCount}"),
        Text("DRAWS: ${history.drawCount}"),
        Text("LOSES: ${history.loseCount}"),
      ],
    );
  }
}
