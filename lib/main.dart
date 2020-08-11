import 'package:flutter/material.dart';
import 'package:t20/clock/first_screen.dart';
import 'package:t20/timer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
//      home: Scaffold(body: FirstTab()),
      home: TimerPage(),
    );
  }
}
