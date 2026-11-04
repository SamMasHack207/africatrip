import 'package:flutter/material.dart';

import '../theme/app_theme.dart';

class FlightRouteRow extends StatelessWidget {
  const FlightRouteRow({
    super.key,
    required this.originCode,
    required this.originCity,
    required this.destinationCode,
    required     this.destinationCity,
    this.dashColor = AppColors.dotted,
    this.codeColor = AppColors.textPrimary,
    this.cityColor = AppColors.textSecondary,
    this.planeBackground = AppColors.green,
    this.compact = false,
  });

  final String originCode;
  final String originCity;
  final String destinationCode;
  final String destinationCity;
  final Color dashColor;
  final Color codeColor;
  final Color cityColor;
  final Color planeBackground;
  final bool compact;

  @override
  Widget build(BuildContext context) {
    final codeStyle = TextStyle(
      fontSize: compact ? 18 : 22,
      fontWeight: FontWeight.w800,
      color: codeColor,
      letterSpacing: 0.2,
    );
    final cityStyle = TextStyle(
      fontSize: compact ? 10 : 11,
      fontWeight: FontWeight.w500,
      color: cityColor,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(originCode, style: codeStyle),
              const SizedBox(height: 2),
              Text(originCity, style: cityStyle),
            ],
          ),
        ),
        SizedBox(
          width: compact ? 78 : 96,
          child: Row(
            children: [
              Expanded(child: _DashedLine(color: dashColor)),
              Container(
                width: compact ? 28 : 34,
                height: compact ? 28 : 34,
                decoration: BoxDecoration(
                  color: planeBackground,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.flight_rounded,
                  size: compact ? 15 : 18,
                  color: Colors.white,
                ),
              ),
              Expanded(child: _DashedLine(color: dashColor)),
            ],
          ),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(destinationCode, style: codeStyle),
              const SizedBox(height: 2),
              Text(destinationCity, style: cityStyle),
            ],
          ),
        ),
      ],
    );
  }
}

class _DashedLine extends StatelessWidget {
  const _DashedLine({required this.color});

  final Color color;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: _DashedLinePainter(color),
      child: const SizedBox(height: 1),
    );
  }
}

class _DashedLinePainter extends CustomPainter {
  const _DashedLinePainter(this.color);

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1.4
      ..strokeCap = StrokeCap.round;

    const dash = 4.0;
    const gap = 4.0;
    var x = 0.0;
    while (x < size.width) {
      canvas.drawLine(
        Offset(x, size.height / 2),
        Offset((x + dash).clamp(0, size.width), size.height / 2),
        paint,
      );
      x += dash + gap;
    }
  }

  @override
  bool shouldRepaint(_DashedLinePainter oldDelegate) =>
      oldDelegate.color != color;
}
