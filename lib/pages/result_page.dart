import 'package:flutter/material.dart';

class ResultPage extends StatelessWidget {
  const ResultPage({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    final String result = args?['result'] ?? '';
    final String gameMode = args?['gameMode'] ?? 'ai';

    String message;
    IconData icon;
    Color color;
    if (result == 'Draw') {
      message = "It's a Draw!";
      icon = Icons.sentiment_neutral;
      color = Colors.grey;
    } else if (gameMode == 'ai') {
      if (result == 'X') {
        message = 'You Win!';
        icon = Icons.emoji_events;
        color = const Color(0xFF00FFF7);
      } else {
        message = 'You Lose!';
        icon = Icons.sentiment_very_dissatisfied;
        color = const Color(0xFFFF9900);
      }
    } else {
      if (result == 'X') {
        message = 'Player X Wins!';
        icon = Icons.emoji_events;
        color = const Color(0xFF00FFF7);
      } else {
        message = 'Player O Wins!';
        icon = Icons.emoji_events;
        color = const Color(0xFFFF9900);
      }
    }

    return Scaffold(
      backgroundColor: const Color(0xFF181A20),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: color,
                size: 100,
                shadows: [
                  Shadow(
                    blurRadius: 32,
                    color: color.withOpacity(0.5),
                    offset: const Offset(0, 0),
                  ),
                ],
              ),
              const SizedBox(height: 32),
              Text(
                message,
                style: TextStyle(
                  fontSize: 36,
                  fontWeight: FontWeight.bold,
                  color: color,
                  shadows: [
                    Shadow(
                      blurRadius: 16,
                      color: color.withOpacity(0.5),
                      offset: const Offset(0, 0),
                    ),
                  ],
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(
                          '/game',
                          arguments: {
                            'mode': gameMode,
                            'playerStarts': true,
                          },
                        );
                      },
                      icon: const Icon(Icons.refresh, color: Colors.black),
                      label: const Text('Play Again',
                          style: TextStyle(color: Colors.black)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: color,
                        foregroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 18),
                        textStyle: const TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        shadowColor: color,
                        elevation: 12,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () {
                        Navigator.of(context)
                            .pushNamedAndRemoveUntil('/', (route) => false);
                      },
                      icon: const Icon(Icons.home, color: Colors.white70),
                      label: const Text('Main Menu',
                          style: TextStyle(color: Colors.white70)),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.white70, width: 2),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 0, vertical: 16),
                        textStyle: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
