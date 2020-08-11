import 'package:flutter/material.dart';
import 'package:t20/clock/hand_hour.dart';
import 'package:t20/clock/hand_minute.dart';
import 'package:t20/clock/hand_second.dart';

class ClockHands extends StatelessWidget {
  final DateTime dateTime;
  final bool showHourHandleHeartShape;

  ClockHands({this.dateTime, this.showHourHandleHeartShape = false});

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(20),
        child: Stack(
          fit: StackFit.expand,
          children: [
//            CustomPaint(
//              painter: HourHandPainter(
//                  hours: dateTime.hour, minutes: dateTime.minute),
//            ),
            CustomPaint(
              painter: MinuteHandPainter(
                  minutes: dateTime.minute, seconds: dateTime.second),
            ),
            CustomPaint(
              painter: SecondHandPainter(seconds: dateTime.second),
            )
          ],
        ),
      ),
    );
  }
}
