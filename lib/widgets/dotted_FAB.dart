import 'package:flutter/material.dart';
import 'package:workshops_hackerrank/animation/dotted_border.dart';

class DottedFAB extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget icon;
  final String text;
  final Color color;
  final double size;

  const DottedFAB({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
    this.color = Colors.black,
    this.size = 56.0,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size + 16,
      height: size,
      child: CustomPaint(
        painter: DottedBorderPainter(
          color: color,
          strokeWidth: 2.0,
          dashWidth: 5.0,
          dashSpace: 3.0,
          borderRadius: 15,
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onPressed,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                const SizedBox(width: 2.5),
                Text(
                  text,
                  style: const TextStyle(fontSize: 16, color: Colors.black, fontWeight: FontWeight.bold),
                ),
                const SizedBox(width: 2.5,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
