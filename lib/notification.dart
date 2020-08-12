import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

  @override
  void initState() {
    super.initState();

    var initializationSettingsAndroid =
        AndroidInitializationSettings('app_icon');
    var initializationSettingsIOS = IOSInitializationSettings();

    var initializationSettings = InitializationSettings(
        initializationSettingsAndroid, initializationSettingsIOS);

    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    showDialog(
        context: context,
        builder: (_) => AlertDialog(
              title: Text("Here is your payload"),
              content: Text("Payload: $payload"),
            ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Plugin Example App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: [
//            RaisedButton(
////              onPressed: _showNotificationWithSound,
////              child: Text('Show Notification with sound'),
////            ),
////            SizedBox(
////              height: 30,
////            ),
            RaisedButton(
              onPressed: showNotificationWithoutSound,
              child: Text('Show Notification without sound'),
            ),
            SizedBox(
              height: 30,
            ),
            RaisedButton(
              onPressed: showNotificationsWithDefaultSound,
              child: Text('Show Notification with default sound'),
            ),
          ],
        ),
      ),
    );
  }

  Future showNotificationsWithDefaultSound() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'notification_channel_id',
        'Channel Name',
        'Here we will put the description about the Channel',
        importance: Importance.Max,
        priority: Priority.Max);

    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, 'Old Post',
        'How to Show Notification in Flutter', platformChannelSpecifics,
        payload: 'Default_Sound');
  }

  Future showNotificationWithoutSound() async {
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        'notification_channel_id',
        'Channel Name',
        'Here we will put the description about the Channel',
        importance: Importance.Max,
        priority: Priority.Max,
        playSound: false);

    var iOSPlatformChannelSpecifics =
        IOSNotificationDetails(presentSound: false);
    var platformChannelSpecifics = NotificationDetails(
        androidPlatformChannelSpecifics, iOSPlatformChannelSpecifics);
    await flutterLocalNotificationsPlugin.show(0, 'New Post',
        'How to Show Notification in Flutter', platformChannelSpecifics,
        payload: 'No_Sound');
  }
}
