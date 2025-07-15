import 'package:flutter/material.dart';
import 'dart:async';
import '../game_logic.dart';
import '../stats_manager.dart';
import '../widgets/custom_choice_chip.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:ui';

/// The main game page for Advanced Tic Tac Toe
///
/// This page handles:
/// - Game board rendering and interaction
/// - AI vs Player gameplay
/// - Friend vs Friend gameplay
/// - Game state management and persistence
/// - Statistics tracking
class AdvancedTicTacToePage extends StatefulWidget {
  /// Creates the game page
  const AdvancedTicTacToePage({super.key});

  @override
  State<AdvancedTicTacToePage> createState() => _AdvancedTicTacToePageState();
}

/// State class for the game page
class _AdvancedTicTacToePageState extends State<AdvancedTicTacToePage> {
  final AdvancedTicTacToeGame game = AdvancedTicTacToeGame();
  bool isComputerThinking = false;
  bool playerStartsNextGame = true;
  final StatsManager stats = StatsManager();
  bool _isLoading = true;

  // Game mode variables
  String gameMode = 'ai'; // Default to AI mode
  bool recordStats = true; // Default to recording stats

  /// Gets the current game state key based on game mode
  String get _currentGameStateKey =>
      gameMode == 'ai' ? 'saved_game_state_ai' : 'saved_game_state_friend';

  @override
  void initState() {
    super.initState();
    _initializeGame();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Get arguments passed from the game mode selection page
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;
    if (args != null) {
      gameMode = args['mode'] ?? 'ai';
      playerStartsNextGame = args['playerStarts'] ?? true;
      recordStats = gameMode == 'ai';
    }
  }

  /// Initializes the game by loading stats and saved game state
  Future<void> _initializeGame() async {
    await stats.load();
    await _loadSavedGame();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _saveGame();
    super.dispose();
  }

  /// Loads the saved game state from persistent storage
  Future<void> _loadSavedGame() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final savedState = prefs.getString(_currentGameStateKey);

      if (savedState != null && savedState.isNotEmpty) {
        final gameData = jsonDecode(savedState);
        game.fromJson(gameData);

        // If there's an ongoing game, show a dialog asking if user wants to continue
        if (game.hasOngoingGame && game.winner.isEmpty) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            _showContinueGameDialog();
          });
        } else {
          // No ongoing game, start fresh
          _startNewGame();
        }
      } else {
        _startNewGame();
      }
    } catch (e) {
      // Error loading saved game, start fresh
      _startNewGame();
    }
  }

  /// Saves the current game state to persistent storage
  Future<void> _saveGame() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final gameState = jsonEncode(game.toJson());
      await prefs.setString(_currentGameStateKey, gameState);
    } catch (e) {
      // Error saving game state
    }
  }

  /// Shows a dialog asking if the user wants to continue a saved game
  void _showContinueGameDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF23252B),
          title: const Text(
            'Continue Saved Game?',
            style: TextStyle(color: Color(0xFF00FFF7)),
          ),
          content: const Text(
            'You have a saved game in progress. Would you like to continue it?',
            style: TextStyle(color: Colors.white),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                final prefs = await SharedPreferences.getInstance();
                await prefs.remove(_currentGameStateKey);
                setState(() {
                  _startNewGame();
                });
              },
              child: const Text(
                'Start New Game',
                style: TextStyle(color: Color(0xFFFF9900)),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {});
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF00FFF7),
                foregroundColor: Colors.black,
              ),
              child: const Text('Continue Game'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        backgroundColor: Color(0xFF181A20),
        body: Center(
          child: CircularProgressIndicator(
            color: Color(0xFF00FFF7),
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: const Color(0xFF181A20),
      appBar: AppBar(
        title: Text(gameMode == 'friend'
            ? 'Advanced Tic Tac Toe (Friend Mode)'
            : 'Advanced Tic Tac Toe (AI Mode)'),
        backgroundColor: const Color(0xFF23252B),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Color(0xFF00FFF7)),
          onPressed: () {
            _saveGame().then((_) {
              Navigator.of(context).pop();
            });
          },
        ),
        actions: [
          if (gameMode == 'ai')
            Padding(
              padding:
                  const EdgeInsets.only(right: 16.0, top: 8.0, bottom: 8.0),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: const Color(0xFF23252B),
                  borderRadius: BorderRadius.circular(12),
                  border:
                      Border.all(color: const Color(0xFF00FFF7), width: 1.2),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00FFF7).withOpacity(0.08),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.auto_awesome,
                        size: 18, color: Color(0xFF00FFF7)),
                    const SizedBox(width: 4),
                    Text(
                      'AI: ${game.difficulty}',
                      style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF00FFF7),
                        fontWeight: FontWeight.w600,
                        letterSpacing: 0.2,
                      ),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                // Status Card
                Card(
                  color: const Color(0xFF23252B),
                  elevation: 6,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  margin: const EdgeInsets.symmetric(horizontal: 32),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 18.0, horizontal: 24.0),
                    child: _buildStatusText(),
                  ),
                ),
                const SizedBox(height: 18),
                // Controls Card
                if (gameMode != 'friend')
                  Card(
                    color: const Color(0xFF23252B),
                    elevation: 4,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    margin: const EdgeInsets.symmetric(horizontal: 32),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 16.0, horizontal: 18.0),
                      child: _buildControls(),
                    ),
                  ),
                const SizedBox(height: 24),
                // Board
                _buildUltimateBoard(),
                const SizedBox(height: 28),
                // New Game Button
                _buildNewGameButton(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the status text showing current game state
  Widget _buildStatusText() {
    String statusText;
    Color statusColor;
    if (game.winner.isNotEmpty) {
      if (game.winner == 'Draw') {
        statusText = "It's a Draw!";
        statusColor = Colors.grey.shade400;
      } else if (gameMode == 'ai') {
        statusText = game.winner == 'X' ? 'You Win!' : 'Computer Wins!';
        statusColor = game.winner == 'X'
            ? const Color(0xFF00FFF7)
            : const Color(0xFFFF9900);
      } else {
        statusText = game.winner == 'X' ? 'Player X Wins!' : 'Player O Wins!';
        statusColor = game.winner == 'X'
            ? const Color(0xFF00FFF7)
            : const Color(0xFFFF9900);
      }
    } else if (gameMode == 'ai' && isComputerThinking) {
      statusText = 'Computer is thinking...';
      statusColor = const Color(0xFF00FFF7);
    } else {
      if (gameMode == 'ai') {
        statusText = game.isPlayerTurn ? 'Your Turn' : "Computer's Turn";
      } else {
        statusText = game.isPlayerTurn ? 'Player X Turn' : 'Player O Turn';
      }
      statusColor =
          game.isPlayerTurn ? const Color(0xFF00FFF7) : const Color(0xFFFF9900);
    }
    return Text(
      statusText,
      style: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: statusColor,
        shadows: [
          Shadow(
            blurRadius: 12,
            color: statusColor.withOpacity(0.7),
            offset: const Offset(0, 0),
          ),
        ],
      ),
    );
  }

  /// Builds the controls section for choosing who starts
  Widget _buildControls() {
    if (gameMode == 'friend') {
      // No controls in friend mode
      return const SizedBox.shrink();
    } else {
      return Wrap(
        alignment: WrapAlignment.center,
        spacing: 10,
        runSpacing: 8,
        children: [
          const Text('Who starts:',
              style: TextStyle(fontSize: 16, color: Colors.white70)),
          CustomChoiceChip(
            label: 'You',
            selected: playerStartsNextGame,
            onTap: () {
              setState(() {
                playerStartsNextGame = true;
              });
            },
            selectedColor: const Color(0xFF00FFF7),
          ),
          CustomChoiceChip(
            label: 'Computer',
            selected: !playerStartsNextGame,
            onTap: () {
              setState(() {
                playerStartsNextGame = false;
              });
            },
            selectedColor: const Color(0xFFFF9900),
          ),
        ],
      );
    }
  }

  /// Builds the main game board
  Widget _buildUltimateBoard() {
    // Responsive, perfectly centered and square board
    return LayoutBuilder(
      builder: (context, constraints) {
        double boardSize = (constraints.maxWidth * 0.95).clamp(0, 540);
        return Container(
          width: boardSize,
          height: boardSize,
          decoration: BoxDecoration(
            color: const Color(0xFF23252B),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFF00FFF7).withOpacity(0.15),
                blurRadius: 16,
                offset: const Offset(0, 8),
              ),
            ],
            border: Border.all(
              color: const Color(0xFFFF9900),
              width: 4,
            ),
          ),
          child: GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 6,
              mainAxisSpacing: 6,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              int boardRow = index ~/ 3;
              int boardCol = index % 3;
              return _buildLocalBoard(boardRow, boardCol);
            },
          ),
        );
      },
    );
  }

  /// Builds an individual local board (3x3 grid)
  Widget _buildLocalBoard(int boardRow, int boardCol) {
    final local = game.boards[boardRow][boardCol];
    final isActive = game.forcedBoard == null ||
        (game.forcedBoard![0] == boardRow && game.forcedBoard![1] == boardCol);
    final isFinished = local.isFinished;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        color: isActive && !isFinished
            ? Colors.transparent
            : const Color(0xFF23252B),
        border: Border.all(
          color: isActive && !isFinished
              ? const Color(0xFF00FFF7)
              : const Color(0xFFFF9900),
          width: isActive && !isFinished ? 3.0 : 2.0,
        ),
        borderRadius: BorderRadius.circular(10),
        boxShadow: const <BoxShadow>[],
      ),
      margin: EdgeInsets.zero,
      child: Stack(
        children: [
          _buildLocalCells(boardRow, boardCol, isActive && !isFinished),
          // Dim overlay for non-active, non-finished boards
          if (!isActive && !isFinished)
            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.35),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          // Blur overlay for won local grids (not draw)
          if (local.winner == 'X' || local.winner == 'O')
            Positioned.fill(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
                  child: Container(
                    color: (local.winner == 'X'
                            ? const Color(0xFF00FFF7)
                            : const Color(0xFFFF9900))
                        .withOpacity(0.18),
                  ),
                ),
              ),
            ),
          if (local.winner == 'X' ||
              local.winner == 'O' ||
              local.winner == 'Draw')
            Container(
              decoration: BoxDecoration(
                color: Colors.black.withOpacity(0.55),
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          if (local.winner == 'X' ||
              local.winner == 'O' ||
              local.winner == 'Draw')
            _buildLocalBoardOverlay(local),
        ],
      ),
    );
  }

  /// Builds the cells within a local board
  Widget _buildLocalCells(int boardRow, int boardCol, bool isActive) {
    final local = game.boards[boardRow][boardCol];
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 2,
        mainAxisSpacing: 2,
      ),
      itemCount: 9,
      itemBuilder: (context, index) {
        int cellRow = index ~/ 3;
        int cellCol = index % 3;
        final cellValue = local.cells[cellRow][cellCol];
        return LayoutBuilder(
          builder: (context, constraints) {
            final cellSize = constraints.biggest.shortestSide;
            return GestureDetector(
              onTap: isActive &&
                      cellValue.isEmpty &&
                      game.winner.isEmpty &&
                      (gameMode == 'friend' ||
                          (gameMode == 'ai' &&
                              game.isPlayerTurn &&
                              !isComputerThinking))
                  ? () => _onCellTap(boardRow, boardCol, cellRow, cellCol)
                  : null,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  border: Border.all(
                    color: const Color(0xFF00FFF7),
                    width: 1.0,
                  ),
                  borderRadius: BorderRadius.circular(4),
                ),
                margin: EdgeInsets.zero,
                child: Center(
                  child: AnimatedScale(
                    scale: cellValue.isNotEmpty ? 1.2 : 1.0,
                    duration: const Duration(milliseconds: 200),
                    child: cellValue.isEmpty
                        ? const SizedBox.shrink()
                        : cellValue == 'X'
                            ? _buildXSymbol(size: cellSize)
                            : _buildOSymbol(size: cellSize),
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  /// Builds the overlay for finished local boards
  Widget _buildLocalBoardOverlay(LocalBoard local) {
    if (local.winner == 'Draw') {
      return Center(
        child: Icon(Icons.remove, color: Colors.grey.shade700, size: 48),
      );
    } else if (local.winner == 'X' || local.winner == 'O') {
      return Center(
        child: SizedBox(
          width: 56,
          height: 56,
          child: CustomPaint(
            painter: local.winner == 'X'
                ? XSymbolPainter(
                    color: const Color(0xFF00FFF7),
                    strokeWidth: 4.0,
                  )
                : OSymbolPainter(
                    color: const Color(0xFFFF9900),
                    strokeWidth: 4.0,
                  ),
          ),
        ),
      );
    }
    return const SizedBox.shrink();
  }

  /// Builds the new game button
  Widget _buildNewGameButton() {
    return ElevatedButton.icon(
      onPressed: _onNewGamePressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFFF9900),
        foregroundColor: Colors.black,
        padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        shadowColor: const Color(0xFFFF9900),
        elevation: 12,
      ),
      icon: const Icon(Icons.refresh, color: Colors.black),
      label: const Text('New Game'),
    );
  }

  /// Handles the new game button press
  void _onNewGamePressed() {
    if (gameMode == 'ai' && game.winner.isEmpty && game.hasOngoingGame) {
      showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: const Color(0xFF23252B),
            title: const Text(
              'Restart Game?',
              style: TextStyle(color: Color(0xFFFF9900)),
            ),
            content: const Text(
              'Restarting will count as a loss. Are you sure you want to start a new game?',
              style: TextStyle(color: Colors.white),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text(
                  'Cancel',
                  style: TextStyle(color: Color(0xFF00FFF7)),
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    stats.incrementLoss();
                    _startNewGame();
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFF9900),
                  foregroundColor: Colors.black,
                ),
                child: const Text('Restart Anyway'),
              ),
            ],
          );
        },
      );
    } else {
      _resetGame();
    }
  }

  /// Handles cell tap events
  void _onCellTap(int boardRow, int boardCol, int cellRow, int cellCol) {
    if (game.winner.isEmpty) {
      bool validMove = false;
      if (gameMode == 'friend') {
        validMove = game.makeFriendMove(boardRow, boardCol, cellRow, cellCol);
        if (!validMove) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid move!'),
              duration: Duration(milliseconds: 900),
            ),
          );
          return;
        }
        setState(() {});
        if (game.winner.isNotEmpty) {
          _updateNextGameStarter();
        }
      } else if (gameMode == 'ai' && game.isPlayerTurn) {
        validMove = game.makePlayerMove(boardRow, boardCol, cellRow, cellCol);
        if (!validMove) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Invalid move!'),
              duration: Duration(milliseconds: 900),
            ),
          );
          return;
        }
        setState(() {
          if (game.winner.isNotEmpty) {
            _updateNextGameStarter();
          } else {
            isComputerThinking = true;
          }
        });
        // AI move for AI mode
        if (game.winner.isEmpty && !game.isPlayerTurn) {
          Timer(const Duration(milliseconds: 700), () {
            setState(() {
              game.computerMove();
              isComputerThinking = false;
              if (game.winner.isNotEmpty) {
                _updateNextGameStarter();
              }
            });
            _saveGame();
          });
        }
      }
      _saveGame();
    }
  }

  /// Resets the game to start a new one
  void _resetGame() {
    setState(() {
      _startNewGame();
    });
  }

  /// Starts a new game with the current settings
  void _startNewGame() {
    game.resetGame(playerStarts: playerStartsNextGame);
    game.difficulty = 50;
    isComputerThinking = false;

    // Only start with AI move for AI mode
    if (gameMode == 'ai' && !playerStartsNextGame) {
      isComputerThinking = true;
      Timer(const Duration(milliseconds: 700), () {
        setState(() {
          game.computerMove();
          isComputerThinking = false;
        });
        // Save after computer's first move
        _saveGame();
      });
    }

    // Save the new game state
    _saveGame();
  }

  /// Updates the next game starter based on the current game result
  void _updateNextGameStarter() {
    if (game.winner == 'X') {
      playerStartsNextGame = false;
      if (recordStats) {
        stats.incrementWin();
      }
    } else if (game.winner == 'O') {
      playerStartsNextGame = true;
      if (recordStats) {
        stats.incrementLoss();
      }
    } else if (game.winner == 'Draw') {
      if (recordStats) {
        stats.incrementDraw();
      }
    }
    // If it's a draw, keep the current starter
    if (game.winner.isNotEmpty) {
      Future.delayed(const Duration(milliseconds: 400), () {
        Navigator.of(context).pushReplacementNamed(
          '/result',
          arguments: {
            'result': game.winner,
            'gameMode': gameMode,
          },
        );
      });
    }
  }

  /// Builds a custom X symbol with proper alignment
  Widget _buildXSymbol({required double size}) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: XSymbolPainter(
          color: const Color(0xFF00FFF7),
          strokeWidth: size * 0.13, // proportional stroke
        ),
      ),
    );
  }

  /// Builds a custom O symbol with proper alignment
  Widget _buildOSymbol({required double size}) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: OSymbolPainter(
          color: const Color(0xFFFF9900),
          strokeWidth: size * 0.13, // proportional stroke
        ),
      ),
    );
  }
}

/// Custom painter for X symbol
class XSymbolPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  XSymbolPainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final padding = strokeWidth;
    canvas.drawLine(
      Offset(padding, padding),
      Offset(size.width - padding, size.height - padding),
      paint,
    );
    canvas.drawLine(
      Offset(size.width - padding, padding),
      Offset(padding, size.height - padding),
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom painter for O symbol
class OSymbolPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  OSymbolPainter({required this.color, required this.strokeWidth});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    final padding = strokeWidth;
    final rect = Rect.fromLTWH(
      padding,
      padding,
      size.width - 2 * padding,
      size.height - 2 * padding,
    );
    canvas.drawOval(rect, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
