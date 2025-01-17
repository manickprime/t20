import 'dart:async';
import 'package:flutter/material.dart';
import 'package:t20/bloc_logic.dart';
import 'package:t20/clock/first_screen.dart';
//import 'package:t20/main.dart';
import 'package:t20/timer.dart';

class RestPage extends StatefulWidget {
  @override
  _RestPageState createState() => _RestPageState();
}

class _RestPageState extends State<RestPage> with TickerProviderStateMixin {
  int hour = 0;
  int min = 0;
  int sec = 0;
  bool started = true;
  bool stopped = true;
  int timeForTimer = 0;
  String timeToDisplay = '20:0';
  String buttonText = 'Start';
  bool checkTimer = true;
  int times = 0;
  int passedMin = 0;
  int passedSec = 0;
  DateTime dateTime;

  @override
  void initState() {
    min = 0;
    sec = 20;
    start();
    super.initState();
  }

  void start() {
    setState(() {
      started = false;
      stopped = false;
    });
    timeForTimer = ((hour * 60 * 60) + (min * 60) + sec);
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timeForTimer < 1 || checkTimer == false) {
          t.cancel();
          if (timeForTimer == 0) {
            debugPrint('Stopped by default');
          }
          started = true;
          stopped = true;
          Navigator.pushReplacement(
              context,
              PageRouteBuilder(
                  pageBuilder: (context, __, ___) => TimerPage(),
                  transitionDuration: Duration(seconds: 0)));
//          Navigator.pop(context);
        } else if (timeForTimer < 60) {
          timeToDisplay = timeForTimer.toString();
          passedMin = 0;
          passedSec = timeForTimer;
          timeForTimer -= 1;
        } else if (timeForTimer < 3600) {
          int m = timeForTimer ~/ 60;
          int s = timeForTimer - (60 * m);
          timeToDisplay = m.toString() + ':' + s.toString();
          passedMin = m;
          passedSec = s;
          timeForTimer -= 1;
        } else {
          int h = timeForTimer ~/ 3600;
          int t = timeForTimer - (3600 * h);
          int m = t ~/ 60;
          int s = t - (60 * m);
          timeToDisplay =
              h.toString() + ':' + m.toString() + ':' + s.toString();
          timeForTimer -= 1;
        }
      });
    });
  }

  void stop() {
    setState(() {
      started = true;
      stopped = true;
      checkTimer = false;
    });
  }

  Widget timer() {
    return Container(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Container(
            child: Text(
              timeToDisplay,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
              child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                onPressed: times % 2 == 0
                    ? () {
                        start();
                        times++;
                      }
                    : () {
                        stop();
                        times++;
                      },
                color: Color(0xffff0764),
                padding: EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 10,
                ),
                child: Text(
                  'Look away',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ],
          )),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('t20'),
        centerTitle: true,
        backgroundColor: Color(0xffff0764),
      ),
      body: Column(children: [
        timer(),
        Expanded(
          child: FirstTab(
            minutes: passedMin,
            seconds: passedSec,
          ),
        ),
      ]),
    );
  }
}

final bloc = ThemeBloc();
