import 'package:flutter/material.dart';
import 'package:pomodoro_timer/ui/widgets/set-timer.widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(
        child: SetTimerWidget(
          minValue: 25,
          maxValue: 50,
          playTimerCallback: (focusValue, restValue) {
            print('Focus Value: $focusValue, Rest Value: $restValue');
          },
        ),
      ),
    );
  }
}
