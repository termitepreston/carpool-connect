import 'package:flutter/material.dart';

class BrandText extends StatelessWidget {
  final double fontSize;
  final Color? color;

  const BrandText({
    super.key,
    this.fontSize = 24,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'CarpoolConnect',
      style: TextStyle(
        fontSize: fontSize,
        fontWeight: FontWeight.bold,
        letterSpacing: -0.03 * fontSize, // 0.03em tracking
        color: color ?? Theme.of(context).primaryColor,
      ),
    );
  }
}
