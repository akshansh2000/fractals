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
        statusBarColor: Colors.white,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: AppBody(),
      ),
    );
  }
}

class AppBody extends StatefulWidget {
  AppBody({Key key}) : super(key: key);

  @override
  _AppBodyState createState() => _AppBodyState();
}

class _AppBodyState extends State<AppBody> {
  double angle = 0, height = 0;
  Size size;

  @override
  Widget build(BuildContext context) {
    size = MediaQuery.of(context).size;

    return Stack(
      children: <Widget>[
        Align(
          alignment: Alignment.bottomCenter,
          child: customSlider(),
        ),
        Align(
          alignment: Alignment.centerRight,
          child: customSlider(shouldRotate: true),
        ),
        Padding(
          padding: EdgeInsets.all(size.width / 5 * 2),
          child: CustomPaint(
            child: null,
          ),
        ),
      ],
    );
  }

  Widget customSlider({bool shouldRotate = false}) {
    return RotatedBox(
      quarterTurns: shouldRotate ? -1 : 0,
      child: Container(
        width: size.width / 1.5,
        height: size.width / 5,
        child: Slider(
          value: shouldRotate ? height : angle,
          onChanged: (newValue) => setState(
            () => shouldRotate ? height = newValue : angle = newValue,
          ),
        ),
      ),
    );
  }
}
