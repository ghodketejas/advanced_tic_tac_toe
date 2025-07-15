import 'package:flutter_test/flutter_test.dart';
import 'package:advanced_tic_tac_toe_game/game_logic.dart';

void main() {
  group('LocalBoard', () {
    test('Initial state is empty and no winner', () {
      final board = LocalBoard();
      expect(board.winner, '');
      for (var row in board.cells) {
        for (var cell in row) {
          expect(cell, '');
        }
      }
    });

    test('Player X wins with a row', () {
      final board = LocalBoard();
      board.makeMove(0, 0, 'X');
      board.makeMove(0, 1, 'X');
      board.makeMove(0, 2, 'X');
      expect(board.winner, 'X');
    });

    test('Player O wins with a column', () {
      final board = LocalBoard();
      board.makeMove(0, 1, 'O');
      board.makeMove(1, 1, 'O');
      board.makeMove(2, 1, 'O');
      expect(board.winner, 'O');
    });

    test('Draw is detected', () {
      final board = LocalBoard();
      // Fill the board with no winner
      final List<List<dynamic>> moves = [
        [0, 0, 'X'],
        [0, 1, 'O'],
        [0, 2, 'X'],
        [1, 0, 'O'],
        [1, 1, 'X'],
        [1, 2, 'O'],
        [2, 0, 'O'],
        [2, 1, 'X'],
        [2, 2, 'O'],
      ];
      for (var move in moves) {
        board.makeMove(move[0] as int, move[1] as int, move[2] as String);
      }
      expect(board.winner, 'Draw');
    });

    test('Invalid move is rejected', () {
      final board = LocalBoard();
      board.makeMove(0, 0, 'X');
      final result = board.makeMove(0, 0, 'O');
      expect(result, false);
    });
  });

  group('AdvancedTicTacToeGame', () {
    test('Initial state has no winner and player turn', () {
      final game = AdvancedTicTacToeGame();
      expect(game.winner, '');
      expect(game.isPlayerTurn, true);
    });

    test('Player move updates board and turn', () {
      final game = AdvancedTicTacToeGame();
      final moved = game.makePlayerMove(0, 0, 0, 0);
      expect(moved, true);
      expect(game.isPlayerTurn, false);
      expect(game.boards[0][0].cells[0][0], 'X');
    });

    test('Friend mode alternates turns', () {
      final game = AdvancedTicTacToeGame();
      final moved1 = game.makeFriendMove(0, 0, 0, 0);
      final moved2 = game.makeFriendMove(0, 0, 0, 1);
      expect(moved1, true);
      expect(moved2, true);
      expect(game.boards[0][0].cells[0][0], 'X');
      expect(game.boards[0][0].cells[0][1], 'O');
    });

    test('Game detects global winner', () {
      final game = AdvancedTicTacToeGame();
      // Simulate X winning all boards in the first row
      for (int bc = 0; bc < 3; bc++) {
        final board = game.boards[0][bc];
        board.cells = [
          ['X', 'X', 'X'],
          ['', '', ''],
          ['', '', ''],
        ];
        board.winner = 'X';
      }
      // Make a dummy valid move to trigger winner check
      game.makePlayerMove(1, 1, 0, 0);
      expect(game.winner, 'X');
    });
  });
}
