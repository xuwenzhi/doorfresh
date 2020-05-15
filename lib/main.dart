import 'package:flutter/material.dart';

import 'tab_container.dart';
import 'package:custom_splash/custom_splash.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
// This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: CustomSplash(
        imagePath: 'assets/images/beauty.jpg',
        backGroundColor: Colors.pinkAccent,
        animationEffect: 'zoom-out',
        logoSize: 1800,
        home: TabContainer(),
        customFunction: null,
        duration: 4000,
        type: CustomSplashType.StaticDuration,
        //outputAndHome: op,
    )
    );
  }
}