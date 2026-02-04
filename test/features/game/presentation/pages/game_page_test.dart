import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:tic_tac_toe/features/game/domain/repositories/ai_strategy_provider.dart';
import 'package:tic_tac_toe/features/game/presentation/pages/game_page.dart';
import 'package:tic_tac_toe/features/user/domain/entities/user.dart';
import 'package:tic_tac_toe/features/user/domain/usecases/get_user_usecase.dart';
import 'package:tic_tac_toe/features/user/domain/usecases/user_usecases_provider.dart';

import '../providers/game_controller_test.mocks.dart';
import 'game_page_test.mocks.dart';

@GenerateNiceMocks([MockSpec<GetUserUseCase>()])
void main() {
  testWidgets('Clicking on a cell should display X',
      (WidgetTester tester) async {
    tester.view.physicalSize = const Size(400, 900);
    tester.view.devicePixelRatio = 1.0;

    addTearDown(tester.view.resetPhysicalSize);

    // 1. SETUP MOCKS
    final mockAiStrategy = MockAiStrategy();
    final mockGetUserUseCase = MockGetUserUseCase();

    when(mockAiStrategy.nextMove(any)).thenAnswer((_) async => null);

    when(mockGetUserUseCase.call()).thenAnswer(
        (_) async => const User(nickname: "TestWidgetUser", avatarPath: "🤖"));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          aiStrategyProvider.overrideWith((ref) => mockAiStrategy),
          getUserUseCaseProvider.overrideWith((ref) => mockGetUserUseCase),
        ],
        child: const MaterialApp(
          home: GamePage(),
        ),
      ),
    );

    await tester.pumpAndSettle();

    // 2. VERIFY INITIAL STATE
    expect(find.text('X'), findsNothing);
    expect(find.text('BetClic Arena'), findsOneWidget);

    // 3. ACT
    await tester.ensureVisible(find.byType(GridView));

    await tester.tap(find.byType(GridView));

    await tester.pumpAndSettle();

    // 4. VERIFY
    expect(find.text('X'), findsOneWidget);
  });
}