import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Opacity(
              opacity: 0.5,
            ),
            Column(
              children: [
                Text('t20 app'),
                Text('will help you reduce eye strain'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
