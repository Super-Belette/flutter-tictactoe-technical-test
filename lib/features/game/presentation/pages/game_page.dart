import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tic_tac_toe/features/game/presentation/widgets/history.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../../user/presentation/controllers/user_controller.dart';
import '../../domain/entities/player.dart';
import '../../domain/repositories/ai_strategy_provider.dart';
import '../providers/game_controller.dart';
import '../widgets/game_board.dart';
import '../widgets/odds_banner.dart';

class GamePage extends ConsumerWidget {
  const GamePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. User Info (From User Feature)
    final userState = ref.watch(userControllerProvider);
    final user = userState.valueOrNull;

    // 2. Game Info
    final gameState = ref.watch(gameControllerProvider);
    final isAiTurn = gameState.currentTurn == Player.o;
    final difficulty = ref.watch(difficultyProvider);
    final botName =
        difficulty == GameDifficulty.hard ? 'MiniMaxBot' : 'RandomBot';

    // 3. Listener for Game Over (Side Effect)
    ref.listen(gameControllerProvider, (previous, next) {
      if (previous?.status == next.status) return;

      next.status.maybeMap(
        victory: (winner) =>
            _showEndGameDialog(context, ref, winner: winner.winner),
        draw: (_) => _showEndGameDialog(context, ref, winner: null),
        orElse: () {},
      );
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('BetClic Arena'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: AppColors.error),
            onPressed: () => ref.read(userControllerProvider.notifier).logout(),
          ),
        ],
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SingleChildScrollView(
            padding:
                const EdgeInsets.symmetric(horizontal: AppDimens.pagePadding),
            child: Column(
              children: [
                const SizedBox(height: AppDimens.l),

                // --- HEADER: PLAYERS ---
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: _PlayerInfo(
                        name: user?.nickname ?? 'Player',
                        avatar: user?.avatarPath ?? '😎',
                        isActive: !isAiTurn,
                        color: AppColors.playerX,
                      ),
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: AppDimens.m),
                      child: Text('VS',
                          style: TextStyle(
                              fontWeight: FontWeight.bold, color: Colors.grey)),
                    ),
                    Expanded(
                      child: _PlayerInfo(
                        name: botName,
                        avatar: '🤖',
                        isActive: isAiTurn,
                        color: AppColors.playerO,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppDimens.l),

                // --- ODDS WIDGET  ---
                const OddsBanner(),

                const History(),

                const SizedBox(height: AppDimens.m),

                // --- CONTROLS WIDGET  ---

                const _GameControls(),

                const SizedBox(height: AppDimens.m),

                // --- THE BOARD ---
                const GameBoard(),

                const SizedBox(height: AppDimens.l),

                // --- STATUS TEXT ---
                Text(
                  isAiTurn ? 'Wait, AI is thinking...' : 'Your turn!',
                  style: TextStyle(
                    color: isAiTurn ? Colors.grey : AppColors.primary,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: AppDimens.xl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showEndGameDialog(BuildContext context, WidgetRef ref,
      {Player? winner}) {
    showDialog(
      context: context,
      barrierDismissible: false, // Force user to click button
      builder: (ctx) => AlertDialog(
        backgroundColor: AppColors.surface,
        title: Text(
          winner == null
              ? 'Draw!'
              : (winner == Player.x ? 'BIG WIN!' : 'You Lost...'),
          textAlign: TextAlign.center,
          style: TextStyle(
            color: winner == Player.x ? AppColors.primary : Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 28,
          ),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              winner == null
                  ? 'Close match! Check the odds next time.'
                  : (winner == Player.x
                      ? 'You beat the odds!'
                      : 'The house always wins.'),
              textAlign: TextAlign.center,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop(); // Close dialog
              ref.read(gameControllerProvider.notifier).resetGame();
            },
            child: const Text('PLAY AGAIN',
                style: TextStyle(
                    color: AppColors.primary, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}

class _PlayerInfo extends StatelessWidget {
  final String name;
  final String avatar;
  final bool isActive;
  final Color color;

  const _PlayerInfo({
    required this.name,
    required this.avatar,
    required this.isActive,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isActive ? 1.0 : 0.5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CircleAvatar(
            backgroundColor: isActive ? color : Colors.grey[800],
            radius: 24,
            child: Text(avatar, style: const TextStyle(fontSize: 24)),
          ),
          const SizedBox(height: 8),
          Text(
            name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: isActive ? color : Colors.grey,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

class _GameControls extends ConsumerWidget {
  const _GameControls();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final difficulty = ref.watch(difficultyProvider);

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        // DIFFICULTY SWITCH
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white10),
          ),
          child: Row(
            children: [
              Text(
                difficulty == GameDifficulty.hard ? 'HARD' : 'EASY',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: difficulty == GameDifficulty.hard
                      ? AppColors.error
                      : AppColors.primary,
                ),
              ),
              Switch(
                value: difficulty == GameDifficulty.hard,
                activeThumbColor: AppColors.error,
                onChanged: (isHard) {
                  ref.read(difficultyProvider.notifier).state =
                      isHard ? GameDifficulty.hard : GameDifficulty.easy;
                },
              ),
            ],
          ),
        ),

        const SizedBox(width: 16),

        // RESET BUTTON (Déplacé ici aussi pour l'ergonomie)
        IconButton.filledTonal(
          onPressed: () =>
              ref.read(gameControllerProvider.notifier).resetGame(),
          icon: const Icon(Icons.refresh),
          tooltip: "Restart Game",
        ),
      ],
    );
  }
}
