import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tic_tac_toe/features/game/domain/entities/game_status.dart';
import 'package:tic_tac_toe/features/game/domain/entities/player.dart';
import 'package:tic_tac_toe/features/game/domain/repositories/ai_strategy.dart';
import 'package:tic_tac_toe/features/game/domain/repositories/ai_strategy_provider.dart';
import 'package:tic_tac_toe/features/game/presentation/providers/game_controller.dart';

@GenerateNiceMocks([MockSpec<AiStrategy>()])
import 'game_controller_test.mocks.dart';

void main() {
  late MockAiStrategy mockAiStrategy;
  late ProviderContainer container;

  setUp(() {
    mockAiStrategy = MockAiStrategy();

    container = ProviderContainer(
      overrides: [
        aiStrategyProvider.overrideWithValue(mockAiStrategy),
      ],
    );
  });

  test('Initial state should be empty grid with Player X turn', () {
    final state = container.read(gameControllerProvider);

    expect(state.board.grid.every((cell) => cell == null), true); // Grid empty
    expect(state.currentTurn, Player.x); // X starts
    expect(state.status, const GameStatus.initial());
  });

  test('Player Move should update board and trigger AI turn', () async {
    final subscription = container.listen(
      gameControllerProvider,
      (_, __) {}, // On ne fait rien des mises à jour, on veut juste écouter
    );

    // GIVEN
    // We tell the Mock AI to ALWAYS play at index 8 when asked
    when(mockAiStrategy.nextMove(any)).thenAnswer((_) async => 8);

    final controller = container.read(gameControllerProvider.notifier);

    // WHEN - Player X plays at index 0
    await controller.makeMove(0);
    await Future.delayed(const Duration(milliseconds: 10));

    // THEN - Check Player X move
    final stateAfterPlayer = container.read(gameControllerProvider);
    expect(stateAfterPlayer.board.grid[0], Player.x);

    // Wait for the async AI turn to finish
    await Future.delayed(const Duration(milliseconds: 100));

    // THEN - Check AI move (should be at index 8 as mocked)
    final finalState = container.read(gameControllerProvider);
    expect(finalState.board.grid[8], Player.o);
    expect(finalState.currentTurn, Player.x); // Back to player X

    subscription.close();
  });
}
