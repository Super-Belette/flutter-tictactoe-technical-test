import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_dimens.dart';
import '../../domain/entities/player.dart';
import '../providers/game_controller.dart';

class OddsBanner extends ConsumerWidget {
  const OddsBanner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final board =
        ref.watch(gameControllerProvider.select((state) => state.board));

    double p1Odd = 2.10;
    double p2Odd = 2.60;
    double drawOdd = 3.10;

    final grid = board.grid;
    final movesCount = grid.where((c) => c != null).length;

    if (grid[4] == Player.x) {
      p1Odd -= 0.4;
      p2Odd += 0.5;
    } else if (grid[4] == Player.o) {
      p2Odd -= 0.6;
      p1Odd += 0.4;
    }

    int xCorners = 0;
    int oCorners = 0;
    const corners = [0, 2, 6, 8];
    for (final i in corners) {
      if (grid[i] == Player.x) xCorners++;
      if (grid[i] == Player.o) oCorners++;
    }
    p1Odd -= (xCorners * 0.1);
    p2Odd -= (oCorners * 0.1);

    if (movesCount >= 5) {
      drawOdd = 1.50;
      p1Odd += 0.5;
      p2Odd += 0.5;
    }
    if (movesCount >= 7) {
      drawOdd = 1.10; //
      p1Odd = 8.0;
      p2Odd = 8.0;
    }

    p1Odd = p1Odd.clamp(1.01, 20.0);
    p2Odd = p2Odd.clamp(1.01, 20.0);
    drawOdd = drawOdd.clamp(1.01, 20.0);

    return Container(
      padding: const EdgeInsets.all(AppDimens.s),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppDimens.borderRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _OddItem(label: '1 (You)', value: p1Odd, color: AppColors.primary),
          _OddItem(label: 'N (Draw)', value: drawOdd, color: Colors.white),
          _OddItem(label: '2 (CPU)', value: p2Odd, color: AppColors.error),
        ],
      ),
    );
  }
}

class _OddItem extends StatelessWidget {
  final String label;
  final double value;
  final Color color;

  const _OddItem(
      {required this.label, required this.value, required this.color});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.textSecondary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: AppColors.background,
            borderRadius: BorderRadius.circular(6),
            border: Border.all(
              color: color.withValues(alpha: 0.5),
            ),
          ),
          child: Text(
            value.toStringAsFixed(2),
            style: TextStyle(
              color: color,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
      ],
    );
  }
}
