import 'dart:math';

import 'package:flutter/material.dart';

class MinuteHandPainter extends CustomPainter {
  final Paint minuteHandPaint;
  int minutes;
  int seconds;

  MinuteHandPainter({this.minutes, this.seconds}) : minuteHandPaint = Paint() {
    // minuteHandPaint.color = Color(0xffc5cbdd);
    minuteHandPaint.color = Color(0xfff4f9fd);

    minuteHandPaint.style = PaintingStyle.stroke;
    minuteHandPaint.strokeCap = StrokeCap.round;
    minuteHandPaint.strokeWidth = 5;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final radius = size.width / 2;
    canvas.save();

    canvas.translate(radius, radius);

//    canvas.rotate(2 * pi * ((this.minutes + (this.seconds / 60)) / 60));
    canvas.rotate(-(2 * pi * ((this.minutes / 20))));

    Path path = Path();
    path.moveTo(0, -radius * 0.6);
    path.lineTo(0, radius * 0.1);

    path.close();

    canvas.drawPath(path, minuteHandPaint);
    canvas.drawShadow(path, Colors.black, 4, false);
    canvas.restore();
  }

  @override
  bool shouldRepaint(MinuteHandPainter oldDelegate) {
    return true;
  }
}
