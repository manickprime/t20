import 'dart:async';
import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:t20/bloc_logic.dart';
import 'package:t20/clock/first_screen.dart';
import 'package:t20/info.dart';
import 'package:t20/notification.dart';
import 'package:t20/resting_screen.dart';

class TimerPage extends StatefulWidget {
  final bool isDarkThemeEnabled;
  final ThemeBloc bloc;

  @override
  _TimerPageState createState() => _TimerPageState();

  TimerPage({this.isDarkThemeEnabled, this.bloc});
}

class _TimerPageState extends State<TimerPage> with TickerProviderStateMixin {
  int hour = 0;
  int min = 0;
  int sec = 0;
  bool started = true;
  bool stopped = true;
  int timeForTimer = 0;
  static int initialValue = 20;
  String timeToDisplay = '$initialValue:00';
  String buttonText = 'Start';
  bool checkTimer = true;
  int times = 0;
  int passedMin = 0;
  int passedSec = 0;
  DateTime dateTime;
  bool isSwitched = true;

  @override
  void initState() {
    min = 19;
    sec = 59;
    started = true;
    stopped = true;
    timeForTimer = 0;
    buttonText = 'Start';
    checkTimer = true;
    passedMin = 0;
    passedSec = 0;
    super.initState();
  }

  void start() {
    // debugPrint('im starting');
    setState(() {
      started = false;
      stopped = false;
    });
    timeForTimer = ((hour * 60 * 60) + (min * 60) + sec);
    // timeForTimer = 1199;
    Timer.periodic(Duration(seconds: 1), (Timer t) {
      setState(() {
        if (timeForTimer < 1 || checkTimer == false) {
          t.cancel();
          timeToDisplay = '$initialValue:00';
          min = 20;
          sec = 0;

          if (timeForTimer == 0) {
            debugPrint('Stopped by default');
            started = true;
            stopped = true;
            t.cancel();
            MyHomePage myHomePage = MyHomePage(context: context);
            myHomePage.init();
            myHomePage.showNotificationsWithDefaultSound(
                bigHeading: 'Time\'s Up',
                smallDesc: 'Look away to relax your eyes');
            Navigator.pushReplacement(
                context,
                PageRouteBuilder(
                    pageBuilder: (context, __, ___) => RestPage(),
                    transitionDuration: Duration(seconds: 0)));
          } else {
            t.cancel();
            started = true;
            stopped = true;

//            print('hey');
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
      color: Theme.of(context).accentColor,
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
                        // debugPrint('im calling');
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
                  timeToDisplay == '$initialValue:00' ? 'Start' : 'Restart',
                  style: TextStyle(
                    fontSize: 18,
//                      color: Colors.white
                  ),
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
//              print('im pressed');
              Navigator.of(context).push(PageRouteBuilder(
                opaque: false,
                pageBuilder: (context, _, __) => InfoScreen(),
//                pageBuilder: (context, _, __) => Container(
////                  child: InfoScreen(),
//                  child: SafeArea(
//                    child: Stack(
//                      children: [
//                        Opacity(
//                          opacity: 0.5,
//                        ),
//                        Column(
//                          children: [
//                            Text(
//                              't20 app',
//                              style: TextStyle(
//                                fontSize: 20,
//                                fontFamily: 'Roboto',
//                              ),
//                            ),
//                            Text('will help you reduce eye strain'),
//                          ],
//                        ),
//                      ],
//                    ),
//                  ),
//                  color: Color(0xffffff).withOpacity(0.5),
//                ),
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
        // Text('Scroll to change time'),
        Text('Swipe to change time'),
        NumberPicker.horizontal(

//            listViewWidth: 60,
            initialValue: initialValue,
            // infiniteLoop: true,
//             scrollDirection: Axis.horizontal,
            highlightSelectedValue: true,
            minValue: 18,
            maxValue: 60,
            onChanged: (val) {
              setState(() {
                min = val - 1;
                initialValue = val;
                timeToDisplay = '$initialValue:00';
              });
            })
//        Switch(
//          value: widget.isDarkThemeEnabled,
////          onChanged: (value) {
////            setState(() {
////              isSwitched = value;
////            });
//
////          },
//          onChanged: widget.bloc.changeTheTheme,
////          activeTrackColor: Color(0xffff0764),
//          activeColor: Color(0xffff0764),
//        ),
      ]),
    );
  }
}

final bloc = ThemeBloc();
