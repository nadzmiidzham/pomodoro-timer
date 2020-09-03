import 'package:flutter/material.dart';
import 'package:pomodoro_timer/locator.dart';
import 'package:pomodoro_timer/ui/views/home.view.dart';

void main() {
  setupLocator();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Timer',
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
