import 'package:flutter/material.dart';
import 'package:t20/bloc_logic.dart';
import 'package:t20/notification.dart';
//import 'package:t20/info.dart';
import 'package:t20/timer.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
//  final ThemeBloc bloc;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: bloc.darkThemeIsEnabled,
        initialData: false,
        builder: (context, snapshot) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Flutter Demo',
//          theme: ThemeData(
//            primarySwatch: Colors.blue,
//            visualDensity: VisualDensity.adaptivePlatformDensity,
//          ),
//          darkTheme: ThemeData(
//            brightness: Brightness.dark,
//          ),
            theme: snapshot.data
                ? ThemeData(
                    brightness: Brightness.dark,
                    accentColor: Colors.black,
                  )
                : ThemeData(
                    primarySwatch: Colors.blue,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    accentColor: Colors.white),
//            home: MyHomePage(),
            home: TimerPage(
              isDarkThemeEnabled: snapshot.data,
              bloc: bloc,
            ),
//      home: MyHomePage(),
          );
        });
  }
}

final bloc = ThemeBloc();
