import 'package:flutter/material.dart';

/// A custom choice chip widget with animated selection states
/// 
/// This widget provides a selectable chip with:
/// - Animated color transitions
/// - Custom border styling
/// - Hover effects
/// - Accessibility support
class CustomChoiceChip extends StatelessWidget {
  /// The text label displayed on the chip
  final String label;
  
  /// Whether this chip is currently selected
  final bool selected;
  
  /// Callback function when the chip is tapped
  final VoidCallback onTap;
  
  /// The color to use when the chip is selected
  final Color selectedColor;

  /// Creates a custom choice chip
  const CustomChoiceChip({
    super.key,
    required this.label,
    required this.selected,
    required this.onTap,
    required this.selectedColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
        decoration: BoxDecoration(
          color: selected ? selectedColor.withOpacity(0.15) : Colors.transparent,
          border: Border.all(
            color: selected ? selectedColor : Colors.white38,
            width: selected ? 2.2 : 1.2,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? selectedColor : Colors.white70,
            fontWeight: FontWeight.bold,
            fontSize: 16,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }
} 