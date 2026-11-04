import 'dart:math';

import 'package:flutter/material.dart';

class QrCodeView extends StatelessWidget {
  const QrCodeView({super.key, this.size = 190});

  final double size;

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size.square(size),
      painter: const _QrPainter(),
    );
  }
}

class _QrPainter extends CustomPainter {
  const _QrPainter();

  static const int _modules = 25;

  bool _isFinder(int x, int y, int originX, int originY) {
    final dx = x - originX;
    final dy = y - originY;
    if (dx < 0 || dy < 0 || dx > 6 || dy > 6) return false;
    final outer = dx == 0 || dy == 0 || dx == 6 || dy == 6;
    final inner = dx >= 2 && dx <= 4 && dy >= 2 && dy <= 4;
    return outer || inner;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.black;
    final module = size.width / _modules;
    final random = Random(1337);

    bool inFinderZone(int x, int y) {
      return _isFinder(x, y, 0, 0) ||
          _isFinder(x, y, _modules - 7, 0) ||
          _isFinder(x, y, 0, _modules - 7) ||
          (x <= 7 && y <= 7) ||
          (x >= _modules - 8 && y <= 7) ||
          (x <= 7 && y >= _modules - 8);
    }

    for (var y = 0; y < _modules; y++) {
      for (var x = 0; x < _modules; x++) {
        if (inFinderZone(x, y)) continue;
        if (random.nextBool()) {
          canvas.drawRect(
            Rect.fromLTWH(x * module, y * module, module, module),
            paint,
          );
        }
      }
    }

    for (final origin in [
      const Offset(0, 0),
      Offset(_modules - 7, 0),
      Offset(0, _modules - 7),
    ]) {
      final ox = origin.dx.toInt();
      final oy = origin.dy.toInt();
      canvas.drawRect(
        Rect.fromLTWH(
          ox * module,
          oy * module,
          module * 7,
          module * 7,
        ),
        Paint()
          ..color = Colors.black
          ..style = PaintingStyle.stroke
          ..strokeWidth = module,
      );
      canvas.drawRect(
        Rect.fromLTWH(
          (ox + 2) * module,
          (oy + 2) * module,
          module * 3,
          module * 3,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(_QrPainter oldDelegate) => false;
}
