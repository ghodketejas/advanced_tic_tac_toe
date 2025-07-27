import 'package:flutter/material.dart';
import '../widgets/custom_choice_chip.dart';

/// A page that allows users to select between different game modes
///
/// This page provides options for:
/// - Playing against a friend (no stats recorded)
/// - Playing against AI (stats recorded)
/// - Choosing who goes first in AI mode
class GameModeSelectionPage extends StatefulWidget {
  /// Creates a game mode selection page
  const GameModeSelectionPage({super.key});

  @override
  State<GameModeSelectionPage> createState() => _GameModeSelectionPageState();
}

/// State class for the game mode selection page
class _GameModeSelectionPageState extends State<GameModeSelectionPage> {
  String? selectedMode;
  bool playerStartsFirst = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF181A20),
      appBar: AppBar(
        title: const Text('Select Game Mode'),
        backgroundColor: const Color(0xFF23252B),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF00FFF7)),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                'Choose Your Game Mode',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 32),

              // Game Mode Options
              _buildModeOption(
                title: 'Play Against Friend',
                subtitle: 'No stats recorded',
                icon: Icons.people,
                mode: 'friend',
                color: Colors.green,
              ),
              const SizedBox(height: 16),
              _buildModeOption(
                title: 'Play Against AI',
                subtitle: 'Stats recorded and shown on main screen',
                icon: Icons.computer,
                mode: 'ai',
                color: Colors.blue,
              ),

              const SizedBox(height: 32),

              // Only show 'Who goes first?' for AI mode
              if (selectedMode == 'ai') ...[
                const Text(
                  'Who goes first?',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    CustomChoiceChip(
                      label: 'Player',
                      selected: playerStartsFirst,
                      onTap: () {
                        setState(() {
                          playerStartsFirst = true;
                        });
                      },
                      selectedColor: const Color(0xFF00FFF7),
                    ),
                    const SizedBox(width: 16),
                    CustomChoiceChip(
                      label: 'AI',
                      selected: !playerStartsFirst,
                      onTap: () {
                        setState(() {
                          playerStartsFirst = false;
                        });
                      },
                      selectedColor: const Color(0xFFFF9900),
                    ),
                  ],
                ),
                const SizedBox(height: 32),
              ],

              // Start Game Button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: selectedMode != null
                      ? () {
                          if (selectedMode == 'friend') {
                            Navigator.pushNamed(context, '/game', arguments: {
                              'mode': 'friend',
                              'playerStarts': true,
                            });
                          } else if (selectedMode == 'ai') {
                            Navigator.pushNamed(context, '/game', arguments: {
                              'mode': 'ai',
                              'playerStarts': playerStartsFirst,
                            });
                          }
                        }
                      : null,
                  icon: const Icon(Icons.play_arrow, color: Colors.black),
                  label: const Text('Start Game',
                      style: TextStyle(color: Colors.black)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: selectedMode != null
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.grey,
                    foregroundColor: Colors.black,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 18),
                    textStyle: const TextStyle(
                        fontSize: 20, fontWeight: FontWeight.bold),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    shadowColor: selectedMode != null
                        ? Theme.of(context).colorScheme.secondary
                        : Colors.grey,
                    elevation: selectedMode != null ? 12 : 0,
                  ),
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// Builds a selectable mode option card
  Widget _buildModeOption({
    required String title,
    required String subtitle,
    required IconData icon,
    required String mode,
    required Color color,
  }) {
    final isSelected = selectedMode == mode;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedMode = mode;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected ? color.withOpacity(0.15) : const Color(0xFF23252B),
          border: Border.all(
            color: isSelected ? color : Colors.white24,
            width: isSelected ? 2.5 : 1.5,
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: color.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.2),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                icon,
                color: color,
                size: 28,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isSelected ? color : Colors.white,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color:
                          isSelected ? color.withOpacity(0.8) : Colors.white70,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: color,
                size: 24,
              ),
          ],
        ),
      ),
    );
  }
}
