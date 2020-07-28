import 'dart:async';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';

class TimerPage extends StatefulWidget {
  @override
  _TimerPageState createState() => _TimerPageState();
}

class _TimerPageState extends State<TimerPage> with TickerProviderStateMixin {
  TabController tb;
  int hour = 0;
  int min = 0;
  int sec = 0;
  bool started = true;
  bool stopped = true;
  int timeForTimer = 0;
  String timeToDisplay = '00:00:00';
  bool checkTimer = true;

  @override
  void initState() {
    tb = TabController(
      length: 2,
      vsync: this,
    );
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
              MaterialPageRoute(
                builder: (context) => TimerPage(),
              ));
        } else if (timeForTimer < 60) {
          timeToDisplay = timeForTimer.toString();
          timeForTimer -= 1;
        } else if (timeForTimer < 3600) {
          int m = timeForTimer ~/ 60;
          int s = timeForTimer - (60 * m);
          timeToDisplay = m.toString() + ':' + s.toString();
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
          Expanded(
            flex: 6,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Text('HH'),
                    ),
                    NumberPicker.integer(
                        initialValue: hour,
                        minValue: 0,
                        maxValue: 23,
                        listViewWidth: 60,
                        onChanged: (val) {
                          setState(() {
                            hour = val;
                          });
                        }),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Text('MM'),
                    ),
                    NumberPicker.integer(
                        initialValue: min,
                        minValue: 0,
                        maxValue: 23,
                        listViewWidth: 60,
                        onChanged: (val) {
                          setState(() {
                            min = val;
                          });
                        }),
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Text('SS'),
                    ),
                    NumberPicker.integer(
                        initialValue: sec,
                        minValue: 0,
                        maxValue: 23,
                        listViewWidth: 60,
                        onChanged: (val) {
                          setState(() {
                            sec = val;
                          });
                        }),
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            flex: 1,
            child: Text(
              timeToDisplay,
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
              flex: 3,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: started ? start : null,
                    color: Colors.green,
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10,
                    ),
                    child: Text(
                      'Start',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  RaisedButton(
                    onPressed: stopped ? null : stop,
                    color: Colors.red,
                    padding: EdgeInsets.symmetric(
                      horizontal: 40,
                      vertical: 10,
                    ),
                    child: Text(
                      'Stop',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
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
      appBar: AppBar(title: Text('t20'), centerTitle: true),
      body: timer(),
    );
  }
}
