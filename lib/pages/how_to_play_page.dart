import 'package:flutter/material.dart';

/// How to Play page that explains the rules of Advanced Tic Tac Toe
///
/// This page provides a comprehensive guide to the game including:
/// - Visual diagrams explaining the game board structure
/// - Step-by-step instructions for gameplay
/// - Examples of moves and their consequences
/// - Tips for strategic play
class HowToPlayPage extends StatelessWidget {
  /// Creates a how to play page
  const HowToPlayPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('How to Play')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Welcome to Advanced Tic Tac Toe!\n\n'
                "This isn't your grandma's tic-tac-toe. Here's how it works (grab a snack, it's fun!):\n\n",
                style: TextStyle(fontSize: 18),
              ),
              const Text(
                '1. The Big Picture: You\'re playing on a 3x3 grid of tic-tac-toe boards. That\'s right, tic-tac-toe IN tic-tac-toe.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              _BigBoardDiagram(),
              const SizedBox(height: 20),
              const Text(
                '2. Making a Move: On your turn, pick any empty cell in the highlighted (active) small board.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              _ActiveBoardDiagram(),
              const SizedBox(height: 20),
              const Text(
                '3. Sending Your Opponent: The cell you pick decides which small board your opponent must play in next. For example, if you play in the top-right cell of your board, your opponent must play in the top-right board next.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              _ExampleMoveDiagram(),
              const SizedBox(height: 20),
              const Text(
                '4. What if the board is full or already won? If you send your opponent to a board that\'s finished, they can play in ANY unfinished board. Freedom!',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              _FreeMoveDiagram(),
              const SizedBox(height: 20),
              const Text(
                '5. Winning a Local Board: Win a small board by getting three in a row (classic rules).',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              _LocalBoardWinDiagram(),
              const SizedBox(height: 20),
              const Text(
                '6. Winning the Game: Win the big game by winning three small boards in a row (horizontally, vertically, or diagonally).',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              _GlobalBoardWinDiagram(),
              const SizedBox(height: 20),
              const Text(
                '7. Draws: If all boards are finished and no one has three in a row, it\'s a draw.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 8),
              _DrawBoardDiagram(),
              const SizedBox(height: 20),
              const Text(
                'Example Time! Let\'s say you play in the bottom-left cell of the center board. Your opponent now has to play in the bottom-left board. If that board is full, they can play anywhere.',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              const Text(
                'Pro Tips:\n- Think ahead! Your move decides your opponent\'s options.\n- Try to control where your opponent goes.\n- Don\'t forget to have fun (and maybe confuse your friends).\n\nReady to become the ultimate tic-tac-toe champion? Go play!\n',
                style: TextStyle(fontSize: 18),
              ),
              const SizedBox(height: 20),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color:
                      Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: Theme.of(context)
                        .colorScheme
                        .secondary
                        .withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: Theme.of(context).colorScheme.secondary,
                      size: 24,
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Fun fact: The AI keeps upgrading and downgrading its difficulty based on your performance. Can you keep up?',
                        style: TextStyle(
                          fontSize: 16,
                          fontStyle: FontStyle.italic,
                          color: Theme.of(context).colorScheme.secondary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Add diagram widgets below:
class _BigBoardDiagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.3), width: 2),
              ),
              child: Table(
                border:
                    TableBorder.all(color: color.withOpacity(0.5), width: 2),
                defaultColumnWidth: const FixedColumnWidth(36),
                children: List.generate(
                  3,
                  (i) => TableRow(
                    children: List.generate(
                      3,
                      (j) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: color.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: Icon(Icons.grid_3x3,
                              size: 22, color: color.withOpacity(0.7)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Text('The "big board": 3x3 grid of tic-tac-toe boards',
              style: TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey)),
        ],
      ),
    );
  }
}

class _ExampleMoveDiagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final accent = Theme.of(context).colorScheme.secondary;
    // Big board: 3x3 of mini-boards
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: Stack(
              children: [
                // Big 3x3 board of boards
                GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    crossAxisSpacing: 6,
                    mainAxisSpacing: 6,
                  ),
                  itemCount: 9,
                  itemBuilder: (context, idx) {
                    int row = idx ~/ 3;
                    int col = idx % 3;
                    bool isCurrent = row == 1 && col == 1;
                    bool isTarget = row == 0 && col == 2;
                    return Container(
                      decoration: BoxDecoration(
                        color: isCurrent
                            ? accent.withOpacity(0.18)
                            : (isTarget
                                ? Colors.orange.withOpacity(0.13)
                                : color.withOpacity(0.07)),
                        border: Border.all(
                          color: isCurrent
                              ? accent
                              : (isTarget
                                  ? Colors.orange
                                  : color.withOpacity(0.4)),
                          width: isCurrent || isTarget ? 2.2 : 1.2,
                        ),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: isCurrent ? _MiniBoardWithXAndArrow() : null,
                    );
                  },
                ),
                // Arrow from center board's top-right cell to top-right board
                Positioned(
                  left: 100,
                  top: 28,
                  child: Transform.rotate(
                    angle: -0.5,
                    child: const Icon(Icons.arrow_outward,
                        color: Colors.orange, size: 36),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          const Text(
              'Playing X in top-right cell of center board sends opponent to top-right board',
              style: TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey)),
        ],
      ),
    );
  }
}

class _MiniBoardWithXAndArrow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // 3x3 mini-board, X in top-right
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Table(
        border: TableBorder.all(color: Colors.grey.shade400, width: 1),
        defaultColumnWidth: const FixedColumnWidth(12),
        children: [
          TableRow(children: [
            _cell(),
            _cell(),
            _cell(x: true),
          ]),
          TableRow(children: [
            _cell(),
            _cell(),
            _cell(),
          ]),
          TableRow(children: [
            _cell(),
            _cell(),
            _cell(),
          ]),
        ],
      ),
    );
  }

  Widget _cell({bool x = false}) => Container(
        height: 14,
        width: 14,
        alignment: Alignment.center,
        child: x
            ? const Text('X',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.orange,
                    fontSize: 13))
            : null,
      );
}

class _FreeMoveDiagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.3), width: 2),
              ),
              child: Table(
                border:
                    TableBorder.all(color: color.withOpacity(0.5), width: 2),
                defaultColumnWidth: const FixedColumnWidth(36),
                children: [
                  TableRow(children: [
                    _boardBlocked(),
                    _boardFree(),
                    _boardFree(),
                  ]),
                  TableRow(children: [
                    _boardFree(),
                    _boardFree(),
                    _boardFree(),
                  ]),
                  TableRow(children: [
                    _boardFree(),
                    _boardFree(),
                    _boardFree(),
                  ]),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Text(
              'If a board is blocked, you can play in any available board!',
              style: TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _boardBlocked() => Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: Colors.red.withOpacity(0.18),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.red, width: 2),
        ),
        child:
            const Center(child: Icon(Icons.block, color: Colors.red, size: 22)),
      );
  Widget _boardFree() => Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: Colors.green.withOpacity(0.10),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: Colors.green, width: 1),
        ),
        child: null,
      );
}

// Add this new diagram widget for the active board highlight:
class _ActiveBoardDiagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final accent = Theme.of(context).colorScheme.secondary;
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.3), width: 2),
              ),
              child: Table(
                border:
                    TableBorder.all(color: color.withOpacity(0.5), width: 2),
                defaultColumnWidth: const FixedColumnWidth(36),
                children: List.generate(
                  3,
                  (i) => TableRow(
                    children: List.generate(
                      3,
                      (j) => Padding(
                        padding: const EdgeInsets.all(4.0),
                        child: Container(
                          height: 36,
                          width: 36,
                          decoration: BoxDecoration(
                            color: (i == 1 && j == 1)
                                ? accent.withOpacity(0.18)
                                : color.withOpacity(0.07),
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: (i == 1 && j == 1)
                              ? Icon(Icons.star, color: accent, size: 22)
                              : Icon(Icons.grid_3x3,
                                  size: 22, color: color.withOpacity(0.7)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Text('The highlighted board is where you must play!',
              style: TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey)),
        ],
      ),
    );
  }
}

// Add diagram widgets for points 5, 6, 7:
class _LocalBoardWinDiagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final accent = Theme.of(context).colorScheme.secondary;
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.3), width: 2),
              ),
              child: Table(
                border:
                    TableBorder.all(color: color.withOpacity(0.5), width: 2),
                defaultColumnWidth: const FixedColumnWidth(36),
                children: [
                  TableRow(children: [
                    _cellX(accent),
                    _cellX(accent),
                    _cellX(accent),
                  ]),
                  TableRow(children: [
                    _cell(),
                    _cell(),
                    _cell(),
                  ]),
                  TableRow(children: [
                    _cell(),
                    _cell(),
                    _cell(),
                  ]),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Text('Three X\'s in a row wins the local board!',
              style: TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _cell() => Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
      );
  Widget _cellX(Color accent) => Container(
        height: 36,
        width: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: Text('X',
            style: TextStyle(
                fontWeight: FontWeight.bold, color: accent, fontSize: 28)),
      );
}

class _GlobalBoardWinDiagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    final accent = Theme.of(context).colorScheme.secondary;
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.3), width: 2),
              ),
              child: Table(
                border:
                    TableBorder.all(color: color.withOpacity(0.5), width: 2),
                defaultColumnWidth: const FixedColumnWidth(36),
                children: [
                  TableRow(children: [
                    _boardWin(accent),
                    _boardWin(accent),
                    _boardWin(accent),
                  ]),
                  TableRow(children: [
                    _board(),
                    _board(),
                    _board(),
                  ]),
                  TableRow(children: [
                    _board(),
                    _board(),
                    _board(),
                  ]),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Text('Win three boards in a row to win the game!',
              style: TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _board() => Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
      );
  Widget _boardWin(Color accent) => Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
          color: accent.withOpacity(0.18),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: accent, width: 2),
        ),
        child: Center(child: Icon(Icons.emoji_events, color: accent, size: 22)),
      );
}

class _DrawBoardDiagram extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: Column(
        children: [
          SizedBox(
            width: 160,
            height: 160,
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.surface,
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: color.withOpacity(0.3), width: 2),
              ),
              child: Table(
                border:
                    TableBorder.all(color: color.withOpacity(0.5), width: 2),
                defaultColumnWidth: const FixedColumnWidth(36),
                children: [
                  TableRow(children: [
                    _drawCell(),
                    _drawCell(),
                    _drawCell(),
                  ]),
                  TableRow(children: [
                    _drawCell(),
                    _drawCell(),
                    _drawCell(),
                  ]),
                  TableRow(children: [
                    _drawCell(),
                    _drawCell(),
                    _drawCell(),
                  ]),
                ],
              ),
            ),
          ),
          const SizedBox(height: 6),
          const Text('All boards finished, no winner: it\'s a draw!',
              style: TextStyle(
                  fontSize: 13,
                  fontStyle: FontStyle.italic,
                  color: Colors.grey)),
        ],
      ),
    );
  }

  Widget _drawCell() => Container(
        height: 36,
        width: 36,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(6),
        ),
        child: const Icon(Icons.remove, color: Colors.grey, size: 22),
      );
}
