import 'dart:math';

import 'package:flutter/material.dart';
import 'package:t20/clock/clock_text.dart';

class ClockDialPainter extends CustomPainter {
  final clockText;

  final hourTickMarkLength = 10;
  final minuteTickMarkLength = 5;

  final hourTickMarkWidth = 3;
  final minuteTickMarkWidth = 1.5;

  final Paint tickPaint;
  final TextPainter textPainter;
  final TextStyle textStyle;

  final double tickLength = 8;
  final double tickWidth = 3;

  final romanNumeralList = [
    'XII',
    'I',
    'II',
    'III',
    'IV',
    'V',
    'VI',
    'VII',
    'VIII',
    'IX',
    'X',
    'XI'
  ];

  ClockDialPainter({this.clockText = ClockText.roman})
      : tickPaint = Paint(),
        textPainter = TextPainter(
          textAlign: TextAlign.center,
          textDirection: TextDirection.rtl,
        ),
        textStyle = TextStyle(
          color: Colors.black,
          fontFamily: 'Times New Roman',
          fontSize: 15,
        ) {
    tickPaint.color = Colors.white;
  }

  @override
  void paint(Canvas canvas, Size size) {
    var tickMarkLength;
    final angle = 2 * pi / 60;
    final radius = size.width / 2;
    canvas.save();

    //drawing
    canvas.translate(radius, radius);
    for (var i = 0; i < 60; i++) {
      tickMarkLength = tickLength;
      tickPaint.strokeWidth = tickWidth;
      canvas.drawLine(
          Offset(0, -radius), Offset(0, -radius + tickMarkLength), tickPaint);
      canvas.rotate(angle);
    }
    canvas.restore();
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    // TODO: implement shouldRepaint
    return false;
  }
}
