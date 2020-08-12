import 'package:flutter/material.dart';
import 'package:t20/clock/hand_hour.dart';
import 'package:t20/clock/hand_minute.dart';
import 'package:t20/clock/hand_second.dart';

class ClockHands extends StatelessWidget {
//  final DateTime dateTime;
  final bool showHourHandleHeartShape;

  final int min;
  final int sec;

//  ClockHands({this.dateTime, this.showHourHandleHeartShape = false});
  ClockHands({this.showHourHandleHeartShape = false, this.min, this.sec});
  @override
  Widget build(BuildContext context) {
    print(min);
    print(sec);
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
//            CustomPaint(
//              painter: MinuteHandPainter(
//                  minutes: dateTime.minute, seconds: dateTime.second),
//            ),
            CustomPaint(
              painter: MinuteHandPainter(minutes: min, seconds: sec),
            ),
//            CustomPaint(
//              painter: SecondHandPainter(seconds: dateTime.second),
//            )
            CustomPaint(
              painter: SecondHandPainter(seconds: sec),
            )
          ],
        ),
      ),
    );
  }
}
