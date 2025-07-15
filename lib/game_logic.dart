import 'dart:math';

/// Represents the state of a local 3x3 board in Ultimate Tic-Tac-Toe.
class LocalBoard {
  /// 3x3 grid of cells: '', 'X', or 'O'.
  List<List<String>> cells = List.generate(3, (_) => List.filled(3, ''));

  /// 'X', 'O', 'Draw', or '' (ongoing)
  String winner = '';

  /// Returns true if the board is full or has a winner.
  bool get isFinished => winner.isNotEmpty || !_hasEmptyCell();

  /// Make a move for [player] at [row], [col]. Returns true if move is valid.
  bool makeMove(int row, int col, String player) {
    if (winner.isNotEmpty || !_isValidMove(row, col)) return false;
    cells[row][col] = player;
    _checkWinner();
    return true;
  }

  /// Checks for a winner or draw and updates [winner].
  void _checkWinner() {
    for (int i = 0; i < 3; i++) {
      if (cells[i][0] != '' &&
          cells[i][0] == cells[i][1] &&
          cells[i][1] == cells[i][2]) {
        winner = cells[i][0];
        return;
      }
      if (cells[0][i] != '' &&
          cells[0][i] == cells[1][i] &&
          cells[1][i] == cells[2][i]) {
        winner = cells[0][i];
        return;
      }
    }
    if (cells[0][0] != '' &&
        cells[0][0] == cells[1][1] &&
        cells[1][1] == cells[2][2]) {
      winner = cells[0][0];
      return;
    }
    if (cells[0][2] != '' &&
        cells[0][2] == cells[1][1] &&
        cells[1][1] == cells[2][0]) {
      winner = cells[0][2];
      return;
    }
    if (!_hasEmptyCell()) {
      winner = 'Draw';
    }
  }

  /// Returns true if the move is within bounds and the cell is empty.
  bool _isValidMove(int row, int col) {
    return row >= 0 &&
        row < 3 &&
        col >= 0 &&
        col < 3 &&
        cells[row][col].isEmpty;
  }

  /// Returns true if there is at least one empty cell.
  bool _hasEmptyCell() {
    for (var row in cells) {
      for (var cell in row) {
        if (cell.isEmpty) return true;
      }
    }
    return false;
  }

  /// Resets the board.
  void reset() {
    cells = List.generate(3, (_) => List.filled(3, ''));
    winner = '';
  }

  /// Convert board state to JSON for saving
  Map<String, dynamic> toJson() {
    return {
      'cells': cells,
      'winner': winner,
    };
  }

  /// Load board state from JSON
  void fromJson(Map<String, dynamic> json) {
    if (json['cells'] != null) {
      var cellsData = json['cells'] as List;
      cells = cellsData
          .map((row) => (row as List).map((cell) => cell.toString()).toList())
          .toList();
    }
    winner = json['winner']?.toString() ?? '';
  }
}

/// Ultimate Tic-Tac-Toe game logic.
///
/// The board is a 3x3 grid of LocalBoards. Each move sends the next player to a specific local board.
class AdvancedTicTacToeGame {
  /// 3x3 grid of LocalBoards.
  List<List<LocalBoard>> boards =
      List.generate(3, (_) => List.generate(3, (_) => LocalBoard()));

  /// 'X' (player) or 'O' (computer). True if it's player's turn.
  bool isPlayerTurn = true;

  /// 'X', 'O', 'Draw', or '' (ongoing)
  String winner = '';

  /// Difficulty from 0 (easiest) to 100 (hardest). Higher means smarter AI.
  int difficulty = 50;

  /// The local board (row, col) the next move must be played in. If null, any unfinished board is allowed.
  /// Example: if last move was in cell (2, 1) of a local board, next move must be in local board (2, 1).
  List<int>? forcedBoard;

  /// Make a move for the player at [boardRow], [boardCol], [cellRow], [cellCol].
  /// Returns true if move is valid and made.
  bool makePlayerMove(int boardRow, int boardCol, int cellRow, int cellCol) {
    if (!isPlayerTurn || winner.isNotEmpty) return false;
    if (!_isValidMove(boardRow, boardCol, cellRow, cellCol)) return false;
    bool moved = boards[boardRow][boardCol].makeMove(cellRow, cellCol, 'X');
    if (moved) {
      isPlayerTurn = false;
      _updateForcedBoard(cellRow, cellCol);
      _checkWinner();
    }
    return moved;
  }

  /// Make a move for friend mode (both players take turns).
  /// Returns true if move is valid and made.
  bool makeFriendMove(int boardRow, int boardCol, int cellRow, int cellCol) {
    if (winner.isNotEmpty) return false;
    if (!_isValidMove(boardRow, boardCol, cellRow, cellCol)) return false;
    String currentPlayer = isPlayerTurn ? 'X' : 'O';
    bool moved =
        boards[boardRow][boardCol].makeMove(cellRow, cellCol, currentPlayer);
    if (moved) {
      isPlayerTurn = !isPlayerTurn;
      _updateForcedBoard(cellRow, cellCol);
      _checkWinner();
    }
    return moved;
  }

  /// Make a move for the computer (AI).
  void computerMove() {
    if (isPlayerTurn || winner.isNotEmpty) return;
    // AI chooses move based on difficulty
    var move = (Random().nextInt(100) < difficulty)
        ? _findBestMove('O')
        : _findRandomMove();
    if (move != null) {
      boards[move[0]][move[1]].makeMove(move[2], move[3], 'O');
      isPlayerTurn = true;
      _updateForcedBoard(move[2], move[3]);
      _checkWinner();
    }
  }

  /// Returns a random valid move as [boardRow, boardCol, cellRow, cellCol], or null if no moves.
  List<int>? _findRandomMove() {
    List<List<int>> possibleMoves = [];
    for (int br = 0; br < 3; br++) {
      for (int bc = 0; bc < 3; bc++) {
        if (!_canPlayInBoard(br, bc)) continue;
        for (int cr = 0; cr < 3; cr++) {
          for (int cc = 0; cc < 3; cc++) {
            if (boards[br][bc].cells[cr][cc].isEmpty) {
              possibleMoves.add([br, bc, cr, cc]);
            }
          }
        }
      }
    }
    if (possibleMoves.isEmpty) return null;
    return possibleMoves[Random().nextInt(possibleMoves.length)];
  }

  /// Returns the best move for [player] as [boardRow, boardCol, cellRow, cellCol], or null if no moves.
  /// For now, this is a simple AI: tries to win a local board, then block, else random.
  List<int>? _findBestMove(String player) {
    String opponent = player == 'X' ? 'O' : 'X';
    // 1. Try to win a local board
    for (int br = 0; br < 3; br++) {
      for (int bc = 0; bc < 3; bc++) {
        if (!_canPlayInBoard(br, bc)) continue;
        for (int cr = 0; cr < 3; cr++) {
          for (int cc = 0; cc < 3; cc++) {
            if (boards[br][bc].cells[cr][cc].isEmpty) {
              boards[br][bc].cells[cr][cc] = player;
              boards[br][bc]._checkWinner();
              if (boards[br][bc].winner == player) {
                boards[br][bc].cells[cr][cc] = '';
                boards[br][bc].winner = '';
                return [br, bc, cr, cc];
              }
              boards[br][bc].cells[cr][cc] = '';
              boards[br][bc].winner = '';
            }
          }
        }
      }
    }
    // 2. Try to block opponent from winning a local board
    for (int br = 0; br < 3; br++) {
      for (int bc = 0; bc < 3; bc++) {
        if (!_canPlayInBoard(br, bc)) continue;
        for (int cr = 0; cr < 3; cr++) {
          for (int cc = 0; cc < 3; cc++) {
            if (boards[br][bc].cells[cr][cc].isEmpty) {
              boards[br][bc].cells[cr][cc] = opponent;
              boards[br][bc]._checkWinner();
              if (boards[br][bc].winner == opponent) {
                boards[br][bc].cells[cr][cc] = '';
                boards[br][bc].winner = '';
                return [br, bc, cr, cc];
              }
              boards[br][bc].cells[cr][cc] = '';
              boards[br][bc].winner = '';
            }
          }
        }
      }
    }
    // 3. Otherwise, random move
    return _findRandomMove();
  }

  /// Updates the forced board for the next move.
  void _updateForcedBoard(int cellRow, int cellCol) {
    if (boards[cellRow][cellCol].isFinished) {
      forcedBoard = null; // Any unfinished board allowed
    } else {
      forcedBoard = [cellRow, cellCol];
    }
  }

  /// Checks for a global winner or draw and updates [winner].
  void _checkWinner() {
    // Build a 3x3 meta-board of local winners
    List<List<String>> meta =
        List.generate(3, (i) => List.generate(3, (j) => boards[i][j].winner));
    for (int i = 0; i < 3; i++) {
      if (meta[i][0] != '' &&
          meta[i][0] != 'Draw' &&
          meta[i][0] == meta[i][1] &&
          meta[i][1] == meta[i][2]) {
        winner = meta[i][0];
        _adjustDifficulty(winner == 'O');
        return;
      }
      if (meta[0][i] != '' &&
          meta[0][i] != 'Draw' &&
          meta[0][i] == meta[1][i] &&
          meta[1][i] == meta[2][i]) {
        winner = meta[0][i];
        _adjustDifficulty(winner == 'O');
        return;
      }
    }
    if (meta[0][0] != '' &&
        meta[0][0] != 'Draw' &&
        meta[0][0] == meta[1][1] &&
        meta[1][1] == meta[2][2]) {
      winner = meta[0][0];
      _adjustDifficulty(winner == 'O');
      return;
    }
    if (meta[0][2] != '' &&
        meta[0][2] != 'Draw' &&
        meta[0][2] == meta[1][1] &&
        meta[1][1] == meta[2][0]) {
      winner = meta[0][2];
      _adjustDifficulty(winner == 'O');
      return;
    }
    // Draw if all boards are finished and no winner
    if (_allBoardsFinished()) {
      winner = 'Draw';
    }
  }

  /// Returns true if all local boards are finished.
  bool _allBoardsFinished() {
    for (var row in boards) {
      for (var board in row) {
        if (!board.isFinished) return false;
      }
    }
    return true;
  }

  /// Returns true if the move is valid according to Ultimate Tic-Tac-Toe rules.
  bool _isValidMove(int boardRow, int boardCol, int cellRow, int cellCol) {
    if (winner.isNotEmpty) return false;
    if (!_canPlayInBoard(boardRow, boardCol)) return false;
    return boards[boardRow][boardCol].cells[cellRow][cellCol].isEmpty;
  }

  /// Returns true if the player can play in the given local board.
  bool _canPlayInBoard(int boardRow, int boardCol) {
    if (boards[boardRow][boardCol].isFinished) return false;
    if (forcedBoard == null) return true;
    return forcedBoard![0] == boardRow && forcedBoard![1] == boardCol;
  }

  /// Adjusts difficulty: increase if computer won, decrease if player won.
  void _adjustDifficulty(bool computerWon) {
    if (computerWon) {
      difficulty = min(100, difficulty + 10);
    } else {
      difficulty = max(0, difficulty - 10);
    }
  }

  /// Resets the game. Optionally set who starts first.
  void resetGame({bool? playerStarts}) {
    boards = List.generate(3, (_) => List.generate(3, (_) => LocalBoard()));
    winner = '';
    forcedBoard = null;
    if (playerStarts != null) {
      isPlayerTurn = playerStarts;
    }
  }

  /// Sets who starts first: true for player, false for computer.
  void setFirstTurn(bool playerStarts) {
    isPlayerTurn = playerStarts;
  }

  /// Convert game state to JSON for saving
  Map<String, dynamic> toJson() {
    return {
      'boards': boards
          .map((row) => row.map((board) => board.toJson()).toList())
          .toList(),
      'isPlayerTurn': isPlayerTurn,
      'winner': winner,
      'difficulty': difficulty,
      'forcedBoard': forcedBoard,
    };
  }

  /// Load game state from JSON
  void fromJson(Map<String, dynamic> json) {
    if (json['boards'] != null) {
      var boardsData = json['boards'] as List;
      boards = boardsData
          .map((row) => (row as List).map((boardData) {
                var board = LocalBoard();
                board.fromJson(boardData as Map<String, dynamic>);
                return board;
              }).toList())
          .toList();
    }
    isPlayerTurn = json['isPlayerTurn'] ?? true;
    winner = json['winner']?.toString() ?? '';
    difficulty = json['difficulty'] ?? 50;

    // Handle forcedBoard conversion
    if (json['forcedBoard'] != null) {
      var forcedBoardData = json['forcedBoard'] as List;
      forcedBoard = forcedBoardData.map((item) => item as int).toList();
    } else {
      forcedBoard = null;
    }
  }

  /// Check if there's an ongoing game (not finished and has moves)
  bool get hasOngoingGame {
    if (winner.isNotEmpty) return false;

    // Check if any board has moves
    for (var row in boards) {
      for (var board in row) {
        for (var cellRow in board.cells) {
          for (var cell in cellRow) {
            if (cell.isNotEmpty) return true;
          }
        }
      }
    }
    return false;
  }
}
