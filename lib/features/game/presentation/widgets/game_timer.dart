import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/features/game/presentation/providers/game_controller.dart';

class GameTimer extends ConsumerWidget {
  const GameTimer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final timeLeft = ref.watch(
      gameControllerProvider.select((state) => state.timeLeft),
    );

    return LinearProgressIndicator(value: timeLeft * 0.2);
  }
}
