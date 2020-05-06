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
        statusBarColor: Colors.white10,
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
  double angle = pi / 4, height = 5;
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white10,
      body: CustomPaint(
        painter: FractalPainter(),
        child: Container(),
      ),
      bottomNavigationBar: Container(
        height: size.height / 6,
        child: BottomAppBar(
          elevation: 0,
          color: Colors.white,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              customSlider(),
              customSlider(isHeight: true),
            ],
          ),
        ),
      ),
    );
  }

  Widget customSlider({bool isHeight = false}) {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Icon(
            isHeight ? Icons.linear_scale : Icons.rotate_90_degrees_ccw,
          ),
        ),
        Slider(
          min: 0,
          max: isHeight ? 30 : pi,
          activeColor: Colors.red[400],
          inactiveColor: Colors.grey[200],
          value: isHeight ? height : angle,
          onChanged: (newValue) => setState(
            () => isHeight ? height = newValue : angle = newValue,
          ),
        ),
      ],
    );
  }
}

class FractalPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {}

  @override
  bool shouldRepaint(FractalPainter oldDelegate) => false;

  @override
  bool shouldRebuildSemantics(FractalPainter oldDelegate) => false;
}
