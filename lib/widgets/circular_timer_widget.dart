import 'dart:math';
import 'package:flutter/material.dart';

class CircularTimerWidget extends StatelessWidget {
  final double progress;
  final int days;
  final int hours;
  final int minutes;
  final int seconds;
  final bool isRunning;

  const CircularTimerWidget({
    super.key,
    required this.progress,
    required this.days,
    required this.hours,
    required this.minutes,
    required this.seconds,
    required this.isRunning,
  });

  @override
  Widget build(BuildContext context) {
    final hourProgress = (minutes * 60 + seconds) / 3600;
    final minuteProgress = seconds / 60;

    return SizedBox(
      width: 280,
      height: 280,
      child: CustomPaint(
        painter: _CircularProgressPainter(
          dayProgress: progress,
          hourProgress: hourProgress,
          minuteProgress: minuteProgress,
          isRunning: isRunning,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (isRunning) ...[
                Text(
                  '$days',
                  style: const TextStyle(
                    fontSize: 64,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    height: 1.0,
                  ),
                ),
                const Text(
                  'Days',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white70,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '${_pad(hours)}:${_pad(minutes)}:${_pad(seconds)}',
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.white54,
                    fontFamily: 'monospace',
                    letterSpacing: 2,
                  ),
                ),
              ] else ...[
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF7B2FF7), Color(0xFF00E5FF)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ).createShader(bounds),
                  child: const Icon(
                    Icons.bolt_rounded,
                    size: 54,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                ShaderMask(
                  shaderCallback: (bounds) => const LinearGradient(
                    colors: [Color(0xFF7B2FF7), Color(0xFF00E5FF)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ).createShader(bounds),
                  child: const Text(
                    'BEGIN',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: 5,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'your journey',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white38,
                    letterSpacing: 2,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  String _pad(int value) => value.toString().padLeft(2, '0');
}

class _CircularProgressPainter extends CustomPainter {
  final double dayProgress;
  final double hourProgress;
  final double minuteProgress;
  final bool isRunning;

  _CircularProgressPainter({
    required this.dayProgress,
    required this.hourProgress,
    required this.minuteProgress,
    required this.isRunning,
  });

  // Ring layout (outermost → innermost)
  // Outer  : day/24h  cycle — cyan   → purple
  // Middle : hour/60m cycle — purple → pink
  // Inner  : min/60s  cycle — green  → cyan
  static const double _strokeOuter = 10.0;
  static const double _strokeMiddle = 8.0;
  static const double _strokeInner = 7.0;
  static const double _gap = 7.0;

  void _drawRing({
    required Canvas canvas,
    required Offset center,
    required double radius,
    required double strokeWidth,
    required double progress,
    required Color glowColor,
    required List<Color> gradientColors,
    required double dotRadius,
  }) {
    final rect = Rect.fromCircle(center: center, radius: radius);

    // Background track
    canvas.drawCircle(
      center,
      radius,
      Paint()
        ..color = Colors.white.withOpacity(0.08)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );

    if (!isRunning || progress <= 0) return;

    final sweepAngle = 2 * pi * progress;

    // Glow
    canvas.drawArc(
      rect,
      -pi / 2,
      sweepAngle,
      false,
      Paint()
        ..color = glowColor.withOpacity(0.28)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth + 6
        ..strokeCap = StrokeCap.round
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 7),
    );

    // Gradient arc
    canvas.drawArc(
      rect,
      -pi / 2,
      sweepAngle,
      false,
      Paint()
        ..shader = LinearGradient(
          colors: gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ).createShader(rect)
        ..style = PaintingStyle.stroke
        ..strokeWidth = strokeWidth
        ..strokeCap = StrokeCap.round,
    );

    // Dot at arc tip
    if (progress > 0.01) {
      final angle = -pi / 2 + sweepAngle;
      canvas.drawCircle(
        Offset(
          center.dx + radius * cos(angle),
          center.dy + radius * sin(angle),
        ),
        dotRadius,
        Paint()
          ..color = gradientColors.last
          ..style = PaintingStyle.fill,
      );
    }
  }

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final outerRadius = size.width / 2 - 12;
    final middleRadius = outerRadius - _strokeOuter - _gap;
    final innerRadius = middleRadius - _strokeMiddle - _gap;

    // Outer — day cycle (cyan → purple)
    _drawRing(
      canvas: canvas,
      center: center,
      radius: outerRadius,
      strokeWidth: _strokeOuter,
      progress: dayProgress,
      glowColor: const Color(0xFF00E5FF),
      gradientColors: const [Color(0xFF00E5FF), Color(0xFF7B2FF7)],
      dotRadius: 6,
    );

    // Middle — hour cycle (purple → pink)
    _drawRing(
      canvas: canvas,
      center: center,
      radius: middleRadius,
      strokeWidth: _strokeMiddle,
      progress: hourProgress,
      glowColor: const Color(0xFFFF4081),
      gradientColors: const [Color(0xFF7B2FF7), Color(0xFFFF4081)],
      dotRadius: 5,
    );

    // Inner — minute cycle (green → cyan)
    _drawRing(
      canvas: canvas,
      center: center,
      radius: innerRadius,
      strokeWidth: _strokeInner,
      progress: minuteProgress,
      glowColor: const Color(0xFF00E676),
      gradientColors: const [Color(0xFF00E676), Color(0xFF00E5FF)],
      dotRadius: 4,
    );
  }

  @override
  bool shouldRepaint(_CircularProgressPainter old) =>
      old.dayProgress != dayProgress ||
      old.hourProgress != hourProgress ||
      old.minuteProgress != minuteProgress ||
      old.isRunning != isRunning;
}
