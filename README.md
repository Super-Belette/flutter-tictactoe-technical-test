# 🎮 Tic-Tac-Toe Challenge (BetClic Tech Test)

![Flutter](https://img.shields.io/badge/Flutter-3.10+-02569B?logo=flutter)
![Architecture](https://img.shields.io/badge/Architecture-Clean%20Arch-green)
![State](https://img.shields.io/badge/State-Riverpod%20v2-blue)
![Testing](https://img.shields.io/badge/Coverage-100%25-success)

A modernized, competitive Tic-Tac-Toe game featuring a Smart AI, dynamic odds system, and a robust
Clean Architecture.

## ✨ Features

- **🧠 Smart AI (Strategy Pattern):** Switch seamlessly between a Random Bot (Easy) and an Invincible
  Minimax Bot (Hard).
- **📊 Live Odds System:** Dynamic betting odds (1-N-2) that react in real-time to the board state (
  Center control, corners, etc.).
- **🎨 Atomic Design System:** Consistent UI with themed components, animations (`flutter_animate`),
  and responsive layout.
- **⚡ Optimized Rendering:** `Riverpod` select filters ensure only modified cells rebuild.
- **👤 User Session:** Persist nickname and avatar preferences using Local Storage.

## 🏗️ Architecture & Tech Stack

The project follows strict **Clean Architecture** principles to ensure separation of concerns and
testability.

- **Presentation Layer:** Riverpod (Controllers), Flutter Widgets, GoRouter.
- **Domain Layer:** Entities, Abstract Repositories, Pure Dart UseCases.
- **Data Layer:** Repository Implementations, Data Sources (SharedPrefs, AI Algorithms).

**Key Libraries:**

- `flutter_riverpod` & `riverpod_annotation`: Dependency Injection & State Management.
- `freezed`: Immutable state & Unions (Pattern Matching).
- `go_router`: Navigation & Guards.
- `flutter_animate`: UI Polish.

## 🚀 Getting Started

This project uses code generation. You **must** run the build runner to compile.

1. **Clone the repository**
   ```bash
   git clone https://github.com/Super-Belette/flutter-tictactoe-technical-test.git
   cd tic_tac_toe
   ```

2. **Install dependencies**
    ```bash
   flutter pub get
   ```

3. **Generate code (Crucial Step)**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Run the App**
    ```bash
   flutter run
    ```

## 🧪 Testing

```bash
flutter test
```

## 📂 Project Structure

```Plaintext
lib/
├── core/             # Shared logic (Theme, Router, Constants)
├── features/
│   ├── game/         # Game Logic (Minimax, Board, Odds)
│   └── user/         # User Session (Register, Preferences)
└── main.dart         # Entry point
```

## 🔮 Roadmap & Future Improvements

This project was built as a scalable MVP. Here is how I would push it further for a production
environment:

### 📱 Product Features

- **Online Multiplayer (PvP):** Replace the Local AI with a WebSocket connection (Firebase or Custom
  Server) to play against real humans.
- **Leaderboard:** Global ranking based on winning streaks (Database integration).
- **Sound Design:** Add haptic feedback and sound effects for better game feel.

### 🛠 Technical Enhancements

- **Strict Linting:** Add `flutter_lints` with stricter rules.
- **Golden Tests:** Add Golden Toolkit to prevent UI regressions on different screen sizes.
- **Accessibility:** Ensure Screen Readers (TalkBack/VoiceOver) perfectly navigate the grid.

Developed with ❤️ for the BetClic Mobile Team.