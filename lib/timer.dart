import 'dart:async';
import 'package:flutter/material.dart';
import 'package:t20/clock/first_screen.dart';
import 'package:t20/info.dart';
import 'package:t20/resting_screen.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with TickerProviderStateMixin {
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
  bool isSwitched = true;

  @override
  void initState() {
    min = 0;
    sec = 8;
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
            started = true;
            stopped = true;
            t.cancel();
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, __, ___) => RestPage(),
                    transitionDuration: Duration(seconds: 0)));
          } else {
            t.cancel();
            started = true;
            stopped = true;
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                  pageBuilder: (context, _, __) => TimerPage(),
                  transitionDuration: Duration(seconds: 0),
                ));
          }
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
                  timeToDisplay == '20:0' ? 'Start' : 'Restart',
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
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('t20'),
        centerTitle: true,
        backgroundColor: Color(0xffff0764),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline),
            onPressed: () {
              print('im pressed');
              Navigator.of(context).push(PageRouteBuilder(
                opaque: false,
                pageBuilder: (context, _, __) => InfoScreen(),
              ));
            },
          ),
        ],
      ),
      body: Column(children: [
        timer(),
        Expanded(
          child: Scaffold(
            body: FirstTab(
              minutes: passedMin,
              seconds: passedSec,
            ),
          ),
        ),
        Switch(
          value: isSwitched,
          onChanged: (value) {
            setState(() {
              isSwitched = value;
            });
          },
//          activeTrackColor: Color(0xffff0764),
          activeColor: Color(0xffff0764),
        ),
      ]),
    );
  }
}
