import 'package:flutter/material.dart';
import 'package:pomodoro_timer/ui/viewmodels/base.viewmodel.dart';
import 'package:pomodoro_timer/ui/viewmodels/timer.viewmodel.dart';
import 'package:pomodoro_timer/ui/views/base.view.dart';
import 'package:pomodoro_timer/ui/widgets/set-timer.widget.dart';

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
              ? SizedBox.shrink()
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
