import 'dart:io';
import 'package:flutter/material.dart';
import 'drawing_screen.dart';
import 'drawing_chat.dart';
import 'drawing_bar.dart';
import 'package:english_words/english_words.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NaughtyPastel',
      home: const MainScreen(),
      routes: <String, WidgetBuilder>{
        '/game': (BuildContext context) => const GamingScreen(),
      },
    );
  }
}

class MainScreen extends StatelessWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Align(
            alignment: Alignment.center,
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              ElevatedButton(
                  child: const Text('Start Game'),
                  onPressed: () {
                    Navigator.pushReplacementNamed(
                      context,
                      '/game',
                    );
                  }),
              const SizedBox(height: 10),
              ElevatedButton(onPressed: () {}, child: const Text('Options')),
              const SizedBox(height: 10),
              ElevatedButton(
                  onPressed: () => exit(0), child: const Text('Exit')),
            ])));
  }
}

class GamingScreen extends StatefulWidget {
  const GamingScreen({Key? key}) : super(key: key);

  @override
  _GamingScreenState createState() => _GamingScreenState();
}

class _GamingScreenState extends State<GamingScreen> {
  final String word = WordPair.random().first.toUpperCase();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DrawingBar(
          randomWord: word,
        ),
        const Expanded(child: DrawingScreen()),
        Expanded(
            child: ChatBox(
          randomWord: word,
        ))
      ],
    );
  }
}
