import 'dart:async';
import 'package:flutter/material.dart';
import 'sketcher.dart';

class DrawingScreen extends StatefulWidget {
  const DrawingScreen({Key? key}) : super(key: key);

  @override
  _DrawingScreenState createState() => _DrawingScreenState();
}

class _DrawingScreenState extends State<DrawingScreen> {
  final GlobalKey _globalKey = GlobalKey();
  final sketchStreamControler = StreamController<List<SinglePath>>.broadcast();
  final lineStreamControler = StreamController<SinglePath>.broadcast();

  final sketches = <SinglePath>[];
  late double maxHeight;
  late double maxWidth;

  _DrawingScreenState() {
    sketches.add(
        SinglePath(List.generate(1, (index) => Offset.zero), Colors.red, 2.0));
  }

  void panStart(DragStartDetails details) {
    print("drawing started");
    final box = context.findRenderObject() as RenderBox;
    final point = box.globalToLocal(details.globalPosition);

    sketches
        .add(SinglePath(List.generate(1, (index) => point), Colors.red, 2.0));

    lineStreamControler.add(sketches.last);
  }

  void panUpdate(DragUpdateDetails details) {
    final box = context.findRenderObject() as RenderBox;
    Offset point = box.globalToLocal(details.globalPosition);

    // if (point.dy < -2) point = Offset(point.dx, -1);
    // if (point.dx < -3) point = Offset(-3, point.dy);
    // if (point.dx > maxWidth) point = Offset(maxWidth - 5, point.dy);

    if (point.dy < -3) {
      sketchStreamControler.add(sketches);
      return;
    }

    sketches.last.path.add(point);
    lineStreamControler.add(sketches.last);

    print(point);
  }

  void panDown(DragDownDetails details) {
    print("drawing ended");
    sketchStreamControler.add(sketches);
  }

  Widget buildSketch(BuildContext context) {
    return RepaintBoundary(
      child: Container(
          key: _globalKey,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          color: Colors.transparent,
          padding: EdgeInsets.all(4.0),
          alignment: Alignment.topLeft,
          child: StreamBuilder(
              stream: sketchStreamControler.stream,
              builder: (context, snapshot) {
                return CustomPaint(painter: Brush(sketches: sketches));
              })),
    );
  }

  Widget buildLine(BuildContext context) {
    return GestureDetector(
        onPanStart: panStart,
        onPanUpdate: panUpdate,
        onPanDown: panDown,
        child: RepaintBoundary(
            child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.all(4.0),
          alignment: Alignment.topLeft,
          color: Colors.transparent,
          // child: CustomPaint(painter: Brush())
          child: StreamBuilder<SinglePath>(
              stream: lineStreamControler.stream,
              builder: (context, snapshot) {
                return CustomPaint(painter: Brush(sketches: [sketches.last]));
              }),
        )));
  }

  @override
  Widget build(BuildContext context) {
    maxHeight = MediaQuery.of(context).size.height;
    maxWidth = MediaQuery.of(context).size.width;

    return Scaffold(
        backgroundColor: Colors.yellow[50],
        body: Stack(
          children: [buildSketch(context), buildLine(context)],
        ));
  }
}
