import 'package:flutter/material.dart';

class DottedBorderPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;
  final double dashWidth;
  final double dashSpace;
  final double borderRadius;
  final double shadowBlurRadius;
  final Offset shadowOffset;
  final Color shadowColor;

  DottedBorderPainter(
      {this.strokeWidth = 2.0,
      this.dashWidth = 5.0,
      this.dashSpace = 3.0,
      this.borderRadius = 0.0,
      this.shadowBlurRadius = 0.0,
      this.shadowOffset = const Offset(2, 2),
      this.shadowColor = Colors.black54,
      required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke;

    final rect = Rect.fromLTWH(0, 0, size.width, size.height);
    final rRect = RRect.fromRectAndRadius(rect, Radius.circular(borderRadius));

    if (shadowBlurRadius > 0) {
      canvas.drawRRect(
        rRect.shift(shadowOffset),
        paint
          ..color = shadowColor
          ..maskFilter = MaskFilter.blur(BlurStyle.normal, shadowBlurRadius),
      );
    }

    final path = Path()..addRRect(rRect);
    final dashedPath = _createdDashedPath(path);
    canvas.drawPath(dashedPath, paint..color = color);
  }

  Path _createdDashedPath(Path originalPath) {
    final dashPath = Path();
    double distance = 0.0;
    for (final metric in originalPath.computeMetrics()) {
      while (distance < metric.length) {
        final end = distance + dashWidth;
        dashPath.addPath(
          metric.extractPath(distance, end),
          Offset.zero,
        );
        distance = end + dashSpace;
      }

      distance = 0.0;
    }
    return dashPath;
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => true;
}
