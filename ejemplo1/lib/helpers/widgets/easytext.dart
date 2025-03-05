import 'package:flutter/material.dart';

class Easytext extends StatelessWidget {
  final String text;
  final Color color;
  final double size;
  final bool bold;
  final TextAlign? textAlign;

  const Easytext({
    super.key, 
    required this.text, 
    this.color = Colors.white, 
    this.size = 25, 
    this.bold = false,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: TextStyle(
        fontSize: size,
        color: color,
        fontWeight: bold ? FontWeight.bold : FontWeight.normal,
        decoration: TextDecoration.none,
      ),
    );
  }
}