import 'package:flutter/material.dart';
import 'dart:ui';
import 'dart:math';

/// An animated background widget that displays floating grid patterns
///
/// This widget creates a dynamic background with multiple animated grids
/// that float around the screen to create a cyberpunk aesthetic.
class FloatingGridsBackground extends StatelessWidget {
  /// Controller for the main background animation
  final AnimationController backgroundController;

  /// Controller for the first grid animation
  final AnimationController gridController1;

  /// Controller for the second grid animation
  final AnimationController gridController2;

  /// Controller for the third grid animation
  final AnimationController gridController3;

  /// The size of the screen
  final Size screenSize;

  /// Creates a floating grids background
  const FloatingGridsBackground({
    super.key,
    required this.backgroundController,
    required this.gridController1,
    required this.gridController2,
    required this.gridController3,
    required this.screenSize,
  });

  @override
  Widget build(BuildContext context) {
    final w = screenSize.width;
    final h = screenSize.height;

    return SizedBox.expand(
      child: Stack(
        children: [
          // Background gradient
          Container(
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color(0xFF181A20),
                  Color(0xFF1A1C22),
                  Color(0xFF181A20),
                ],
              ),
            ),
          ),

          // Very large blue grid, floats around top left quadrant
          AnimatedBuilder(
            animation: gridController1,
            builder: (context, child) {
              final double t = gridController1.value;
              return Transform.translate(
                offset: Offset(
                  lerpDouble(-120, 80, t)! + w * 0.25,
                  lerpDouble(-180, 120, t)! + h * 0.22,
                ),
                child: Transform.rotate(
                  angle: t * 2 * 3.14159,
                  child: const Opacity(
                    opacity: 0.22,
                    child: FloatingGrid(
                      size: 320,
                      color: Color(0xFF00FFF7),
                      showSymbols: true,
                    ),
                  ),
                ),
              );
            },
          ),

          // Very large orange grid, floats around bottom right quadrant
          AnimatedBuilder(
            animation: gridController2,
            builder: (context, child) {
              final double t = gridController2.value;
              return Transform.translate(
                offset: Offset(
                  lerpDouble(100, -160, t)! + w * 0.75,
                  lerpDouble(140, -120, t)! + h * 0.78,
                ),
                child: Transform.rotate(
                  angle: -t * 2 * 3.14159,
                  child: const Opacity(
                    opacity: 0.18,
                    child: FloatingGrid(
                      size: 260,
                      color: Color(0xFFFF9900),
                      showSymbols: true,
                    ),
                  ),
                ),
              );
            },
          ),

          // Medium blue grid, floats around left center
          AnimatedBuilder(
            animation: gridController3,
            builder: (context, child) {
              final double t = gridController3.value;
              return Transform.translate(
                offset: Offset(
                  lerpDouble(-100, 120, t)! + w * 0.18,
                  lerpDouble(80, -80, t)! + h * 0.5,
                ),
                child: Transform.rotate(
                  angle: t * 1.5 * 3.14159,
                  child: const Opacity(
                    opacity: 0.20,
                    child: FloatingGrid(
                      size: 140,
                      color: Color(0xFF00FFF7),
                    ),
                  ),
                ),
              );
            },
          ),

          // Small white grid, floats around top right
          AnimatedBuilder(
            animation: backgroundController,
            builder: (context, child) {
              final double t = backgroundController.value;
              return Transform.translate(
                offset: Offset(
                  lerpDouble(60, 180, t)! + w * 0.8,
                  lerpDouble(-60, 100, t)! + h * 0.18,
                ),
                child: Transform.rotate(
                  angle: t * 3.14159,
                  child: Opacity(
                    opacity: 0.13,
                    child: FloatingGrid(
                      size: 90,
                      color: Colors.white.withOpacity(0.7),
                    ),
                  ),
                ),
              );
            },
          ),

          // Medium orange grid, floats around bottom left
          AnimatedBuilder(
            animation: backgroundController,
            builder: (context, child) {
              final double t = backgroundController.value;
              return Transform.translate(
                offset: Offset(
                  lerpDouble(-120, 40, t)! + w * 0.15,
                  lerpDouble(120, 200, t)! + h * 0.82,
                ),
                child: Transform.rotate(
                  angle: -t * 2 * 3.14159,
                  child: const Opacity(
                    opacity: 0.16,
                    child: FloatingGrid(
                      size: 120,
                      color: Color(0xFFFF9900),
                    ),
                  ),
                ),
              );
            },
          ),

          // Extra small blue grid, floats diagonally across center
          AnimatedBuilder(
            animation: backgroundController,
            builder: (context, child) {
              final double t = backgroundController.value;
              return Transform.translate(
                offset: Offset(
                  lerpDouble(0, w * 0.9, t)!,
                  lerpDouble(h * 0.1, h * 0.9, t)!,
                ),
                child: Transform.rotate(
                  angle: t * 2.5 * 3.14159,
                  child: const Opacity(
                    opacity: 0.12,
                    child: FloatingGrid(
                      size: 70,
                      color: Color(0xFF00FFF7),
                      showSymbols: true,
                    ),
                  ),
                ),
              );
            },
          ),

          // Extra small orange grid, floats diagonally across the other way
          AnimatedBuilder(
            animation: backgroundController,
            builder: (context, child) {
              final double t = backgroundController.value;
              return Transform.translate(
                offset: Offset(
                  lerpDouble(w * 0.9, 0, t)!,
                  lerpDouble(h * 0.9, h * 0.1, t)!,
                ),
                child: Transform.rotate(
                  angle: -t * 2.8 * 3.14159,
                  child: const Opacity(
                    opacity: 0.11,
                    child: FloatingGrid(
                      size: 60,
                      color: Color(0xFFFF9900),
                      showSymbols: true,
                    ),
                  ),
                ),
              );
            },
          ),

          // Tiny blue grid around center-top
          AnimatedBuilder(
            animation: backgroundController,
            builder: (context, child) {
              final double t = (backgroundController.value + 0.3) % 1.0;
              return Transform.translate(
                offset: Offset(
                  lerpDouble(w * 0.1, w * 0.5, t)!,
                  lerpDouble(h * 0.0, h * 0.4, t)!,
                ),
                child: Transform.rotate(
                  angle: t * 4 * 3.14159,
                  child: const Opacity(
                    opacity: 0.14,
                    child: FloatingGrid(
                      size: 50,
                      color: Color(0xFF00FFF7),
                      showSymbols: true,
                    ),
                  ),
                ),
              );
            },
          ),

          // Tiny orange grid around center-bottom
          AnimatedBuilder(
            animation: backgroundController,
            builder: (context, child) {
              final double t = (backgroundController.value + 0.6) % 1.0;
              return Transform.translate(
                offset: Offset(
                  lerpDouble(w * 0.9, w * 0.4, t)!,
                  lerpDouble(h * 0.7, h * 0.3, t)!,
                ),
                child: Transform.rotate(
                  angle: -t * 4 * 3.14159,
                  child: const Opacity(
                    opacity: 0.14,
                    child: FloatingGrid(
                      size: 55,
                      color: Color(0xFFFF9900),
                      showSymbols: true,
                    ),
                  ),
                ),
              );
            },
          ),

          // Blur overlay
          Container(
            decoration: BoxDecoration(
              gradient: RadialGradient(
                center: Alignment.center,
                radius: 1.5,
                colors: [
                  Colors.transparent,
                  const Color(0xFF181A20).withOpacity(0.3),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Individual floating grid widget that draws a 3x3 grid pattern
class FloatingGrid extends StatelessWidget {
  /// The size of the grid
  final double size;

  /// The color of the grid lines
  final Color color;

  /// Whether to draw random X / O symbols inside the cells.
  final bool showSymbols;

  /// Creates a floating grid
  const FloatingGrid({
    super.key,
    required this.size,
    required this.color,
    this.showSymbols = false,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: CustomPaint(
        painter: GridPainter(color: color, addSymbols: showSymbols),
      ),
    );
  }
}

/// Custom painter for drawing grid lines
class GridPainter extends CustomPainter {
  /// The color of the grid lines
  final Color color;

  /// Whether to draw random X / O symbols.
  final bool addSymbols;

  /// Creates a grid painter
  GridPainter({required this.color, this.addSymbols = false});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final double cellSize = size.width / 3;

    // Draw vertical lines
    for (int i = 1; i < 3; i++) {
      canvas.drawLine(
        Offset(i * cellSize, 0),
        Offset(i * cellSize, size.height),
        paint,
      );
    }

    // Draw horizontal lines
    for (int i = 1; i < 3; i++) {
      canvas.drawLine(
        Offset(0, i * cellSize),
        Offset(size.width, i * cellSize),
        paint,
      );
    }

    // Optionally draw symbols.
    if (addSymbols) {
      final symbolPaint = Paint()
        ..color = color.withOpacity(0.65)
        ..strokeWidth = 2.0
        ..style = PaintingStyle.stroke;

      final rand = Random();

      for (int row = 0; row < 3; row++) {
        for (int col = 0; col < 3; col++) {
          final r = rand.nextDouble();
          if (r < 0.25) {
            // Draw X
            final double padding = cellSize * 0.25;
            final Offset tl =
                Offset(col * cellSize + padding, row * cellSize + padding);
            final Offset br = Offset(
                (col + 1) * cellSize - padding, (row + 1) * cellSize - padding);
            canvas.drawLine(tl, br, symbolPaint);

            final Offset tr = Offset(
                (col + 1) * cellSize - padding, row * cellSize + padding);
            final Offset bl = Offset(
                col * cellSize + padding, (row + 1) * cellSize - padding);
            canvas.drawLine(tr, bl, symbolPaint);
          } else if (r < 0.5) {
            // Draw O
            final double padding = cellSize * 0.28;
            final Offset center = Offset(col * cellSize + cellSize / 2,
                row * cellSize + cellSize / 2);
            canvas.drawCircle(center, cellSize / 2 - padding, symbolPaint);
          }
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant GridPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.addSymbols != addSymbols;
  }
}
