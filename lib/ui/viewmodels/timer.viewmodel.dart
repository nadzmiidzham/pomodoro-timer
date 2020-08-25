import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:pomodoro_timer/core/models/timer.model.dart';
import 'package:pomodoro_timer/core/services/timer.service..dart';

enum TimerMode {
  ACTIVE,
  INACTIVE
}

class TimerViewModel extends ChangeNotifier {
  TimerService _timerService = GetIt.instance<TimerService>();
  TimerMode mode = TimerMode.INACTIVE;
  TimerModel timer = TimerModel(focus: 25, rest: 5);

  constructor() async {
    timer = await _timerService.getTimerSetting() ?? TimerModel(focus: 25, rest: 5);
  }

  // getter
  bool get isFocus { return true; }
  int get focusTime { return timer.focus; }
  int get restTime { return timer.rest; }

  // setter
  set isFocus(bool isFocus) { this.isFocus = isFocus; }

  // action methods
  changeMode() async {
    switch(mode) {
      case TimerMode.INACTIVE:
        mode = TimerMode.ACTIVE;
        break;
      case TimerMode.ACTIVE:
        mode = TimerMode.INACTIVE;
        break;
    }

    notifyListeners();
  }

  changeInterval() {
    isFocus = !isFocus;
    notifyListeners();
  }

  saveTimerSetting(int focusDuration, int restDuration) async {
    if(await _timerService.saveTimerSetting(focusDuration, restDuration)) {
      timer = await _timerService.getTimerSetting();
    }

    notifyListeners();
  }
}
