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
  testWidgets('Advanced Tic Tac Toe UI renders and allows a player move', (WidgetTester tester) async {
    // Build the app
    await tester.pumpWidget(const AdvancedTicTacToeRoot());

    // Check for the main title
    expect(find.text('Advanced Tic Tac Toe'), findsOneWidget);

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
