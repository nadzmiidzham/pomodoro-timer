import 'package:flutter/material.dart';
import 'package:pomodoro_timer/ui/viewmodels/timer.viewmodel.dart';
import 'package:pomodoro_timer/ui/widgets/set-timer.widget.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Container(
        child: Consumer<TimerViewModel>(
          builder: (context, provider, child) {
            return SetTimerWidget(
              focusTime: provider.focusTime,
              restTime: provider.restTime,
              playTimerCallback: (focusValue, restValue) {
                provider.saveTimerSetting(focusValue, restValue);
                print('Focus Value: $focusValue, Rest Value: $restValue');
              },
            );
          },
        ),
      ),
    );
  }
}
