import 'dart:math';

import 'package:Ecommerce/constatns.dart';
import 'package:flutter/material.dart';

class DrawCircle extends CustomPainter {
  double currentProgress;

  DrawCircle(this.currentProgress);

  @override
  void paint(Canvas canvas, Size size) {
    //this is base circle
    Paint outerCircle = Paint()
      ..strokeWidth = 2
      ..color = Colors.grey[300]
      ..style = PaintingStyle.stroke;

    Paint completeArc = Paint()
      ..strokeWidth = 2
      ..color = darkColor
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    Offset center = Offset(size.width / 2, size.height / 2);
    double radius = 50;

    canvas.drawCircle(
        center, radius, outerCircle); // this draws main outer circle

    double angle = 2 * pi * (currentProgress / 100);

    canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2,
        angle, false, completeArc);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
