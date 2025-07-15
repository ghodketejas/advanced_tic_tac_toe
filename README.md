# Advanced Tic Tac Toe

> **I am working hard to bring this app to the Play Store and App Store!**

A modern, cross-platform implementation of Advanced Tic Tac Toe built with Flutter. This isn't your ordinary tic-tac-toe - it's a strategic game where you play on a 3x3 grid of tic-tac-toe boards!

## 🎮 Game Features

- **Advanced Tic Tac Toe Gameplay**: Play on a 3x3 grid of tic-tac-toe boards
- **Multiple Game Modes**: 
  - Play against AI with adaptive difficulty
  - Play against a friend (pass-and-play)
- **Smart AI**: Computer opponent that adapts to your skill level
- **Beautiful UI**: Modern dark theme with neon blue and orange accents
- **Animated Background**: Floating grid animations for visual appeal
- **Statistics Tracking**: Persistent win/loss/draw statistics
- **Cross-Platform**: Works on Android, iOS, Web, Windows, macOS, and Linux

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.4.3 or higher)
- Dart (comes with Flutter)

### Installation
1. **Clone the repository:**
   ```sh
   git clone https://github.com/ghodketejas/advanced_tic_tac_toe.git
   cd advanced_tic_tac_toe/advanced_tic_tac_toe_game
   ```

2. **Install dependencies:**
   ```sh
   flutter pub get
   ```

3. **Run the app:**
   ```sh
   flutter run
   ```

### Platform-Specific Commands
- **Android/iOS:** `flutter run`
- **Web:** `flutter run -d chrome`
- **Windows:** `flutter run -d windows`
- **macOS:** `flutter run -d macos`
- **Linux:** `flutter run -d linux`

## 📁 Project Structure

```
lib/
├── main.dart                 # App entry point and routing
├── game_logic.dart          # Core game logic and AI
├── stats_manager.dart       # Statistics persistence
├── theme/
│   └── app_theme.dart       # Theme configuration
├── pages/
│   ├── launch_page.dart     # Home screen
│   ├── game_mode_selection_page.dart
│   ├── game_page.dart       # Main game UI
│   ├── settings_page.dart   # Settings (placeholder)
│   ├── how_to_play_page.dart # Game instructions
│   └── about_page.dart      # About/credits
└── widgets/
    ├── floating_grids_background.dart
    ├── stat_box.dart        # Statistics display
    └── custom_choice_chip.dart
```

## 🎯 How to Play Advanced Tic Tac Toe

1. **The Big Picture**: You're playing on a 3x3 grid of tic-tac-toe boards
2. **Making Moves**: Pick any empty cell in the highlighted (active) small board
3. **Sending Opponents**: The cell you pick decides which small board your opponent must play in next
4. **Winning**: Win the big game by winning three small boards in a row (horizontally, vertically, or diagonally)
5. **Strategy**: Think ahead! Your move decides your opponent's options

## 🤖 AI System

The computer opponent features an adaptive difficulty system:
- **Difficulty Range**: 0 (easiest) to 100 (hardest)
- **Smart Moves**: AI tries to win local boards, blocks your moves, or plays randomly based on difficulty
- **Adaptive Learning**: Difficulty increases when AI wins, decreases when you win
- **Strategy**: AI evaluates winning moves, blocking moves, and random moves

## 🛠️ Technical Details

- **Framework**: Flutter 3.4.3+
- **Language**: Dart
- **State Management**: Flutter's built-in StatefulWidget
- **Persistence**: SharedPreferences for statistics
- **UI**: Material Design with custom dark theme
- **Animations**: Custom animated backgrounds and transitions

## 🎨 UI/UX Features

- **Dark Theme**: Modern dark interface with neon accents
- **Responsive Design**: Adapts to different screen sizes
- **Smooth Animations**: Floating grid backgrounds and smooth transitions
- **Accessibility**: Proper contrast ratios and readable fonts
- **Cross-Platform**: Consistent experience across all platforms

## 📊 Statistics

The app tracks your performance with:
- Total games played
- Win/loss/draw counts
- Win percentage
- Persistent storage across app sessions

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. **Fork the repository**
2. **Create a feature branch**: `git checkout -b feature/amazing-feature`
3. **Make your changes** and add tests if applicable
4. **Commit your changes**: `git commit -m 'Add amazing feature'`
5. **Push to the branch**: `git push origin feature/amazing-feature`
6. **Open a Pull Request**

### Development Guidelines
- Follow Dart/Flutter best practices
- Add documentation for new features
- Ensure code passes all linting rules
- Test on multiple platforms when possible

## 📝 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 👨‍💻 Developer

**Tejas** - 3rd year Computer Science student at the University of Cincinnati

Hey people, I recently started using GitHub. If there are any issues, email me at: ghodketg@mail.uc.edu

- GitHub: [@ghodketejas](https://github.com/ghodketejas)
- LinkedIn: [ghodketguc](https://www.linkedin.com/in/ghodketguc/)
- Project: [Advanced Tic Tac Toe](https://github.com/ghodketejas/advanced_tic_tac_toe)

---

## 🙏 Acknowledgments

- Inspired by the classic Ultimate Tic Tac Toe game
- Built with Flutter framework
- Icons from Material Design

---

⭐ **Star this repository if you found it helpful!**
