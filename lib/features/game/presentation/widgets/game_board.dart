import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../domain/entities/player.dart';
import '../providers/game_controller.dart';

class GameBoard extends StatelessWidget {
  const GameBoard({super.key});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1, // Ensures a square board
      child: Container(
        padding: const EdgeInsets.all(AppDimens.m),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppDimens.borderRadius),
        ),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(), // No scrolling
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 8,
            crossAxisSpacing: 8,
          ),
          itemCount: 9,
          itemBuilder: (context, index) {
            return _GameCell(index: index);
          },
        ),
      ),
    );
  }
}

class _GameCell extends ConsumerWidget {
  final int index;

  const _GameCell({required this.index});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // CRITICAL OPTIMIZATION:
    // We only watch the specific cell at this index.
    // If other cells update, this widget DOES NOT rebuild.
    final cellValue = ref.watch(
        gameControllerProvider.select((state) => state.board.grid[index]));

    return GestureDetector(
      onTap: () => ref.read(gameControllerProvider.notifier).makeMove(index),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: cellValue == null ? Colors.transparent : Colors.white10,
          ),
        ),
        child: Center(
          child: cellValue == null ? null : _buildPlayerIcon(cellValue),
        ),
      ),
    );
  }

  Widget _buildPlayerIcon(Player player) {
    final isX = player == Player.x;

    return Text(
      isX ? 'X' : 'O',
      style: GoogleFonts.fredoka(
        fontSize: 50,
        fontWeight: FontWeight.w900,
        color: isX ? AppColors.playerX : AppColors.playerO,
        height: 1.0,
        shadows: [
          Shadow(
            color: (isX ? AppColors.playerX : AppColors.playerO)
                .withValues(alpha: 0.5),
            blurRadius: 10,
            offset: const Offset(0, 0),
          ),
        ],
      ),
    ).animate().scale(duration: 200.ms, curve: Curves.easeOutBack).fadeIn();
  }
}
