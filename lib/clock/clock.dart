import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:t20/clock/clock_dial_painter.dart';
import 'package:t20/clock/clock_face.dart';
import 'package:t20/clock/clock_hands.dart';
import 'package:t20/clock/clock_text.dart';

typedef TimeProducer = DateTime Function();

class Clock extends StatefulWidget {
  final Color circleColor;
  final Color shadowColor;

  final ClockText clockText;

//  final TimeProducer getCurrentTime;
//  final Duration updateDuration;

//  final DateTime dateTime;
  final int min;
  final int sec;

  Clock(
      {this.circleColor = const Color(0xfffe1ecf7),
      this.shadowColor = const Color(0xffd9e2ed),
      this.clockText = ClockText.arabic,
//      this.getCurrentTime = getSystemTime,
//      this.updateDuration = const Duration(seconds: 1),
//      this.dateTime
      this.min,
      this.sec});

//  static DateTime getSystemTime() {
//    return new DateTime.now();
//  }

  @override
  _ClockState createState() => _ClockState();
}

class _ClockState extends State<Clock> {
  Timer _timer;

  @override
  void initState() {
    super.initState();
//    dateTime = DateTime.now();
//    this._timer = Timer.periodic(widget.updateDuration, setTime);
  }

//  void setTime(Timer timer) {
//    setState(() {
////      dateTime = DateTime.now();
//    });
//  }

  @override
  void dispose() {
//    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.0,
      child: buildClockCircle(context),
    );
  }

  Container buildClockCircle(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.transparent,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 5),
            blurRadius: 0,
            color: widget.shadowColor,
          ),
          BoxShadow(
              offset: Offset(0, 5),
              color: widget.circleColor,
              blurRadius: 10,
              spreadRadius: -8)
        ],
      ),
      child: Stack(
        children: [
          ClockFace(
            clockText: widget.clockText,
//            dateTime: dateTime,
            min: widget.min,
            sec: widget.sec,
          ),
          Container(
            padding: EdgeInsets.all(25),
            width: double.infinity,
            child: CustomPaint(
              painter: ClockDialPainter(clockText: widget.clockText),
            ),
          ),
          ClockHands(
            min: widget.min,
            sec: widget.sec,
          ),
        ],
      ),
    );
  }
}
