import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pomodoro_timer/core/services/timer.service..dart';
import 'package:pomodoro_timer/ui/viewmodels/timer.viewmodel.dart';
import 'package:pomodoro_timer/ui/views/home.page.dart';
import 'package:provider/provider.dart';

void main() {
  // register singleton
  GetIt.I.registerSingleton(TimerService());

  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => TimerViewModel())
    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pomodoro Timer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: HomePage(),
    );
  }
}
