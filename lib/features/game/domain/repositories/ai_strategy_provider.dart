import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/datasources/random_ai_strategy.dart';
import 'ai_strategy.dart';

part 'ai_strategy_provider.g.dart';

@riverpod
AiStrategy aiStrategy(Ref ref) {
  return RandomAiStrategy();
}
