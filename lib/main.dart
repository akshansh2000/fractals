import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'dart:math';

main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.white,
        statusBarColor: Colors.grey[900],
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return SafeArea(
      child: AppBody(),
    );
  }
}

class AppBody extends StatefulWidget {
  AppBody({Key key}) : super(key: key);

  @override
  _AppBodyState createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  double angle = pi / 4, height = 10, scale = 0.5;
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: Transform.scale(
        scale: scale,
        child: CustomPaint(
          painter: FractalPainter(height, angle),
          child: Container(),
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        elevation: 0,
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            customSlider(),
            customSlider(isHeight: true),
            customSlider(isScale: true),
          ],
        ),
      ),
    );
  }

  Widget customSlider({bool isHeight = false, bool isScale = false}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Icon(
            isHeight
                ? Icons.linear_scale
                : isScale ? Icons.zoom_in : Icons.rotate_90_degrees_ccw,
          ),
        ),
        Slider(
          min: 0,
          max: isHeight ? 20 : isScale ? 1 : pi,
          activeColor: Colors.red[400],
          inactiveColor: Colors.grey[200],
          value: isHeight ? height : isScale ? scale : angle,
          onChanged: (newValue) => setState(
            () => isHeight
                ? height = newValue
                : isScale ? scale = newValue : angle = newValue,
          ),
        ),
      ],
    );
  }
}

int counter = 0;

class FractalPainter extends CustomPainter {
  Canvas _canvas;
  Paint _paint;
  double _height, _angle;

  FractalPainter(this._height, this._angle);

  @override
  void paint(Canvas canvas, Size size) {
    _canvas = canvas;
    _paint = Paint()
      ..color = Colors.brown[800]
      ..strokeWidth = 5
      ..strokeJoin = StrokeJoin.bevel
      ..style = PaintingStyle.stroke;

    canvas.translate(size.width / 2, size.height - 30);
    drawBranch(_height * _height);
  }

  void drawBranch(double length) {
    _canvas.drawLine(Offset(0, 0), Offset(0, -length), _paint);
    _canvas.translate(0, -length);

    if (counter == length.round()) return;

    if (length > 4) {
      _canvas.save();
      _canvas.rotate(_angle);
      ++counter;
      drawBranch(length * 0.7);
      _canvas.restore();

      _canvas.save();
      _canvas.rotate(-_angle);
      ++counter;
      drawBranch(length * 0.7);
      _canvas.restore();
    }
  }

  @override
  bool shouldRepaint(FractalPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(FractalPainter oldDelegate) => false;
}
