import 'package:flutter/material.dart';
import 'theme/app_theme.dart';
import 'pages/launch_page.dart';
import 'pages/game_mode_selection_page.dart';
import 'pages/game_page.dart';
import 'pages/settings_page.dart';
import 'pages/how_to_play_page.dart';
import 'pages/about_page.dart';
import 'pages/result_page.dart';

/// Main entry point for the Advanced Tic Tac Toe application
/// 
/// This function initializes and runs the Flutter app with the configured
/// theme and routing setup.
void main() => runApp(const AdvancedTicTacToeRoot());

/// Root widget for the Advanced Tic Tac Toe application
/// 
/// This widget configures the MaterialApp with:
/// - Dark theme with neon blue and orange colors
/// - Named routing for all pages
/// - App title and initial route
class AdvancedTicTacToeRoot extends StatelessWidget {
  /// Creates the root widget
  const AdvancedTicTacToeRoot({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Advanced Tic Tac Toe',
      theme: AppTheme.darkTheme,
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LaunchPage(),
        '/game_mode': (context) => const GameModeSelectionPage(),
        '/game': (context) => const AdvancedTicTacToePage(),
        '/settings': (context) => const SettingsPage(),
        '/howtoplay': (context) => const HowToPlayPage(),
        '/about': (context) => const AboutPage(),
        '/result': (context) => const ResultPage(),
      },
    );
  }
}