import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.8,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Text(
                    't20 app',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Text(
                  'Why t20?',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '20/20/20 Rule:',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  'For every 20 minutes take a 20 second break to watch something at a distance 20 feet.',
                  style: TextStyle(
                    fontSize: 25,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  '*spending hours long before a screen can make us blink less,thus taking a break whenever possible can help you reduce the stress in your eyes',
                  style: TextStyle(
                    fontSize: 18,
                  ),
                ),
                Image.network(
                  'https://tomaisrico.com.br/wp-content/uploads/2020/08/%E2%80%94Pngtree%E2%80%94businessman-sitting-on-office-chair_5325709.png',
                  semanticLabel: "man with a laptop",
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
