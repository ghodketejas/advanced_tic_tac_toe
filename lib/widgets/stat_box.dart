import 'package:flutter/material.dart';

/// A widget that displays a single statistic with colored styling
/// 
/// This widget is used to show game statistics (wins, losses, draws)
/// with consistent styling and color coding.
class StatBox extends StatelessWidget {
  /// The label text for the statistic (e.g., "Wins", "Losses")
  final String label;
  
  /// The numeric value to display
  final int value;
  
  /// The color theme for this statistic
  final Color color;

  /// Creates a stat box widget
  const StatBox({
    super.key,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: color, width: 1.2),
      ),
      child: Column(
        children: [
          Text(
            '$value',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: color,
              fontSize: 18,
            ),
          ),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
} 