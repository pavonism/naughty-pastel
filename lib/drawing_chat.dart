import 'dart:math';

import 'package:flutter/material.dart';

class ChatBox extends StatefulWidget {
  final String randomWord;
  const ChatBox({Key? key, required this.randomWord}) : super(key: key);

  @override
  _ChatBoxState createState() => _ChatBoxState();
}

class _ChatBoxState extends State<ChatBox> {
  final chatList = <String>[];
  final chatController = TextEditingController();
  late FocusNode chatFocusNode;

  @override
  void initState() {
    super.initState();
    chatFocusNode = FocusNode();
  }

  void addAnswer(phrase) {
    chatFocusNode = FocusNode();

    if (phrase != '') {
      setState(() {
        chatList.add(phrase);
      });
    }

    if (phrase.toString().toLowerCase() == widget.randomWord.toLowerCase()) {
      setState(() {
        chatList.add('You\'ve won!!!');
      });
    }

    chatController.clear();
    setState(() {
      chatFocusNode.requestFocus();
    });
  }

  Widget chatHistory() {
    return ListView.builder(
      itemExtent: 20.0,
      reverse: true,
      itemCount: chatList.length + 1,
      padding: const EdgeInsets.all(2),
      itemBuilder: (context, i) {
        // if (i.isOdd) {
        //   return const Divider(
        //     height: 0,
        //   );
        // }
        i--;

        if (i == -1) {
          return const ListTile(
              title: Text('', style: TextStyle(fontSize: 12)));
        }
        // final index = i ~/ 2;
        // if (i > chatList.length || i == -1) {
        //   return const Divider();
        // }

        return ListTile(
            title: Text(chatList[chatList.length - i - 1],
                style: const TextStyle(fontSize: 12)));
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 50;

    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Expanded(child: chatHistory()),
            TextField(
                focusNode: chatFocusNode,
                controller: chatController,
                textInputAction: TextInputAction.go,
                // controller: AnswerControler,
                onSubmitted: addAnswer,
                style: const TextStyle(fontSize: 12),
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: EdgeInsets.all(height),
                  border: const OutlineInputBorder(),
                  hintText: 'It\'s...',
                ))
          ],
        ));
  }
}
