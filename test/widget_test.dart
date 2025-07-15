// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you can send tap and scroll
// gestures. You can also use WidgetTester to find child widgets in the widget
// tree, read text, and verify that the values of widget properties are correct.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:advanced_tic_tac_toe_game/main.dart';

void main() {
  testWidgets('Advanced Tic Tac Toe UI renders and allows a player move',
      (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const AdvancedTicTacToeRoot());
    await tester.pump(const Duration(seconds: 1));

    // Check for the main title
    expect(find.text('Advanced Tic Tac Toe'), findsOneWidget);

    // Tap the 'Start Game' button on the launch page
    await tester.tap(find.text('Start Game'));
    await tester.pump(const Duration(seconds: 1));

    // Select 'Play Against AI' mode
    await tester.tap(
      find.ancestor(
        of: find.text('Play Against AI'),
        matching: find.byType(GestureDetector),
      ).first,
    );
    await tester.pump(const Duration(seconds: 1));

    // Tap the 'Start Game' button on the game mode selection page
    await tester.tap(find.widgetWithText(ElevatedButton, 'Start Game'));
    await tester.pump(const Duration(seconds: 1));

    // There should be at least one local board (Stack)
    expect(find.byType(Stack), findsWidgets);

    // There should be 81 cells (GestureDetector for each cell)
    expect(find.byType(GestureDetector), findsNWidgets(81));

    // Tap the first available cell (top-left of top-left board)
    final firstCell = find.byType(GestureDetector).first;
    await tester.tap(firstCell);
    await tester.pump();

    // After the move, there should be at least one 'X' on the board
    expect(find.text('X'), findsWidgets);
  });
}
