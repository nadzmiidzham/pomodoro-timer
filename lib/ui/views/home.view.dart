import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/constants/timer.constant.dart';
import 'package:pomodoro_timer/ui/viewmodels/base.viewmodel.dart';
import 'package:pomodoro_timer/ui/viewmodels/timer.viewmodel.dart';
import 'package:pomodoro_timer/ui/views/base.view.dart';
import 'package:pomodoro_timer/ui/widgets/set-timer.widget.dart';
import 'package:pomodoro_timer/ui/widgets/timer.widget.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BaseView<TimerViewModel>(
      onInit: (viewModel) {
        viewModel.initTimeSetting();
      },
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: Text('Pomodoro Timer'),
        ),
        body: Container(
          child: viewModel.state == ViewState.BUSY
            ? CircularProgressIndicator()
            : viewModel.isActive
              ? TimerWidget(
                  title: viewModel.isFocus? TimerConstant.TIMER_TITLE_FOCUS : TimerConstant.TIMER_TITLE_REST,
                  timerDuration: Duration(minutes: viewModel.isFocus? viewModel.focusTime : viewModel.restTime),
                  timerFinishedCallback: () {
                    print('Timer Finished');
                  },
                )
              : SetTimerWidget(
                focusTime: viewModel.focusTime,
                restTime: viewModel.restTime,
                playTimerCallback: (focusValue, restValue) async {
                  viewModel.saveTimerSetting(focusValue, restValue);
                  viewModel.changeMode();
                },
              ),
        ),
      ),
    );
  }
}
