import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/game/presentation/pages/game_page.dart';
import '../../features/user/presentation/controllers/user_controller.dart';
import '../../features/user/presentation/pages/register_page.dart';

// Import GamePage later when created

part 'app_router.g.dart';

// We expose the GlobalKey to access context if needed outside widgets
final rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter goRouter(Ref ref) {
  // We watch the user controller state to trigger redirects automatically
  final userState = ref.watch(userControllerProvider);

  return GoRouter(
    navigatorKey: rootNavigatorKey,
    initialLocation: '/game',
    // We try to go to game by default
    debugLogDiagnostics: true,

    // REDIRECTION LOGIC (Guard)
    redirect: (context, state) {
      final isLoading = userState.isLoading;
      final hasUser = userState.valueOrNull != null;
      final isGoingToRegister = state.matchedLocation == '/register';

      // If loading, don't do anything yet
      if (isLoading) return null;

      // If not logged in and not on register page -> Go to Register
      if (!hasUser && !isGoingToRegister) {
        return '/register';
      }

      // If logged in and trying to access register -> Go to Game
      if (hasUser && isGoingToRegister) {
        return '/game';
      }

      return null;
    },

    routes: [
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/game',
        builder: (context, state) => const GamePage(),
      ),
    ],
  );
}
