import 'package:flutter/material.dart';
import 'package:t20/clock/clock.dart';

class FirstTab extends StatelessWidget {
  final int minutes;
  final int seconds;

  FirstTab({this.minutes, this.seconds});

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        SizedBox(
          height: 85,
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 40),
          child: Clock(
//            dateTime: dateTime,
            min: minutes,
            sec: seconds,
          ),
        ),
      ],
    );
//    return Clock();
  }
}
