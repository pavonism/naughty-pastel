import 'dart:async';

import 'package:flutter/material.dart';

class DrawingBar extends StatefulWidget {
  final String randomWord;
  const DrawingBar({Key? key, required this.randomWord}) : super(key: key);

  @override
  _DrawingBarState createState() => _DrawingBarState();
}

class _DrawingBarState extends State<DrawingBar> {
  int gameTime = 120;
  int timerFlag = 0;
  late double height;

  void timer() {
    if (timerFlag == 0) {
      timerFlag = 1;
      Timer(const Duration(seconds: 1), () {
        timerFlag = 0;
        setState(() {
          gameTime--;
        });
      });
    }
  }

  formatSeconds(seconds) => Duration(seconds: seconds)
      .toString()
      .split('.')
      .first
      .split(':')
      .getRange(1, 3)
      .join(':');

  Widget printTimer() {
    if (gameTime > 0) {
      timer();
    }

    return Text(
      formatSeconds(gameTime),
      style: TextStyle(fontSize: height * 0.02),
    );
  }

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    return AppBar(
      toolbarHeight: height / 20,
      centerTitle: true,
      title: Text(widget.randomWord, style: TextStyle(fontSize: height * 0.03)),
      actions: [
        Padding(
            padding: EdgeInsets.only(top: height / 80, right: 20),
            child: printTimer())
      ],
    );
  }
}
