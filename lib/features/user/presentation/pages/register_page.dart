import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tic_tac_toe/core/theme/app_colors.dart';
import 'package:tic_tac_toe/core/theme/app_dimens.dart';

import '../controllers/user_controller.dart';

class RegisterPage extends ConsumerStatefulWidget {
  const RegisterPage({super.key});

  @override
  ConsumerState<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends ConsumerState<RegisterPage> {
  final TextEditingController _nicknameController = TextEditingController();

  // List of hardcoded avatar assets (using emojis for simplicity/demo)
  final List<String> _avatars = ['🤖', '👽', '🦊', '🐯', '🐼', '🦄'];
  String _selectedAvatar = '🤖';

  @override
  void dispose() {
    _nicknameController.dispose();
    super.dispose();
  }

  void _onStartGame() {
    final nickname = _nicknameController.text.trim();
    if (nickname.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please enter a nickname')),
      );
      return;
    }

    // Call the controller via Riverpod
    ref.read(userControllerProvider.notifier).login(nickname, _selectedAvatar);
  }

  @override
  Widget build(BuildContext context) {
    // Listen to loading state to show spinner
    final isLoading = ref.watch(userControllerProvider).isLoading;

    return Scaffold(
      backgroundColor: AppColors.surface,
      body: Center(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppDimens.pagePadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // 1. Title with Animation
              const Text(
                'TIC-TAC-TOE',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                  letterSpacing: 2,
                ),
              ).animate().fadeIn().moveY(begin: -20, end: 0),

              const SizedBox(height: 40),

              // 2. Avatar Selector
              const Text(
                'Choose your fighter',
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 16),
              Wrap(
                spacing: 16,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: _avatars.map((avatar) {
                  final isSelected = _selectedAvatar == avatar;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedAvatar = avatar),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color:
                            isSelected ? AppColors.primary : AppColors.surface,
                        shape: BoxShape.circle,
                        border: isSelected
                            ? Border.all(
                                color: AppColors.primaryVariant, width: 3)
                            : null,
                      ),
                      child: Text(
                        avatar,
                        style: const TextStyle(fontSize: 32),
                      ),
                    ),
                  );
                }).toList(),
              ).animate().fadeIn(delay: 200.ms).scale(),

              const SizedBox(height: 40),

              // 3. Nickname Input
              TextField(
                controller: _nicknameController,
                style: const TextStyle(color: AppColors.textPrimary),
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Colors.white10,
                  hintText: 'Enter your nickname',
                  hintStyle: const TextStyle(color: AppColors.textDisabled),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: const Icon(Icons.person, color: Colors.white54),
                ),
              ).animate().fadeIn(delay: 400.ms),

              const SizedBox(height: 40),

              // 4. Action Button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: isLoading ? null : _onStartGame,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: isLoading
                      ? const CircularProgressIndicator(color: Colors.black)
                      : const Text(
                          'START GAME',
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                ),
              ).animate().fadeIn(delay: 600.ms).moveY(begin: 20, end: 0),
            ],
          ),
        ),
      ),
    );
  }
}
