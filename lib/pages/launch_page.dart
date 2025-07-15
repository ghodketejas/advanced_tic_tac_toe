import 'package:flutter/material.dart';
import '../widgets/floating_grids_background.dart';
import '../widgets/stat_box.dart';
import '../stats_manager.dart';

/// The main launch page of the Advanced Tic Tac Toe app
///
/// This page serves as the home screen and includes:
/// - Animated background with floating grids
/// - Game title with animations
/// - Navigation buttons to start game, how to play, and about
/// - Statistics display for AI games
class LaunchPage extends StatelessWidget {
  /// Creates a launch page
  const LaunchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const _LaunchPageContent();
  }
}

/// The content widget for the launch page
class _LaunchPageContent extends StatefulWidget {
  /// Creates the launch page content
  const _LaunchPageContent();

  @override
  State<_LaunchPageContent> createState() => _LaunchPageContentState();
}

/// State class for the launch page content
class _LaunchPageContentState extends State<_LaunchPageContent>
    with TickerProviderStateMixin {
  final StatsManager stats = StatsManager();
  bool _loading = true;
  late AnimationController _backgroundController;
  late AnimationController _gridController1;
  late AnimationController _gridController2;
  late AnimationController _gridController3;

  @override
  void initState() {
    super.initState();
    _loadStats();

    // Initialize animation controllers
    _backgroundController = AnimationController(
      duration: const Duration(seconds: 20),
      vsync: this,
    )..repeat();

    _gridController1 = AnimationController(
      duration: const Duration(seconds: 15),
      vsync: this,
    )..repeat();

    _gridController2 = AnimationController(
      duration: const Duration(seconds: 12),
      vsync: this,
    )..repeat();

    _gridController3 = AnimationController(
      duration: const Duration(seconds: 18),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _backgroundController.dispose();
    _gridController1.dispose();
    _gridController2.dispose();
    _gridController3.dispose();
    super.dispose();
  }

  /// Loads statistics from persistent storage
  Future<void> _loadStats() async {
    try {
      await stats.load();
      setState(() {
        _loading = false;
      });
    } catch (e) {
      // Error loading stats
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          // Animated background
          FloatingGridsBackground(
            backgroundController: _backgroundController,
            gridController1: _gridController1,
            gridController2: _gridController2,
            gridController3: _gridController3,
            screenSize: screenSize,
          ),
          // Main content
          SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 32),
                    // Animated Title
                    TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.8, end: 1.0),
                      duration: const Duration(milliseconds: 1200),
                      curve: Curves.elasticOut,
                      builder: (context, value, child) => Transform.scale(
                        scale: value,
                        child: child,
                      ),
                      child: Text(
                        'Advanced Tic Tac Toe',
                        style: TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                          shadows: [
                            Shadow(
                              blurRadius: 24,
                              color: Theme.of(context)
                                  .colorScheme
                                  .primary
                                  .withOpacity(0.7),
                              offset: const Offset(0, 0),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Start Game Button
                    ElevatedButton.icon(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/game_mode'),
                      icon: const Icon(Icons.play_arrow, color: Colors.black),
                      label: const Text('Start Game',
                          style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            Theme.of(context).colorScheme.secondary,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 18),
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        shadowColor: Theme.of(context).colorScheme.secondary,
                        elevation: 12,
                      ),
                    ),
                    const SizedBox(height: 20),
                    // How to Play Button
                    OutlinedButton.icon(
                      onPressed: () =>
                          Navigator.pushNamed(context, '/howtoplay'),
                      icon: Icon(Icons.help_outline,
                          color: Theme.of(context).colorScheme.secondary),
                      label: Text('How to Play',
                          style: TextStyle(
                              color: Theme.of(context).colorScheme.secondary)),
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                            color: Theme.of(context).colorScheme.secondary,
                            width: 2),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),
                    // About/Credits Button
                    OutlinedButton.icon(
                      onPressed: () => Navigator.pushNamed(context, '/about'),
                      icon:
                          const Icon(Icons.info_outline, color: Colors.white70),
                      label: const Text('About / Credits',
                          style: TextStyle(color: Colors.white70)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white70, width: 2),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 14),
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Stats display
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24, vertical: 12),
                      decoration: BoxDecoration(
                        color: Theme.of(context)
                            .colorScheme
                            .surface
                            .withOpacity(0.9),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: Theme.of(context).colorScheme.primary,
                            width: 1.2),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: _loading
                          ? const SizedBox(
                              height: 60,
                              child: Center(child: CircularProgressIndicator()))
                          : Column(
                              children: [
                                Text('Stats',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context)
                                            .colorScheme
                                            .primary)),
                                const SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    StatBox(
                                        label: 'Wins',
                                        value: stats.wins,
                                        color: Colors.greenAccent),
                                    const SizedBox(width: 12),
                                    StatBox(
                                        label: 'Losses',
                                        value: stats.losses,
                                        color: Colors.redAccent),
                                    const SizedBox(width: 12),
                                    StatBox(
                                        label: 'Draws',
                                        value: stats.draws,
                                        color: Colors.amberAccent),
                                  ],
                                ),
                              ],
                            ),
                    ),
                    const SizedBox(height: 32),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
